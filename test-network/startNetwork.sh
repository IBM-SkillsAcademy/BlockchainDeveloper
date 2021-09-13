#!/bin/bash

docker rm -f $(docker ps -aq); docker volume rm -f $(docker volume ls -q)
docker network prune
docker volume prune
 ./network.sh up
 ./network.sh createChannel
cd addOrg3
./addOrg3.sh up
cd ..
./network.sh deployCC -ccn sampleApp -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript


