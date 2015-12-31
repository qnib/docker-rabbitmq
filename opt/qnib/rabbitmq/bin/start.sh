#!/bin/bash


if [ "X${RABBITMQ_VHOSTS}" != "X" ];then
    for item in $(echo ${RABBITMQ_VHOSTS} | sed -e 's/,/ /g');do
        vhost=$(echo ${item} |awk -F\: '{print $1}')
    done
fi
