#ssh ceph09 iperf -s > server_ceph09.txt
#for node in cephclient1 cephclient2 cephclient3 ceph03 ceph04 ceph05 ceph06 ceph08
#do
#    ssh $node iperf -c 192.168.3.109 -i 1 -t 20 &;
#done;
#ssh ceph09 killall iperf
#if 1
#then
ssh ceph10 "iperf -s" > server_ceph10.txt &
echo "iperf ceph10"
for node in cephclient1 cephclient2 cephclient3 ceph03 ceph04 ceph05 ceph06 ceph08
do
    echo $node
    ssh $node iperf -c 192.168.3.110 -i 1 -t 20 &
done;
ssh ceph10 killall iperf
#else
#echo "iperf ceph11"
#ssh ceph11 "iperf -s" > server_ceph11.txt &
#for node in cephclient1 cephclient2 cephclient3 ceph03 ceph04 ceph05 ceph06 ceph08
#do
#    echo $node
#    ssh $node iperf -c 192.168.3.111 -i 1 -t 20 &
#done;
#ssh ceph11 killall iperf
#fi;
