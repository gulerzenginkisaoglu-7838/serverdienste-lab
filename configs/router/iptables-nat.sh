#!/bin/bash
# Router: NAT (SNAT/Masquerading) und Port-Forwarding (DNAT)
# <WAN-IP> = externe IP-Adresse des Routers (per DHCP aus dem GFN-Netz)

# Aufgabe 12: ausgehender Verkehr aus dem Firmennetz -> Internet
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Aufgabe 40: eingehend Port 80 -> Reverse Proxy auf SRV2
iptables -t nat -A PREROUTING -p tcp -d <WAN-IP> --dport 80 \
  -j DNAT --to-destination 192.168.10.13:80

# Regeln dauerhaft speichern (Paket iptables-persistent)
iptables-save > /etc/iptables/rules.v4
