#!/bin/bash

sed -i -e 's/nodaemon=.*/nodaemon=false/' /etc/supervisord.conf

## DISABLE services if demanded (via comma separated list in SUPERVISOR_SKIP_SRV)
for srv in $(echo ${SUPERVISOR_SKIP_SRV}|tr "," " ");do
    if [ -f /etc/supervisord.d/${srv}.ini ];then
        if grep autostart /etc/supervisord.d/${srv}.ini;then
            sed -i'' -e 's/^autostart.*/autostart=false/' /etc/supervisord.d/${srv}.ini
        else
            sed -i'' '/^command/a autostart=false' /etc/supervisord.d/${srv}.ini
        fi
    else
        echo "ERR> could not find service '${srv}' (/etc/supervisord.d/${srv}.ini) to disable it"
    fi
done

## Fire up script outside of supervisor
if [ "X${SUPERVISOR_START_EXTERNAL}" != "X" ];then
    if [ -x ${SUPERVISOR_START_EXTERNAL} ];then
        ${SUPERVISOR_START_EXTERNAL} &
    else
        echo "Sorry, '${SUPERVISOR_START_EXTERNAL}' has to ba a file and executable..."
    fi
fi

if [ "X$1" == "X" ];then
    supervisord -c /etc/supervisord.conf
   sleep 5
   echo "# supervisorctl status"
   supervisorctl status
else
   supervisord -n -c /etc/supervisord.conf
fi
