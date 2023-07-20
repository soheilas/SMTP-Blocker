#!/bin/bash

sysctl net.ipv4.ip_forward=1
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A OUTPUT -p tcp --dport 25 -j DROP
iptables -A INPUT -p tcp --dport 25 -j DROP
mkdir -p /etc/iptables
iptables-save > /etc/iptables/rules.v4

if ! grep -q "iptables_email_block.sh" /etc/rc.local; then
  echo "bash /root/iptables_email_block.sh" >> /etc/rc.local
fi
