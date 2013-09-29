#!/bin/bash

ceph_node_id=0
fstype="xfs"

for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07 ceph08
do
    ssh $node killall ceph-osd
    ssh $node killall ceph-mds
    ssh $node killall ceph-mon
done;


for node in ceph01
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    for device in sda sdb sdd 
    do
        ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
        ssh $node mkfs -t $fstype -f /dev/$device
        ssh $node mount -t $fstype /dev/$device /var/lib/ceph/osd/ceph-$ceph_node_id
        ceph_node_id=$[$ceph_node_id+1]
    done

done;

for node in ceph02
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    for device in sda sdb sdd
    do
        ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
        ssh $node mkfs -t $fstype -f /dev/$device
        ssh $node mount -t $fstype /dev/$device /var/lib/ceph/osd/ceph-$ceph_node_id
        ceph_node_id=$[$ceph_node_id+1]
    done

done;

for node in ceph03
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    for device in sda sdb sdd
    do
        ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
        ssh $node mkfs -t $fstype -f /dev/$device
        ssh $node mount -t $fstype /dev/$device /var/lib/ceph/osd/ceph-$ceph_node_id
        ceph_node_id=$[$ceph_node_id+1]
    done

done;

for node in ceph04
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    for device in sda sdb sde
    do
        ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
        ssh $node mkfs -t $fstype -f /dev/$device
        ssh $node mount -t $fstype /dev/$device /var/lib/ceph/osd/ceph-$ceph_node_id
        ceph_node_id=$[$ceph_node_id+1]
    done

done;

for node in ceph05
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    for device in sda sdb sdd 
    do
        ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
        ssh $node mkfs -t $fstype -f /dev/$device
        ssh $node mount -t $fstype /dev/$device /var/lib/ceph/osd/ceph-$ceph_node_id
        ceph_node_id=$[$ceph_node_id+1]
    done

done;


ceph_node_id=1
ssh ceph08 rm -rf /var/lib/ceph/mon/ceph-a/*
ssh ceph08 mkdir -p /var/lib/ceph/mon/ceph-a
ssh ceph08 rm -rf /var/lib/ceph/mds/ceph-1/*

for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07 ceph08 cephclient3
do
    scp /etc/ceph/ceph.conf $node:/etc/ceph/ceph.conf
done;

mkcephfs -a -c /etc/ceph/ceph.conf -k /etc/ceph/keyring.admin

for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07 ceph08 cephclient3 
do
    scp /etc/ceph/keyring.admin $node:/etc/ceph/keyring.admin
done;

service ceph -a start
