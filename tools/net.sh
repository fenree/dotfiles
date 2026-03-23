#!/bin/sh
# sometimes i use a script like this to set up static ip quickly or to make into a service on minimal init systems that use shellscript
Name=""
Address="192.168.0.xxx/24"
Gateway="192.168.0.1"
DNS="192.168.0.xxx"

ip link set "${Name}" up               &
ip addr add "${Address}" dev "${Name}" &
ip route add default via "${Gateway}"

