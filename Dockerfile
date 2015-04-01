###### Supervisord image
FROM qnib/cos7
MAINTAINER "Christian Kniep <christian@qnib.org>"

## supervisord
RUN yum install -y python-meld3 python-setuptools python-supervisor && \
    mkdir -p /var/log/supervisor
ADD etc/supervisord.conf /etc/supervisord.conf
ADD usr/local/bin/supervisor_daemonize.sh /usr/local/bin/supervisor_daemonize.sh

CMD /bin/supervisord -n -c /etc/supervisord.conf

