#!/bin/bash
rm /tmp/iperf_bandwidth.txt
#mkdir -p /root/bandwidth
ipaddr=`ifconfig bond0 | grep "inet addr"| cut -f 2 -d ":" |cut -f 1 -d " "`
echo $ipaddr
iperf -s >> server_listen.txt
PID=`ps -u root | grep 'iperf'| grep -v grep | grep -v vi | grep -v dbx | grep -v tail | grep -v start | grep -v stop | sed -n 1p | awk '{print $1}'`
echo $PID
for node in ceph01 ceph02 ceph03 ceph04 ceph05 ceph06 ceph07
do
#  ssh $node rm client_bandwidth.txt 
  ssh $node iperf -c $ipaddr -i 1 -t 10 >> client_bandwidth.txt 
done
sleep 10
kill -9 $PID
#echo kill "pid = " $PID
#for node in ceph01 ceph02 ceph03 ceph04
#do
 # scp $node:/client_bandwidth.txt /root/bandwidth/${node}.log
#done

