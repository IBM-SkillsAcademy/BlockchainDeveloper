#!/bin/bash
echo "Configure CA Container $1" 

CA_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ca_$1`
echo "IP of CA ( ca_$2 ) server ${CA_IP}"
count=`cat /etc/hosts | sed -n "/ca_$1/p" | wc -l`
echo "-------START -----Adding CA server IP to hosts file"
if [ "${count}" -gt 0 ]
then
   echo "CA exists in hosts file Replace"
   echo bl0ckchain | sudo -S sed -i "/ca_$1/c\ ${CA_IP}  ca_$1" /etc/hosts
else
   echo "CA doesn't exist in Hosts"
   echo bl0ckchain | sudo -S sed -i "1i ${CA_IP} ca_$1" /etc/hosts    
fi
echo "------- END  -----Adding CA server IP to hosts file"
