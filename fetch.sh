#!/usr/bin/env bash

BASE_PATH=$(cd `dirname $0`; pwd)

queues=(
    '.hook.sh'
    '.hook.php'
    '.hook-apidoc.sh'
)

for queue in "${queues[@]}" ; do
    config=($queue);
    cmd="scp root@dev2:/data/wwwroot/gitlab_webhook/${config[0]} $BASE_PATH/${config[0]}"
    echo -e "$cmd\n"
    $cmd
done