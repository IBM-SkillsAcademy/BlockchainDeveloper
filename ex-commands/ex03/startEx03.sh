 #!/bin/bash
ROOT=${PWD}
echo "Update Contract files with Completed EX02"
cp -R ../../code-solutions/ex03/src/. ../../SampleApplication/contract/src/.
cp ../../code-solutions/ex03/package.json ../../SampleApplication/contract/package.json


echo "################## START NETWORK ########################"
cd ../../test-network/
./startNetwork.sh

# echo "Update Contract with Ex03 Artifacts "
# cd $ROOT
# #cd ex03Artifacts
# pwd
# cp -R ex03Artifacts/src/. ../../SampleApplication/contract/src
# cp  ex03Artifacts/package.json ../../SampleApplication/contract/package.json


