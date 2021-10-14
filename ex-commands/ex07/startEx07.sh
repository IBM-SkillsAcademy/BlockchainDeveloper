#!/bin/bash
ROOT=${PWD}
echo "Update Contract files with Completed smart Contract"

cp -R ex07Artifacts/contract/. ../../SampleApplication/contract/.


echo "################## START NETWORK ########################"
cd /home/blockchain/BlockchainDeveloper2019/test-network


./startNetwork.sh


echo "Update Contract with Ex07 Artifacts "
cd $ROOT

pwd
cp -R ex07Artifacts/application/insurer/api/v1/vehicles/* ../../SampleApplication/application/insurer/api/v1/vehicles/*
cp -R ex07Artifacts/application/manufacturer/api/v1/vehicles/* ../../SampleApplication/application/manufacturer/api/v1/vehicles/*


