#!/bin/bash



#for node in ceph11
#do
#    scp dstat.sh $node:/root/dstat.sh
#    ssh $node chmod +x /root/dstat.sh
#    ssh $node /root/dstat.sh&
#done

#rados -p data bench 3600 write >> rados-cephclient1.log&
#ssh cephclient2 rados -p data bench 3600 write >> rados-cephclient2.log&

#for i in 27 28 29 30 31 32 33 34 35 36 37 38 39
#do
#    ceph osd tell $i bench
#done

for device in sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn
do
    echo $device
    ssh ceph11 dd if=/dev/zero of=/dev/$device bs=1000M count=1 conv=fdatasync
done
