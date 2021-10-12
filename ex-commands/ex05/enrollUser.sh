#!/bin/bash
echo "Register and Enrolling User $1 $2 $3 $4" 

PORT=0
if [[ $2 == "org1" ]]; then PORT=7054 
elif [[ $2 == "org2" ]]; then PORT=8054
elif [[ $2 == "org3" ]]; then PORT=11054
fi

CA_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ca_$2`
echo "IP of CA ( ca_$2 ) server ${CA_IP}"
count=`cat /etc/hosts | sed -n "/ca_$2/p" | wc -l`
echo "-------START -----Adding CA server IP to hosts file"
if [ "${count}" -gt 0 ]
then
   echo "CA exists in hosts file Replace"
   echo bl0ckchain | sudo -S sed -i "/ca_$2/c\ ${CA_IP}  ca_$2" /etc/hosts
else
   echo "CA doesn't exist in Hosts"
   echo bl0ckchain | sudo -S sed -i "1i ${CA_IP} ca_$2" /etc/hosts    
fi
echo "------- END  -----Adding CA server IP to hosts file"
echo "-------START adding client ----- "
rm -f -R $HOME/fabric-ca/client/
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca/client
mkdir  $HOME/fabric-ca/client/
echo "Copy Fabric CA Certificate to Client Folder "

cp ../../test-network/organizations/peerOrganizations/$2.example.com/ca/ca.$2.example.com-cert.pem  $HOME/fabric-ca/client/
chmod +777 -R $HOME/fabric-ca/client/

fabric-ca-client enroll -u https://admin:adminpw@ca_$2:${PORT}  --tls.certfiles ca.$2.example.com-cert.pem

ATTRS=role=$4:ecert
OUTPUT=$(fabric-ca-client register --id.type client --id.name $1 --id.affiliation $2.$3 --id.attrs ${ATTRS} --tls.certfiles ca.$2.example.com-cert.pem | tail -1)
PASSWORD=$(echo $OUTPUT | awk -F" " '{print $2}')

fabric-ca-client enroll -u https://$1:${PASSWORD}@ca_$2:${PORT}  --tls.certfiles ca.$2.example.com-cert.pem
cp -r $HOME/fabric-ca/client/msp/signcerts $HOME/fabric-ca/client/msp/admincerts

# check if directory exists from cryptogen
if [ -d "../../test-network/organizations/peerOrganizations/$2.example.com/users/$1@$2.example.com" ]; then
   rm -rf ../../test-network/organizations/peerOrganizations/$2.example.com/users/$1@$2.example.com
fi
mkdir ../../test-network/organizations/peerOrganizations/$2.example.com/users/$1@$2.example.com
cp -rf $HOME/fabric-ca/client/msp ../../test-network/organizations/peerOrganizations/$2.example.com/users/$1@$2.example.com/msp
