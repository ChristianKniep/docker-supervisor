###### Supervisord image
FROM qnib/fedora

## supervisord
RUN dnf install -y python-meld3 python-setuptools supervisor python-pip && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/bin/start_supervisor.sh /opt/qnib/bin/

RUN echo "/bin/supervisord -c /etc/supervisord.conf" >> /root/.bash_history && \
    echo "tail -f /var/log/supervisor/" >> /root/.bash_history
CMD ["/opt/qnib/bin/start_supervisor.sh", "-n"]

