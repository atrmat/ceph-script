#!/bin/bash


for node in ceph01 ceph02 ceph03 
do
    scp dstat.sh $node:/root/dstat.sh
    ssh $node chmod +x /root/dstat.sh
    ssh $node /root/dstat.sh&
done

for node in cephclient1
do
    ssh $node rados -p data bench 3600 write >> rados-$node.log&
done


