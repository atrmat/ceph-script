#!/bin/bash

for cephnode in ceph01 ceph02 ceph03 ceph04
do
    scp ceph_osd_cpu.sh $cephnode:/root/ceph_osd_cpu.sh
done;


while [ 1 -gt 0 ]
do
for cephnode in ceph01 ceph02 ceph03 ceph04
do
  echo `date` >> /root/cpu.log
  ssh -t $cephnode sh /root/ceph_osd_cpu.sh
done;
sleep 10s
done;
