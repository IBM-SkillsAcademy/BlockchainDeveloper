 #!/bin/sh

PACKAGE_ID_ORG1=$(sed -n "/vehicle-network/{s/^Package ID: //; s/, Label:.*$//; p;}" chaincodePackageId1.txt)
echo $PACKAGE_ID_ORG1 > pkg1
PACKAGE=$(sed -e 's#.*:\(\)#\1#' pkg1)
echo $PACKAGE
docker exec -t peer0.org1.example.com cp /tmp/connection/connection.json /var/hyperledger/production/externalbuilder/builds/vehicle-network-$PACKAGE/release/chaincode/server


PACKAGE_ID_ORG1=$(sed -n "/vehicle-network/{s/^Package ID: //; s/, Label:.*$//; p;}" chaincodePackageId2.txt)
echo $PACKAGE_ID_ORG1 > pkg2
PACKAGE=$(sed -e 's#.*:\(\)#\1#' pkg2)
echo $PACKAGE
docker exec -t peer0.org2.example.com cp /tmp/connection/connection.json /var/hyperledger/production/externalbuilder/builds/vehicle-network-$PACKAGE/release/chaincode/server


PACKAGE_ID_ORG1=$(sed -n "/vehicle-network/{s/^Package ID: //; s/, Label:.*$//; p;}" chaincodePackageId3.txt)
echo $PACKAGE_ID_ORG1 > pkg3
PACKAGE=$(sed -e 's#.*:\(\)#\1#' pkg3)
echo $PACKAGE
docker exec -t peer0.org3.example.com cp /tmp/connection/connection.json /var/hyperledger/production/externalbuilder/builds/vehicle-network-$PACKAGE/release/chaincode/server
