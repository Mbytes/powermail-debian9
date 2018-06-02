find /data/extrabackup/tobearchive -type f -name maildirfolder -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name *.sieve -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot.index -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot.index.cache -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot.ndex.log -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot-keywords -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot.mailbox.log -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot-uidlist -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot-uidvalidity* -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name subscriptions -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name courierimapacl -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name courierimapkeywords -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name courierimapuiddb -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot.index.log -exec rm -rfv {} \;
find /data/extrabackup/tobearchive -type f -name dovecot-uidlist -exec rm -rfv {} \;

find /data/extrabackup/tobearchive/ -type d -empty -delete -print
