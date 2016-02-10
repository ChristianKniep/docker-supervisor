###### Supervisord image
FROM qnib/fedora:20
MAINTAINER "Christian Kniep <christian@qnib.org>"

## supervisord
ENV DUMB_INIT_VER=1.0.0
RUN yum install -y python-meld3 python-setuptools supervisor python-pip && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/bin/start_supervisor.sh /opt/qnib/bin/
## Dumb-init
RUN apt-get install -y wget && \
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VER}/dumb-init_${DUMB_INIT_VER}_amd64 && \
    chmod +x /usr/local/bin/dumb-init
RUN echo "/bin/supervisord -c /etc/supervisord.conf" >> /root/.bash_history && \
    echo "tail -f /var/log/supervisor/" >> /root/.bash_history
CMD ["/opt/qnib/bin/start_supervisor.sh", "-n"]

