#!/bin/sh

rsync -av mailbackup@idcserver.com::archivedata/* /idc-mail-archive/  --remove-source-files --password-file=/usr/local/src/make-archive-tools/livemail-rsyncpass.txt

