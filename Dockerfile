FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN yum install -y rabbitmq-server jq
ADD etc/consul.d/rabbitmq.json /etc/consul.d/
ADD etc/supervisord.d/rabbitmq.ini /etc/supervisord.d/
ADD opt/qnib/rabbitmq/bin/start.sh /opt/qnib/rabbitmq/bin/
