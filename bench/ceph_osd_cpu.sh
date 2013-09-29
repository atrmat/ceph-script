#!/bin/bash

DATE=`date +%m/%d/%Y`
TIME=`date +%k:%M:%S`

osd_process="ceph-osd"

top -n 1 > /root/top.log
if grep -q $osd_process /root/top.log
then 
  osd_virt=`grep "ceph-osd" /root/top.log | gawk '{print $5}'`
  osd_res=`grep "ceph-osd" /root/top.log | gawk '{print $6}'`
  osd_shr=`grep "ceph-osd" /root/top.log | gawk '{print $7}'`
  osd_cpu=`grep "ceph-osd" /root/top.log | gawk '{print $9}'`
  osd_mem=`grep "ceph-osd" /root/top.log | gawk '{print $10}'`
  echo "$DATE, $TIME, $osd_process, $osd_virt, $osd_res, $osd_shr, $osd_cpu, $osd_mem" >> /root/osd_process.log
fi


