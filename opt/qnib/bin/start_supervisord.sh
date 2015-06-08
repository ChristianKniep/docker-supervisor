#!/bin/bash

if [ "x${FORWARD_TO_LOGSTASH}" == "true" ];then
    sed -i '' -e 's/^logfile=.*/logfile=syslog/' etc/supervisord.conf
fi
/bin/supervisord -n -c /etc/supervisord.conf
