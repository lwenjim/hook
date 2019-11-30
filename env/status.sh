#!/usr/bin/env bash

rm -f env/config/hosts
cp -f /etc/hosts env/config/hosts

rm -rf env/config/nginx
mkdir env/config/nginx
scp -r root@localdev:/usr/local/nginx/conf/vhost/* env/config/nginx


rm -rf env/config/apache
mkdir env/config/apache
scp -r root@localdev:/usr/local/apache/conf/vhost/* env/config/apache/

rm -f env/config/host-dev
scp -r root@localdev:/etc/hosts env/config/hosts-dev