#!/bin/bash
### check if the services and processes are running in the server#####
# Key Differences
# Services are background programs managed by the system and usually designed to stay running ("daemonized"). You can control and check them easily with commands like systemctl status <service-name>.

# Regular processes are any programs you start from the command line or another program. They exit when finished and aren't automatically restarted or managed by the system.

# In summary:
# # Managing applications as services provides better control, automated restarts, easier monitoring, and integration with system tools for status checks. Regular processes require manual oversight and intervention if they fail or stop.


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
