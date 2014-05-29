#!/bin/bash

sed -i -e 's/nodaemon=.*/nodaemon=false/' /etc/supervisord.conf 
supervisord -c /etc/supervisord.conf 
sleep 1
echo "# supervisorctl status"
supervisorctl status
