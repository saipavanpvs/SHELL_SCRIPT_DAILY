#!/bin/bash

services=("nginx" "mysql" "my_custom_service")
process=("python" "node" "myscript")
echo "----- Checking Service Statuses -----"
for service in ${services[@]}
do
systemctl is-active --quiet $service
    if [ $? -eq 0 ]; then
        echo "$service is running"
    else
        echo "$service is not running
    fi
done

echo "----- Checking process Statuses -----"
for proc in ${process[@]}
do
if pgrep -f "$proc" >> /dev/null ;then
    echo "$proc is running"
else
    echo "$proc is not running"
fi
done
