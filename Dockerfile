###### Supervisord image
FROM qnib/cos7

RUN yum install -y python-supervisor && \
    mkdir -p /var/log/supervisor && \
    echo "/bin/supervisord -c /etc/supervisord.conf" >> /root/.bash_history
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/bin/start_supervisor.sh /opt/qnib/bin/

CMD ["/opt/qnib/bin/start_supervisor.sh", "-n"]

