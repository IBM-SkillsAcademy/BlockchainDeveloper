#!/bin/bash

if [ "$#" -eq 2 ]; then
    ./network.sh deployCC -ccn vehicle-network -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript -ccv $1 -ccs $2
elif [ "$#" -eq 3 ]; then
    ./network.sh deployCC -ccn vehicle-network -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript -ccv $1 -ccs $2 -cccg $3
else
    echo "Illegal number of parameters. Expected: "
    echo "./upgradeChaincode.sh <CHAINCODE_VERSION> <CHAINCODE_SEQUENCE> or ./upgradeChaincode.sh <CHAINCODE_VERSION> <CHAINCODE_SEQUENCE> <COLLECTION_CONFIG_PATH>"
    exit 1 
fi
