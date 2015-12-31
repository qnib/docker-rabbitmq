#!/bin/bash


/usr/sbin/rabbitmq-server >/dev/null &

sleep 5

if [ "X${RABBITMQ_VHOSTS}" != "X" ];then
    for item in $(echo ${RABBITMQ_VHOSTS} | sed -e 's/,/ /g');do
        vhost=$(echo ${item} |awk -F\: '{print $1}')
        user=$(echo ${item} |awk -F\: '{print $2}')
        pass=$(echo ${item} |awk -F\: '{print $3}')
        if [ -z ${vhost} -o -z ${user} -o -z ${pass} ];then
            echo "Please provide triple vhost:user:pass (given ${vhost}:${user}:${pass})"
            pkill beam.smp 
            pkill epmd
            exit 1
        fi
        rabbitmqctl add_vhost /${vhost} && \
        if [ $? -eq 1 ];then
            echo "Something went wrong" && \ 
            pkill beam.smp 
            pkill epmd
            exit 1
        fi
        rabbitmqctl add_user ${user} ${pass} && \
        rabbitmqctl set_permissions -p /${vhost} ${user} ".*" ".*" ".*"
    done
fi

pkill beam.smp 
pkill epmd

/usr/sbin/rabbitmq-server
