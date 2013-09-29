echo "begin rados bench"
ceph osd pool create fortest_25pg 25
ceph osd pool create fortest_50pg 50
ceph osd pool create fortest_75pg 75
ceph osd pool create fortest_100pg 100
ceph osd pool create fortest_125pg 125
ceph osd pool create fortest_150pg 150
bench="write" 
mkdir /root/rados/$bench/multiclient/
for size in 2 3
do
echo "rados bench client : " $size "begin"
for pg in fortest_25pg fortest_50pg fortest_75pg fortest_100pg fortest_125pg fortest_150pg
do
        #rados bench pool with different pg_num
	for count in `seq $size`
	do
		rados -p $pg bench 3600 $bench >> rados_bench_$pg"_"$size.$count &
	done
	sleep 3610 #&
	#i=$!
	#wait $i
	for count in `seq $size`
	do
		mv rados_bench_$pg"_"$size.$count /root/rados/$bench/multiclient/
	done
	#deal result into csv file
	for count in `seq $size`
	do
		echo "Bandwidth (MB/sec)" >> /root/rados/$bench/multiclient/rados_client_$pg"_"$size.csv
		grep "Bandwidth (MB/sec)"  /root/rados/$bench/multiclient/rados_bench_$pg"_"$size.$count | awk '{printf"%s\n",$3}' >> /root/rados/$bench/multiclient/rados_client_$pg"_"$size.csv
	done
done
echo "rados bench client : " $size "end"
done
rados rmpool fortest_25pg
rados rmpool fortest_50pg
rados rmpool fortest_75pg
rados rmpool fortest_100pg
rados rmpool fortest_125pg
rados rmpool fortest_150pg
echo "end rados bench"
