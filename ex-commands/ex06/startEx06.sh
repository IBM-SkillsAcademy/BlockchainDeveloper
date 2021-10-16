#!/bin/bash

# set project's root folder
cd ../../
ROOT=`pwd`

# # apply last exercise solution
# rm -rf ${ROOT}/SampleApplication/contract/src
# rm -f ${ROOT}/SampleApplication/contract/collections_config.json
# rm -f ${ROOT}/SampleApplication/contract/package.json
# cp -r ${ROOT}/code-solutions/ex05/src ${ROOT}/SampleApplication/contract
# cp ${ROOT}/code-solutions/ex05/collections_config.json ${ROOT}/SampleApplication/contract
# cp ${ROOT}/code-solutions/ex05/package.json ${ROOT}/SampleApplication/contract

# TODO: temporary copy from ex03, change to ex05 later
cd ${ROOT}/ex-commands/ex03
./applySolution.sh

echo "################## START NETWORK ########################"
cd ${ROOT}/test-network/
./startNetwork.sh

# start application
cd ${ROOT}/SampleApplication/application
./start.sh

# enroll admin
sleep 5;
curl -X GET "http://localhost:6001/api/v1/auth/registrar/enroll" -H "accept: */*"; printf "\n";
curl -X GET "http://localhost:6002/api/v1/auth/registrar/enroll" -H "accept: */*"; printf "\n";
curl -X GET "http://localhost:6003/api/v1/auth/registrar/enroll" -H "accept: */*"; printf "\n";

# create org3 affiliation
sleep 3;
curl -X GET "http://localhost:6003/api/v1/auth/create-affiliation" -H "accept: */*"; printf "\n";

sleep 3;
curl -X POST "http://localhost:6001/api/v1/auth/user/register-enroll" -H "accept: */*" -H "Content-Type: application/json" -d "{\"enrollmentID\":\"Manu-User\"}"; printf "\n";
./populateOrders.sh

# register user for cli
sleep 3;
cd ${ROOT}/ex-commands/ex05/
./enrollUser.sh CLI-Manu-User org1 department1 Manufacturer
./enrollUser.sh CLI-Regu-User org2 department1 Regulator
./enrollUser.sh CLI-Insu-User org3 department1 Insurer

# register user for app
sleep 3;
curl -X POST "http://localhost:6001/api/v1/auth/user/register-enroll" -H "accept: */*" -H "Content-Type: application/json" -d "{\"enrollmentID\":\"App-Manu-User\"}"; printf "\n";
curl -X POST "http://localhost:6002/api/v1/auth/user/register-enroll" -H "accept: */*" -H "Content-Type: application/json" -d "{\"enrollmentID\":\"App-Regu-User\"}"; printf "\n";
curl -X POST "http://localhost:6003/api/v1/auth/user/register-enroll" -H "accept: */*" -H "Content-Type: application/json" -d "{\"enrollmentID\":\"App-Insu-User\"}"; printf "\n";

echo "Update Contract with Ex06 Artifacts "
cd ${ROOT}/ex-commands/ex06
rm -rf ../../SampleApplication/contract/src
rm -rf ../../SampleApplication/contract/package.json
rm -rf ../../SampleApplication/contract/META-INF
rm -rf ../../SampleApplication/contract/collections_config.json
cp -R artifacts/src ../../SampleApplication/contract/src
cp artifacts/package.json ../../SampleApplication/contract/package.json
cp -R artifacts/META-INF ../../SampleApplication/contract/META-INF
cp artifacts/collections_config.json ../../SampleApplication/contract/collections_config.json

