#!/bin/bash

docker rm -f $(docker ps -aq); docker volume rm -f $(docker volume ls -q)
docker network prune
docker volume prune
./network.sh down
rm -rf ../SampleApplication/application/insurer/wallet
rm -rf ../SampleApplication/application/manufacturer/wallet
rm -rf ../SampleApplication/application/regulator/wallet
./network.sh up -s couchdb -ca
./network.sh createChannel

COLLECTION_CONFIG=~/BlockchainDeveloper/SampleApplication/contract/collections_config.json
if [[ -f "$COLLECTION_CONFIG" ]]; then
    ./network.sh deployCC -ccn vehicle-network -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript -cccg $COLLECTION_CONFIG
else 
    ./network.sh deployCC -ccn vehicle-network -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript
fi



