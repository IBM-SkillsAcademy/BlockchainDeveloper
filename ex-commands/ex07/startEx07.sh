#!/bin/bash
ROOT=${PWD}

cd ~/BlockchainDeveloper
git restore .
git clean -fd
git pull

cd $ROOT
echo "Update Contract files with Completed smart Contract"

cp -R ex07Artifacts/src/. ../../SampleApplication/contract/src/.
cp -R ex07Artifacts/META-INF/. ../../SampleApplication/contract/META-INF/.
cp ex07Artifacts/collections_config.json ../../SampleApplication/contract/collections_config.json

echo "################## START NETWORK ########################"
cd /home/blockchain/BlockchainDeveloper/test-network


./startNetwork.sh


echo "Update Contract with Ex07 Artifacts "
cd $ROOT

pwd
cp -R ex07Artifacts/application/insurer/api/v1/vehicles/. ../../SampleApplication/application/insurer/api/v1/vehicles/.
cp -R ex07Artifacts/application/manufacturer/api/v1/vehicles/. ../../SampleApplication/application/manufacturer/api/v1/vehicles/.


