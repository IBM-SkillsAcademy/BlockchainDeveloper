#!/bin/bash
echo "################## STOP NETWORK ########################"
cd ../../test-network/
./stopNetwork.sh
docker rm -f $(docker ps -aq) 
docker volume rm -f $(docker volume ls -q)
echo "stopping the applications " 
cd /home/blockchain/BlockchainDeveloper/SampleApplication/application
./stop.sh



