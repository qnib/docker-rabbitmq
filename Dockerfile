FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN yum install -y rabbitmq-server jq
ADD etc/consul.d/rabbitmq.json /etc/consul.d/
ADD etc/supervisord.d/rabbitmq.ini /etc/supervisord.d/
RUN rabbitmq-plugins enable rabbitmq_management
RUN rabbitmq-server -detached && \
    sleep 5 && \
    rabbitmqctl add_vhost /sensu && \
    rabbitmqctl add_user sensu pass && \
    rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

