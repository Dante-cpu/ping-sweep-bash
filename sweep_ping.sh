#!/bin/bash

# Get the current IP address and subnet
IP=$(ip route get 1 | awk '{print $7;exit}')
SUBNET=$(echo $IP | cut -d. -f1-3)

echo "Scanning subnet $SUBNET.0/24"

for i in {1..254}
do
    ping -c 1 -W 1 $SUBNET.$i >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$SUBNET.$i is up"
    fi
done
