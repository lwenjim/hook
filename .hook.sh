#!/bin/bash

if [ ! -n "$1" ];then
    echo not path
    exit
fi

git_bin=/usr/bin/git

cd $1
$git_bin stash

if [[ "$2" == "op_web" ]]; then
    $git_bin clean -d -fx ""
fi

$git_bin pull