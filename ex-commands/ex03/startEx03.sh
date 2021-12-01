 #!/bin/bash
ROOT=${PWD}

cd ~/BlockchainDeveloper
git restore .
git clean -fd
git pull

cd $ROOT
echo "Update Contract files with Completed EX02"
cp -R ../../code-solutions/ex02/src/. ../../SampleApplication/contract/src/.
cp ../../code-solutions/ex02/package.json ../../SampleApplication/contract/package.json


echo "################## START NETWORK ########################"
cd ../../test-network/
./startNetwork.sh

echo "Update Contract with Ex03 Artifacts "
cd $ROOT
cp -R ex03Artifacts/src/. ../../SampleApplication/contract/src
cp  ex03Artifacts/package.json ../../SampleApplication/contract/package.json


