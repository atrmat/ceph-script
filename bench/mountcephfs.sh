#!/bin/bash
# test under ceph 0.67.4

cephfs_mnt="/mnt/cephfs"
if [ ! -d "$cephfs_mnt" ]
then
        mkdir -p "$cephfs_mnt"
else
        umount "$cephfs_mnt"
fi
mount -t ceph `cat /etc/hostname`:6789:/ "$cephfs_mnt" -vv -o name=admin,secret=`cat /etc/ceph/keyring.admin | grep "key" | gawk -F " " '{gsub(/[[:blank:]]*/,"",$3);print $3}'`
