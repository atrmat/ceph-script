#!/bin/bash  
#Used to fomat 2 disks(1000.2T) with 4 partition
PATH=/bin:/sbin:/usr/bin:/usr/sbin
export PATH
for j in d e 
do
i=1
k=2048
# set each partition size 480000000 
t=480000000
# fdisk into 4 partition
while [ $i -lt 5 ]
do
fdisk /dev/sd$j <<ESXU
n
p
$i
$k
$t
w
ESXU
echo "sd"$j$i
i=$[i+1]
k=$[t+1]
t=$[t+480000000]
sleep 10
done;
done;
