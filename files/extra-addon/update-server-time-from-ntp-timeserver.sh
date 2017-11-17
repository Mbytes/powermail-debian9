root@mailarchive:/usr/local/src# cat update-server-time-from-timeserver.sh 
#!/bin/sh
date
NTPDATE=/usr/sbin/ntpdate
SERVER="0.asia.pool.ntp.org 2.asia.pool.ntp.org 1.asia.pool.ntp.org "

$NTPDATE -su  0.asia.pool.ntp.org

if [ -f /sbin/hwclock ]; then
          /sbin/hwclock --systohc --directisa
          /sbin/hwclock --systohc
  fi
  date

