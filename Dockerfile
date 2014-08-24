###### Supervisord image
FROM qnib/fd20
MAINTAINER "Christian Kniep <christian@qnib.org>"

## supervisord
RUN yum install -y python-meld3 python-setuptools python-supervisor
ADD etc/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor
RUN sed -i -e 's/nodaemon=false/nodaemon=true/' /etc/supervisord.conf
ADD usr/local/bin/supervisor_daemonize.sh /usr/local/bin/supervisor_daemonize.sh

