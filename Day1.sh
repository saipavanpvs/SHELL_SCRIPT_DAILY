### check the disk usage and send the mail if the usage is more than 90%
#!/bin/bash 
# Get the disk usage percentage
disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
for i in $disk_usage;do
if [ "$i" -gt 90 ]; then
  echo "Disk usage is above 90% for  ${disk_usage}%"
  # Send an email notification (replace with your email command)
  echo "Disk usage is above 90% on $(hostname): $disk_usage%" | mail -s "Disk Usage Alert" user@example.com
fi  
done
# Check if the disk usage command was successful

# End of script
echo "Disk usage check completed."
exit 0
# This script checks the disk usage and sends an email alert if it exceeds 90%.
# Make sure to replace 'user@example.com' with the actual email address you want to use.


#########Print the disk details as well along with the Disk usgae greater than 90 #####
#Filesystem      Size  Used Avail Use% Mounted on
#devtmpfs        4.0M     0  4.0M   0% /dev
#tmpfs           2.0G     0  2.0G   0% /dev/shm



#!bin/bash
df -h | awk 'NR>1 {
  sub(/%/, "", $5);
  if ($5 > 90)
    print "High disk usage on " $1 " (" $6 "): " $5 "% used"
}'

