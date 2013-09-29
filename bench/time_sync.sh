#!/bin/bash

for node in cephclient3 cephclient2 ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07 ceph08 ceph09 ceph10
do
    ssh $node ntpdate cephclient1
    ssh $node hwclock -w
done;


