##recollq -c /usr/local/src/search-engine-for-mail-archive/sample-codes/recollconfig -q $1
#recoll -t -c /mnt/sdc1/search-index-config-data/ -q $1
#recollq -n 2  -c  /mnt/sdc1/search-index-config-data/ -q "(author:deepen@technoinfotech.com AND rcpt:sanjay@technoinfotech.com )"
#query formats
#https://www.lesbonscomptes.com/recoll/usermanual/usermanual.html#RCL.SEARCH.LANG

recollq -c /mnt/sdc1/search-index-config-data/ -q $1
