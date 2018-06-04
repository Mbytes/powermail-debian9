#!/bin/bash

## setup local hostname with domainname and ifconfig/Local IP on this machine/vm

HOSTNAME=demo.technomail.xyz
IPADDR=192.163.163.124

hostname $HOSTNAME
echo "$IPADDR   $HOSTNAME" >> /etc/hosts
echo $HOSTNAME > /etc/hostname
