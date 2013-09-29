#!/bin/bash

ceph_node_id=0
fstype="xfs"

service ceph -a stop
for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07
do
    ssh $node killall ceph-osd
done;

for node in ceph05 ceph06 ceph07
do
    ssh $node killall ceph-mon
done;

for node in ceph08
do
    ssh $node killall ceph-mds
done;

for node in ceph01 
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdd
    ssh $node mount -t $fstype /dev/sdd /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdf
    ssh $node mount -t $fstype /dev/sdf /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;


for node in ceph02
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdd
    ssh $node mount -t $fstype /dev/sdd /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdg
    ssh $node mount -t $fstype /dev/sdg /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;

for node in ceph03
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdd
    ssh $node mount -t $fstype /dev/sdd /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdf
    ssh $node mount -t $fstype /dev/sdf /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;


for node in ceph04 
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdd
    ssh $node mount -t $fstype /dev/sdd /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdf
    ssh $node mount -t $fstype /dev/sdf /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;

for node in ceph05
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sde
    ssh $node mount -t $fstype /dev/sde /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdf
    ssh $node mount -t $fstype /dev/sdf /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;

for node in ceph06
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdd
    ssh $node mount -t $fstype /dev/sdd /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdf
    ssh $node mount -t $fstype /dev/sdf /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;

for node in ceph07
do
    ssh $node umount /var/lib/ceph/osd/*
    ssh $node rm -rf /var/lib/ceph/osd/*

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sda
    ssh $node mount -t $fstype /dev/sda /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdb
    ssh $node mount -t $fstype /dev/sdb /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sde
    ssh $node mount -t $fstype /dev/sde /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]

    ssh $node mkdir -p /var/lib/ceph/osd/ceph-$ceph_node_id
    ssh $node mkfs -t $fstype -f /dev/sdf
    ssh $node mount -t $fstype /dev/sdf /var/lib/ceph/osd/ceph-$ceph_node_id
    ceph_node_id=$[$ceph_node_id+1]
done;


ceph_node_id=1

ssh ceph05 rm -rf /var/lib/ceph/mon/ceph-a/*
ssh ceph05 mkdir -p /var/lib/ceph/mon/ceph-a
ssh ceph06 rm -rf /var/lib/ceph/mon/ceph-b/*
ssh ceph06 mkdir -p /var/lib/ceph/mon/ceph-b
ssh ceph07 rm -rf /var/lib/ceph/mon/ceph-c/*
ssh ceph07 mkdir -p /var/lib/ceph/mon/ceph-c
ssh ceph08 rm -rf /var/lib/ceph/mds/ceph-1/*

