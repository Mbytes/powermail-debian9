## remove empty directory as all archive mail is synced to local server
find /mail-archive-uncompress/ -type d -empty -delete -print
mkdir /mail-archive-uncompress/ 2>/dev/null
chmod 777 /mail-archive-uncompress/

