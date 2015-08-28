###### Supervisord image
FROM qnib/fd20
MAINTAINER "Christian Kniep <christian@qnib.org>"

## supervisord

ENV SYSLOG_SERVER logstash.syslog.service.consul
ENV SYSLOG_PORT 5514
ENV SYSLOG_PROTO TCP

RUN yum install -y python-meld3 python-setuptools supervisor python-pip && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
RUN sed -i -e 's/nodaemon=false/nodaemon=true/' /etc/supervisord.conf
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/bin/start_supervisor.sh /opt/qnib/bin/

RUN echo "/bin/supervisord -c /etc/supervisord.conf" >> /root/.bash_history
CMD ["/opt/qnib/bin/start_supervisor.sh", "-n"]

