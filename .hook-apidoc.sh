#! /bin/sh

if [ ! -n "$1" ];then
  echo not path
  exit
fi


/usr/bin/apidoc -i $1 -o /data/wwwroot/yx_course_doc/
