#!/bin/bash

# apply last exercise solution
cp ex04Artifacts/settings.json ~/.config/Code/User/settings.json
rm -rf ../../SampleApplication/contract/src
rm -f ../../SampleApplication/contract/package.json
cp -r ex04Artifacts/src/ ../../SampleApplication/contract/src
cp  ex04Artifacts/package.json ../../SampleApplication/contract/package.json

cd ../../SampleApplication/contract
npm i
npm run build
