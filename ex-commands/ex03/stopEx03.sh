#!/bin/bash
echo "################## STOP NETWORK ########################"
cd ../../test-network/
./stopNetwork.sh

cd ../SampleApplication/application
./stop.sh