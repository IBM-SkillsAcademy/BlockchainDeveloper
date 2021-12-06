#!/bin/bash
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_YELLOW='\033[1;33m'

CC_NAME=${1:-"vehicle-network"}
CC_VERSION=${2:-"1.0"}
CC_SEQUENCE=${3:-"1"}
CC_SRC_PATH=${4:-"."}
CC_INIT_FCN=${5:-"NA"}
CC_END_POLICY=${6:-"NA"}
CC_COLL_CONFIG=${7:-"NA"}
DELAY=${8:-"3"}
MAX_RETRY=${9:-"5"}
VERBOSE=${10:-"false"}
CHANNEL_NAME=${11:-"mychannel"}

# println echos string
function println() {
  echo -e "$1"
}

# errorln echos i red color
function errorln() {
  println "${C_RED}${1}${C_RESET}"
}

# successln echos in green color
function successln() {
  println "${C_GREEN}${1}${C_RESET}";
}

# infoln echos in blue color
function infoln() {
  println "${C_BLUE}${1}${C_RESET}"
}

# warnln echos in yellow color
function warnln() {
  println "${C_YELLOW}${1}${C_RESET}"
}

# fatalln echos in red color and exits with fail status
function fatalln() {
  errorln "$1"
  exit 1
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    echo $'\e[1;31m'!!!!!!!!!!!!!!! $2 !!!!!!!!!!!!!!!!$'\e[0m'
    echo
    exit 1
  fi
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    echo $'\e[1;31m'!!!!!!!!!!!!!!! $2 !!!!!!!!!!!!!!!!$'\e[0m'
    echo
    exit 1
  fi
}

setGlobals() {

  
  USING_ORG=$1
  infoln "Using organization ${USING_ORG}"
  if [ $1 -eq 1 ]; then
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_ADDRESS=peer$2.org$1.example.com:7051
  elif [ $1 -eq 2 ]; then
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_ADDRESS=peer$2.org$1.example.com:9051
  elif [ $1 -eq 3 ]; then
    export CORE_PEER_LOCALMSPID="Org3MSP"
    export CORE_PEER_ADDRESS=peer0.org3.example.com:11051
  else
    errorln "ORG Unknown"
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
  export CORE_PEER_TLS_ROOTCERT_FILE=/crypto/organizations/peerOrganizations/org$1.example.com/peers/peer$2.org$1.example.com/tls/ca.crt
  export CORE_PEER_MSPCONFIGPATH=/crypto/organizations/peerOrganizations/org$1.example.com/users/Admin@org$1.example.com/msp
  export CORE_PEER_TLS_ENABLED=true
}
packageVehicleChaincode() {
  set -x
   cp connection-org$1.json connection.json
   tar cfz code.tar.gz connection.json;
   tar cfz vehicle-external-chaincode-org$1.tgz metadata.json code.tar.gz;
  res=$?
  if [[ $? -ne 0 ]]; then
    echo "ERROR !!!!!!!!!!!!!!!!!!!!!!! Unable to package chaincode"
    exit 1
  fi
}

installChaincode() {
   set -x
   ORG=$1
  setGlobals $ORG 0

  peer lifecycle chaincode install vehicle-external-chaincode-org$1.tgz >&log.txt
  res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  verifyResult $res "Chaincode installation on ORG $1 peer$2 has failed"
  successln "Chaincode is installed on ORG $1 peer$2"
}

queryInstalled() {
  set -x
  ORG=$1
  setGlobals $ORG 0
  peer lifecycle chaincode queryinstalled >&log.txt
  peer lifecycle chaincode queryinstalled >&chaincodePackageId$1.txt
  res=$?
  { set +x; } 2>/dev/null
  
   if [ $1 -eq 1 ]; then
   PACKAGE_ID_ORG1=$(sed -n "/${CC_NAME}/{s/^Package ID: //; s/, Label:.*$//; p;}" chaincodePackageId1.txt)
  elif [ $1 -eq 2 ]; then
   PACKAGE_ID_ORG2=$(sed -n "/${CC_NAME}/{s/^Package ID: //; s/, Label:.*$//; p;}" chaincodePackageId2.txt)
  elif [ $1 -eq 3 ]; then
   PACKAGE_ID_ORG3=$(sed -n "/${CC_NAME}/{s/^Package ID: //; s/, Label:.*$//; p;}" chaincodePackageId3.txt)
  else
    errorln "ORG Unknown"
  fi
  cat log.txt
  verifyResult $res "Query installed on peer$1 has failed"
  successln "Query installed successful on peer$1 on channel"
}

# approve for org$1
approveChaincodeForOrganisation() {
    ORG=$1
   setGlobals $ORG 0
  if [ $1 -eq 1 ]; then
   PACKAGE_ID=$PACKAGE_ID_ORG1
  elif [ $1 -eq 2 ]; then
   PACKAGE_ID=$PACKAGE_ID_ORG2
  elif [ $1 -eq 3 ]; then
   PACKAGE_ID=$PACKAGE_ID_ORG3
  else
    errorln "ORG Unknown"
  fi
    successln "approveChaincodeForOrganisation $ORG -- ${PACKAGE_ID}"

  peer lifecycle chaincode approveformyorg -o orderer.example.com:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile /crypto/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem --channelID ${CHANNEL_NAME} --name ${CC_NAME} --version ${CC_VERSION} --package-id ${PACKAGE_ID} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_END_POLICY} ${CC_COLL_CONFIG} >&log.txt
  res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  verifyResult $res "Chaincode definition approved on Organization $1 on channel '$CHANNEL_NAME' failed"
  successln "Chaincode definition approved on Organization $1 on channel '$CHANNEL_NAME'"
}

# checkCommitReadiness VERSION PEER 
checkCommitReadiness() {
  ORG=$1
  shift 1
  setGlobals $ORG 0
  infoln "Checking the commit readiness of the chaincode definition on peer0.org${ORG} on channel '$CHANNEL_NAME'..."
  local rc=1
  local COUNTER=1
  # continue to poll
  # we either get a successful response, or reach MAX RETRY
  while [ $rc -ne 0 -a $COUNTER -lt $MAX_RETRY ]; do
    sleep $DELAY
    infoln "Attempting to check the commit readiness of the chaincode definition on peer0.org${ORG}, Retry after $DELAY seconds."
    set -x
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${CC_VERSION} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_END_POLICY} ${CC_COLL_CONFIG} --output json >&log.txt
    res=$?
    { set +x; } 2>/dev/null
    let rc=0
    for var in "$@"; do
      grep "$var" log.txt &>/dev/null || let rc=1
    done
    COUNTER=$(expr $COUNTER + 1)
  done
  cat log.txt
  if test $rc -eq 0; then
    infoln "Checking the commit readiness of the chaincode definition successful on peer0.org${ORG} on channel '$CHANNEL_NAME'"
  else
    fatalln "After $MAX_RETRY attempts, Check commit readiness result on peer0.org${ORG} is INVALID!"
  fi
}

# commitChaincodeDefinition
commitChaincodeDefinition() {
  ORG=$1
  setGlobals $ORG 1
  set -x
  peer lifecycle chaincode commit -o orderer.example.com:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile /crypto/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem  --tlsRootCertFiles /crypto/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --tlsRootCertFiles /crypto/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt  --tlsRootCertFiles /crypto/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt --peerAddresses peer0.org1.example.com:7051 --peerAddresses peer0.org2.example.com:9051 --peerAddresses peer0.org3.example.com:11051   --channelID $CHANNEL_NAME --name ${CC_NAME}  --version ${CC_VERSION} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_END_POLICY} ${CC_COLL_CONFIG} >&log.txt
  res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  verifyResult $res "Chaincode definition commit failed on ORG$1 on channel '$CHANNEL_NAME' failed"
  successln "Chaincode definition committed on channel '$CHANNEL_NAME'"
}

println "executing with the following"
println "- CHANNEL_NAME: ${C_GREEN}${CHANNEL_NAME}${C_RESET}"
println "- CC_NAME: ${C_GREEN}${CC_NAME}${C_RESET}"
println "- CC_SRC_PATH: ${C_GREEN}${CC_SRC_PATH}${C_RESET}"
println "- CC_SRC_LANGUAGE: ${C_GREEN}Typescript${C_RESET}"
println "- CC_VERSION: ${C_GREEN}${CC_VERSION}${C_RESET}"
println "- CC_SEQUENCE: ${C_GREEN}${CC_SEQUENCE}${C_RESET}"
println "- CC_END_POLICY: ${C_GREEN}${CC_END_POLICY}${C_RESET}"
println "- CC_COLL_CONFIG: ${C_GREEN}${CC_COLL_CONFIG}${C_RESET}"
println "- CC_INIT_FCN: ${C_GREEN}${CC_INIT_FCN}${C_RESET}"
println "- DELAY: ${C_GREEN}${DELAY}${C_RESET}"
println "- MAX_RETRY: ${C_GREEN}${MAX_RETRY}${C_RESET}"
println "- VERBOSE: ${C_GREEN}${VERBOSE}${C_RESET}"


#User has not provided a name
if [ -z "$CC_NAME" ] || [ "$CC_NAME" = "NA" ]; then
  fatalln "No chaincode name was provided."
fi

INIT_REQUIRED="--init-required"
# check if the init fcn should be called
if [ "$CC_INIT_FCN" = "NA" ]; then
  INIT_REQUIRED=""
fi

if [ "$CC_END_POLICY" = "NA" ]; then
  CC_END_POLICY=""
else
  CC_END_POLICY="--signature-policy $CC_END_POLICY"
fi

if [ "$CC_COLL_CONFIG" = "NA" ]; then
  CC_COLL_CONFIG=""
else
  CC_COLL_CONFIG="--collections-config $CC_COLL_CONFIG"
fi
packageVehicleChaincode 1
packageVehicleChaincode 2
packageVehicleChaincode 3

installChaincode 1 0
installChaincode 2 0
installChaincode 3 0


sleep 20

queryInstalled 1
queryInstalled 2
queryInstalled 3

sleep 20

approveChaincodeForOrganisation 1
approveChaincodeForOrganisation 2
approveChaincodeForOrganisation 3

sleep 20

checkCommitReadiness 1 "\"Org1MSP\": true" "\"Org2MSP\": true"
sleep 5
checkCommitReadiness 2 "\"Org1MSP\": true" "\"Org2MSP\": true"
sleep 5
checkCommitReadiness 3 "\"Org1MSP\": true" "\"Org2MSP\": true" "\"Org3MSP\": true"

sleep 20
commitChaincodeDefinition 1
exit 0
