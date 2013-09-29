#!/bin/sh
for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07 ceph08 cephclient2 cephclient3
do
	ssh $node "shutdown -h now"&
done;
