###### Supervisord image
FROM qnib/fedora

## supervisord
RUN dnf install -y python-meld3 python-setuptools supervisor python-pip && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/supervisor/bin/start.sh /opt/qnib/supervisor/bin/
## Dumb-init
ENV DUMB_INIT_VER=1.0.0
RUN wget -qO /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VER}/dumb-init_${DUMB_INIT_VER}_amd64 && \
    chmod +x /usr/local/bin/dumb-init
RUN echo "/opt/qnib/supervisor/bin/start.sh" >> /root/.bash_history && \
    echo "tail -f /var/log/supervisor/" >> /root/.bash_history && \
    echo "supervisorctl status" >> /root/.bash_history
CMD ["/opt/qnib/supervisor/bin/start.sh", "-n"]

