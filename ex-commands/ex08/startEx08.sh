#!/bin/bash
ROOT=${PWD}
echo "Update Contract files with Completed smart Contract"

cp -R ex08Artifacts/src/. ../../SampleApplication/contract/src/.
cp ex08Artifacts/collections_config.json ../../SampleApplication/contract/collections_config.json


echo "################## START NETWORK ########################"
cd /home/blockchain/BlockchainDeveloper/test-network


./startNetwork.sh


echo "Update Contract with Ex07 Artifacts "
cd $ROOT

pwd
cp -R ex08Artifacts/application/insurer/api/v1/vehicles/. ../../SampleApplication/application/insurer/api/v1/vehicles/.
cp -R ex08Artifacts/application/manufacturer/api/v1/vehicles/. ../../SampleApplication/application/manufacturer/api/v1/vehicles/.
cp -R ex08Artifacts/application/regulator/api/v1/vehicles/. ../../SampleApplication/application/regulator/api/v1/vehicles/.


echo "################## enroll Admin and users in applications ########################"

cd /home/blockchain/BlockchainDeveloper/SampleApplication/application
ls
./start.sh

