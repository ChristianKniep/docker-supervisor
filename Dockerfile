###### Supervisord image
FROM qnib/cos7

RUN echo "2015-11-15.1" && yum clean all && \
    yum install -y supervisor && \
    mkdir -p /var/log/supervisor && \
    echo "/bin/supervisord -c /etc/supervisord.conf" >> /root/.bash_history
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/bin/start_supervisor.sh /opt/qnib/bin/

CMD ["/opt/qnib/bin/start_supervisor.sh", "-n"]

