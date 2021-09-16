#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters. Expected: "
    echo "./upgradeChaincode.sh <CHAINCODE_VERSION> <CHAINCODE_SEQUENCE>"
    exit 1 
fi

./network.sh deployCC -ccn sampleApp -ccp ~/BlockchainDeveloper/SampleApplication/contract -ccl typescript -ccv $1 -ccs $2
