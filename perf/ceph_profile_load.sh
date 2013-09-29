#!/bin/bash

rados rmpool test test  --yes-i-really-really-mean-it
rados mkpool test

for node in shzceph01 shzceph02 shzceph03
do
    scp /etc/ceph/ceph.conf root@$node:/etc/ceph/
    scp /etc/ceph/keyring.admin root@$node:/etc/ceph/
done;

for node in shzceph01 shzceph02 shzceph03
do
    scp dstat.sh $node:/root/dstat.sh
    ssh $node chmod +x /root/dstat.sh
    ssh $node /root/dstat.sh&
done;

for node in shzcephmon01
do
    ssh $node rados -p test load-gen --num-objects 10000 --min-ops 50 --max-ops 1000 --percent 70 --target-throughput 100 --run-length 1200 2>&1 | tee /tmp/rados_load-gen.log
done;

rados rmpool test test  --yes-i-really-really-mean-it

rm -rf /root/bench/*
mkdir -p /root/bench/

for node in shzceph01 shzceph02 shzceph03
do
    #ssh $node killall iostat
    ssh $node killall python
    scp $node:/tmp/dstat.csv /root/bench/dstat_$node.csv
done
mv /tmp/rados_load-gen.log /root/bench/
mv /root/bench/ /root/bench_load`date +%Y-%m-%d*%H:%M`

