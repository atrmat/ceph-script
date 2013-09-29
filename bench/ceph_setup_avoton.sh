#service ceph -a stop;
for node in ceph01 ceph02 ceph03;do ssh $node "rm -rf /var/lib/ceph/osd/ceph-*/*;umount /var/lib/ceph/osd/ceph-*/ -l;";done;
ssh cephclient1 rm -rf /var/lib/ceph/mon/ceph-*/*;
ssh cephclient1 mkdir -p /var/lib/ceph/mon/ceph-a;

mkcephfs -a -c /etc/ceph/ceph.conf -k /etc/ceph/keyring.admin --mkfs

for node in cephclient2 ;do scp /etc/ceph/ceph.conf root@$node:/etc/ceph/ceph.conf;scp /etc/ceph/keyring.admin root@$node:/etc/ceph/;done;
service ceph -a start;
