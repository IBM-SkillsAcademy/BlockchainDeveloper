#!/bin/bash

# set project's root folder
cd ../../
ROOT=`pwd`

ROOT=${PWD}
echo "Update Contract files with Completed EX03"
cd ${ROOT}/ex-commands/ex03
./applySolution.sh


echo "################## START NETWORK ########################"
cd ${ROOT}/test-network/
./startNetwork.sh

echo "Update Contract with Ex05 Artifacts "
cd ${ROOT}/ex-commands/ex05
cp -R ex05Artifacts/src/contracts/VehicleContract.ts ../../SampleApplication/contract/src/contracts/VehicleContract.ts
