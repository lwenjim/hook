#!/bin/bash

if [ ! -n "$1" ];then
    echo not path
    exit
fi

PATH=$1
LOG=/tmp/deploy.log
g=/usr/bin/git

echo '' >$LOG
echo $PATH 2>&1 >>$LOG
cd $PATH
/usr/bin/date >>$LOG
$g stash 2>&1 >>$LOG
$g pull 2>&1 >>$LOG
/usr/bin/cat $LOG
