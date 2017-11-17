echo "work for find started at " > /root/work1
date >> /root/work1
find /mnt/mail-archive-data/server235/ -type f > /mnt/mail-archive-data/server235-list.txt
date >> /root/work1
echo "work for perl import started at " >> /root/work1
/bin/rm -rf /tmp/read-mail-and-make-emailarchive.pid; perl  read-and-make-emailarchive-from-old-server.pl
date >> /root/work1
