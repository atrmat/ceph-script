#!/bin/bash

rm -rf /root/dstat
mkdir -p /root/dstat

for node in ceph01 ceph02 ceph03 
do
    #ssh $node killall iostat
    ssh $node killall python
    scp $node:/tmp/dstat.csv /root/dstat/$node.csv
done

for node in cephclient1 
do
    ssh $node killall rados

    echo "sec,ops,started,finished,avgMB/s,curMB/s,last-lat,avg-lat" >> rados-$node.csv
    grep -vE 'sec|max' /root/scripts/rados-$node.log | gawk '{printf "%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$2,$3,$4,$5,$6,$7,$8}' >> rados-$node.csv
done



