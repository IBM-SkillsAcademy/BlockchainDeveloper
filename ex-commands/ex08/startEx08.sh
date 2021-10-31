#!/bin/bash
ROOT=${PWD}

cd ~/BlockchainDeveloper
git restore .
git clean -fd
git pull

cd $ROOT
echo "## Stopping the existing network ##"
./stopEx08.sh

echo "Update Contract files with Completed smart Contract"

cp -R ex08Artifacts/contract/. ../../SampleApplication/contract/.


echo "################## START NETWORK ########################"
cd /home/blockchain/BlockchainDeveloper/test-network


./startNetwork.sh

echo "Update Contract with Ex07 Artifacts "
cd $ROOT

pwd
cp -R ex08Artifacts/application/insurer/api/v1/utils.js ../../SampleApplication/application/insurer/api/v1/utils.js
cp -R ex08Artifacts/application/insurer/api/v1/vehicles/controller.js ../../SampleApplication/application/insurer/api/v1/vehicles/controller.js
cp -R ex08Artifacts/application/manufacturer/api/v1/vehicles/controller.js ../../SampleApplication/application/manufacturer/api/v1/vehicles/controller.js
cp -R ex08Artifacts/application/regulator/api/v1/vehicles/controller.js ../../SampleApplication/application/regulator/api/v1/vehicles/controller.js
cp -R ex08Artifacts/application/regulator/api/v1/utils.js ../../SampleApplication/application/regulator/api/v1/utils.js


echo "################## enroll Admin and users in applications ########################"

cd /home/blockchain/BlockchainDeveloper/SampleApplication/application
ls
./start.sh

