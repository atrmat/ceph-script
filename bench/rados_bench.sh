echo "begin rados bench"

#for i in 0 1 2 3 4 5 6 7
#do
#	ceph osd tell $i bench
#done

#ceph osd pool create fortest_25pg 25
ceph osd pool create fortest_50pg 50
#ceph osd pool create fortest_75pg 75
ceph osd pool create fortest_100pg 100
#ceph osd pool create fortest_125pg 125
#ceph osd pool create fortest_150pg 150
ceph osd pool create fortest_400pg 400

for node in ceph01 ceph02 ceph03 ceph04
do
ssh $node "killall python; killall iostat"
done

for bench in write_April_23 
do
#for pg in fortest_25pg fortest_50pg fortest_75pg fortest_100pg fortest_125pg fortest_150pg
for pg in fortest_50pg fortest_100pg fortest_400pg
do
	rm rados_bench_$pg.log
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">> rados_bench_$pg.log
	echo "osd 8,rep 2 ,3600s write, pg:" >> rados_bench_$pg.log
	echo $pg >> rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	ceph -s >>rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	rados df >>rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	ceph osd dump| grep 'rep size' >>rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
        #profile the osd's memory & cpu util  	
	for node in ceph01 ceph02 ceph03 ceph04
	do
		ssh $node "rm /tmp/dstat_$pg_$node.csv;dstat -cdmnrtgs --output /tmp/dstat_$pg"_"$node.csv "& 
		ssh $node "rm /tmp/iostat_$pg_$node.log;iostat -dzmxt 1 >> /tmp/iostat_$pg"_"$node.log "&
	done
        #rados bench pool with different pg_num
	rados -p $pg bench 3600 write >> rados_bench_$pg.log
	#copy back data
	for node in ceph01 ceph02 ceph03 ceph04
	do
                ssh $node "killall python; killall iostat"
	        scp $node:/tmp/dstat_$pg"_"$node.csv /root/rados/$bench/dstat/
                scp $node:/tmp/iostat_$pg"_"$node.log /root/rados/$bench/iostat/
	done
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	ceph -s >>rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	ceph osd tree >>rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	rados df >>rados_bench_$pg.log
	echo "---------------------------------------------------------------------">> rados_bench_$pg.log
	ceph osd dump| grep 'rep size' >>rados_bench_$pg.log
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">> rados_bench_$pg.log
	mv rados_bench_$pg.log /root/rados/$bench/
done

done

#rados rmpool fortest_25pg
rados rmpool fortest_50pg
#rados rmpool fortest_75pg
rados rmpool fortest_100pg
#rados rmpool fortest_125pg
#rados rmpool fortest_150pg
rados rmpool fortest_400pg
echo "end rados bench"

#awk data
for node in ceph01 ceph02 ceph03 ceph04
do
	mkdir /root/rados/$bench/dstat/result_$node
	cd /root/rados/$bench/dstat/result_$node
	for pg in fortest_50pg fortest_100pg fortest_400pg
	do
		awk -F"," 'NR==7,NR==3607{print $3 > "cpuidle$pg";print $9 > "memused$pg"}' /root/rados/$bench/dstat/dstat_$pg"_"$node.csv
	done
done
for node in ceph01 ceph02 ceph03 ceph04
do
	mkdir /root/rados/$bench/iostat/result_$node
	cd /root/rados/$bench/iostat/
	for pg in fortest_50pg fortest_100pg fortest_400pg
	do
		echo "wMB/s,%util" >> result_$node/iostat_$pg"_"$node"_"sdb.csv
		grep "sdb" iostat_$pg"_"$node.log | gawk '{printf "%s,%s\n",$7,$14}' >> result_$node/iostat_$pg"_"$node"_"sdb.csv
		echo "wMB/s,%util" >> result_$node/iostat_$pg"_"$node"_"sde.csv
		grep "sde" iostat_$pg"_"$node.log | gawk '{printf "%s,%s\n",$7,$14}' >> result_$node/iostat_$pg"_"$node"_"sde.csv
	done
done
