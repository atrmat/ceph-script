#!/bin/bash

rm -rf /root/bench/*
mkdir -p /root/bench/

for node in shzceph01 shzceph02 shzceph03
do
    #ssh $node killall iostat
    ssh $node killall python
    scp $node:/tmp/dstat.csv /root/bench/dstat_$node.csv
done


#scp ceph09:/tmp/dstat.csv /root/dstat/dstat09.csv
#scp ceph10:/tmp/dstat.csv /root/dstat/dstat10.csv
#scp ceph11:/tmp/dstat.csv /root/dstat/dstat11.csv


for node in shzcephmon01
do
    ssh $node killall rados
    echo "sec,ops,started,finished,avgMB/s,curMB/s,last-lat,avg-lat" >> /root/bench/rados-$node.csv
    echo /tmp/rados-$node.log
    grep -vE 'sec|max' /tmp/rados-$node.log | gawk '{printf "%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$2,$3,$4,$5,$6,$7,$8}' >> /root/bench/rados-$node.csv
done
rados -p data cleanup benchmark_data_
rados -p data cleanup benchmark_metadata_
mv /root/bench/ /root/bench`date +%Y-%m-%d*%H:%M`

