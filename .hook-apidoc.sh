#! /bin/sh

if [ ! -n "$1" ];then
  echo not path
  exit
fi

/usr/bin/apidoc -i $1 -o /data/wwwroot/yx_course_doc/

mkdir /tmp/apidoc
cp -r $1 /tmp/apidoc/course
cp -r /data/wwwroot/yx_bullet/app /tmp/apidoc/cms
cp -r /data/wwwroot/yx_bullet/apidoc.json /tmp/apidoc
cd /tmp/apidoc
/usr/bin/apidoc -i /tmp/apidoc -o /data/wwwroot/apidoc/