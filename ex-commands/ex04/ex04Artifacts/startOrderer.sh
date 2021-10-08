cd ../../..
export PATH=$(pwd)/build/bin:$PATH
export FABRIC_CFG_PATH=$(pwd)/config
configtxgen -profile SampleDevModeSolo -channelID syschannel -outputBlock genesisblock -configPath $FABRIC_CFG_PATH -outputBlock "$(pwd)/config/genesisblock"
ORDERER_GENERAL_GENESISPROFILE=SampleDevModeSolo orderer
