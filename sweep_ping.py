#!/usr/bin/env python3

import os
import subprocess

# Get the current IP address and subnet
ip = subprocess.check_output("ip route get 1 | awk '{print $7;exit}'", shell=True).decode().strip()
subnet = ".".join(ip.split(".")[:3])

print(f"Scanning subnet {subnet}.0/24")

for i in range(1, 255):
    host = f"{subnet}.{i}"
    response = os.system(f"ping -c 1 -W 1 {host} >/dev/null 2>&1")
    if response == 0:
        print(f"{host} is up")
