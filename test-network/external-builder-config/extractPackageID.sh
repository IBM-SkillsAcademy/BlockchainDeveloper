#!/bin/bash
PACKAGE_ID=$(sed -n "/vehicle-network/{s/^Package ID: //; s/, Label:.*$//; p;}" /external-builder-config/chaincodePackageId$1.txt);

export CORE_CHAINCODE_ID=$PACKAGE_ID
export CORE_CHAINCODE_ADDRESS=0.0.0.0:$2
cd /chaincode
npm run-script startServer 
