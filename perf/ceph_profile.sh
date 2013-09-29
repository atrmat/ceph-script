#!/bin/bash


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
    ssh $node rados -p data bench 3600 write > /tmp/rados-$node.log&
done;


