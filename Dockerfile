###### Supervisord image
FROM qnib-fd20
MAINTAINER "Christian Kniep <christian@qnib.org>"

## supervisord
ADD yum-cache/supervisor /tmp/yum-cache/supervisor
RUN echo "2014-05-24 17:09"; yum clean all
RUN yum install -y python-meld3 python-setuptools
### Old version w/o syslog
#RUN yum install -y supervisor
### Workaround
RUN yum install -y /tmp/yum-cache/supervisor/supervisor-3.0*
RUN echo "3.0" > /usr/lib/python2.7/site-packages/supervisor/version.txt
ADD etc/supervisord.conf /etc/supervisord.conf
### \WORKAROUND
RUN rm -rf /tmp/yum-cache/supervisor
RUN mkdir -p /var/log/supervisor
RUN sed -i -e 's/nodaemon=false/nodaemon=true/' /etc/supervisord.conf
ADD root/bin/supervisor_daemonize.sh /root/bin/supervisor_daemonize.sh

