
CORE_CHAINCODE_LOGLEVEL=debug CORE_PEER_TLS_ENABLED=false CORE_CHAINCODE_ID_NAME=mycc:1.0
npm build -o ./../../../SampleApplication/contract ./../../../SampleApplication/contract/
cd ./../../../SampleApplication/contract/
rm -rf dist
npm run build
npm run start -- --peer.address 127.0.0.1:7052 --chaincode-id-name mycc:1.0

