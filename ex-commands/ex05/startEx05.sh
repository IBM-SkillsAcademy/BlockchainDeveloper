#!/bin/bash

# set project's root folder
cd ../../
ROOT=${PWD}

cd ~/BlockchainDeveloper
git restore .
git clean -fd
git pull

cd $ROOT
echo "Update Contract files with Completed EX03"
cd ${ROOT}/ex-commands/ex03
./applySolution.sh


echo "################## START NETWORK ########################"
cd ${ROOT}/test-network/
./startNetwork.sh

echo "Update Contract with Ex05 Artifacts "
cd ${ROOT}/ex-commands/ex05
cp -R artifacts/src/contracts/VehicleContract.ts ../../SampleApplication/contract/src/contracts/VehicleContract.ts
