#ceph osd pool create fortest_pg50 50
#rados -p fortest_pg50 bench 600 write > rados1_pg50.log&
#ssh ceph08 rados -p fortest_pg50 bench 600 write > rados2_pg50.log&
#rados rmpool fortest_pg50
ceph osd pool create fortest_pg1050 1050
pg=1050pg
bench=21osd
mkdir /root/rados/21osd/
cd /root/rados/21osd/
for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07
do
	ssh $node "rm /tmp/dstat_$pg_$node.csv;dstat -cdmnrtgs --output /tmp/dstat_$pg"_"$node.csv "& 
	ssh $node "rm /tmp/iostat_$pg_$node.log;iostat -dzmxt 1 >> /tmp/iostat_$pg"_"$node.log "&
done
rados -p fortest_pg1050 bench 3600 write > rados_pg1050.log
mkdir /root/rados/$bench/dstat/
mkdir /root/rados/$bench/iostat/
for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07
do
	ssh $node "killall python; killall iostat"
	scp $node:/tmp/dstat_$pg"_"$node.csv /root/rados/$bench/dstat/
	scp $node:/tmp/iostat_$pg"_"$node.log /root/rados/$bench/iostat/
done
#ssh ceph08 rados -p fortest_pg1050 bench 1800 write > rados2_pg1050.log&
#rados rmpool fortest_pg1050
