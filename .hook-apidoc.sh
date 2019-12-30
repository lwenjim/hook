#! /bin/sh

if [ ! -n "$1" ];then
  echo not path
  exit
fi

/usr/bin/apidoc -i $1 -o /data/wwwroot/yx_course_doc/

mkdir /tmp/apidoc
cp $1 /tmp/apidoc
cp /data/wwwroot/yx_bullet /tmp/apidoc
cp /data/wwwroot/yx_bullet/apidoc.json /tmp/apidoc
cd /tmp/apidoc
/usr/bin/apidoc -i $1 -o /data/wwwroot/apidoc/