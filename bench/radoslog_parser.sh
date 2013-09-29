#!/bin/bash

echo "sec,ops,started,finished,avgMB/s,curMB/s,last-lat,avg-lat" >> rados.csv
grep "16" /root/scripts/rados-ceph08.log | gawk '{printf "%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$2,$3,$4,$5,$6,$7,$8}' >> rados-ceph08.csv
grep "16" /root/scripts/rados-cephclient1.log | gawk '{printf "%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$2,$3,$4,$5,$6,$7,$8}' >> rados-ceph08.csv
#grep "16" /root/scripts/rados-cephclient2.log | gawk '{printf "%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$2,$3,$4,$5,$6,$7,$8}' >> rados.csv
