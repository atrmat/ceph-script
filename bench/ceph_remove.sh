#!/bin/bash



for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07 ceph08
#for node in cephclient2 cephclient3
do
    ssh $node dpkg -P radosgw
    ssh $node dpkg -P ceph
    ssh $node dpkg -P ceph-common
    ssh $node dpkg -P ceph-fs-common
    ssh $node dpkg -P ceph-fuse
    ssh $node dpkg -P ceph-mds
    ssh $node dpkg -P libcephfs1
    ssh $node dpkg -P librbd1
    ssh $node dpkg -P librados2
done

