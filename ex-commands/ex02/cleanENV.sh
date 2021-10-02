#!/bin/bash

rm -R ~/my-first-chaincode

docker rm -f $(docker ps -aq) 
docker volume rm -f $(docker volume ls -q)
count=`cat /etc/resolv.conf | sed -n "/options/p" | wc -l`
if [ "${count}" -gt 0 ]
then
 echo "remove options from /etc/resolv.conf"
  echo bl0ckchain | sudo -S sed -i "/options /c\ " /etc/resolv.conf
fi


