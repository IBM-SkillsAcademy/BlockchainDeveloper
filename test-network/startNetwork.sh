#!/bin/bash

docker rm -f $(docker ps -aq); docker volume rm -f $(docker volume ls -q)
docker network prune
docker volume prune
./network.sh down
./network.sh up -s couchdb -ca
./network.sh createChannel
./network.sh deployCC -ccn sampleApp -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript


