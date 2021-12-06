#!/bin/bash
ROOT=${PWD}
cd $ROOT

cp -R ex09Artifacts/contract/. ../../SampleApplication/contract/.
cp ex09Artifacts/docker-compose-test-net.yaml ../../test-network/docker/docker-compose-test-net.yaml
cp ex09Artifacts/core-backup.yaml ../../test-network/external-builder-config/core.yaml
echo "################## START NETWORK ########################"
cd /home/blockchain/BlockchainDeveloper/test-network

docker rm -f $(docker ps -aq); docker volume rm -f $(docker volume ls -q)
docker network prune
docker volume prune
./network.sh down
rm -rf ../SampleApplication/application/insurer/wallet
rm -rf ../SampleApplication/application/manufacturer/wallet
rm -rf ../SampleApplication/application/regulator/wallet
./network.sh up -s couchdb -ca
./network.sh createChannel


cd $ROOT

pwd
cp -R ex09Artifacts/application/insurer/api/v1/utils.js ../../SampleApplication/application/insurer/api/v1/utils.js
cp -R ex09Artifacts/application/insurer/api/v1/vehicles/controller.js ../../SampleApplication/application/insurer/api/v1/vehicles/controller.js
cp -R ex09Artifacts/application/manufacturer/api/v1/vehicles/controller.js ../../SampleApplication/application/manufacturer/api/v1/vehicles/controller.js
cp -R ex09Artifacts/application/regulator/api/v1/vehicles/controller.js ../../SampleApplication/application/regulator/api/v1/vehicles/controller.js
cp -R ex09Artifacts/application/regulator/api/v1/utils.js ../../SampleApplication/application/regulator/api/v1/utils.js

cd /home/blockchain/BlockchainDeveloper/SampleApplication/application
./start.sh
./enrollUsers.sh
echo "Network started and users enrolled ......"



