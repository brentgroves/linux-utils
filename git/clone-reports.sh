#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
cd ~/src
git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# this gives me detached heads on the submodules but the commit seems to be right 
# and git switch main seems to clear it up.
echo "filter_main"
cd ~/src/reports/volume/go/create-go-module/filter_main
git switch main

echo "sub_main"
cd ~/src/reports/volume/go/tutorials/sub_main
git switch main

echo "sub_lib"
cd ~/src/reports/volume/go/tutorials/sub_lib
git switch main

echo "flask_cert"
cd ~/src/reports/volume/python/tutorials/flask_cert
git switch main

echo "ca"
cd ~/src/reports/volume/ca
git switch main

echo "pki"
cd ~/src/reports/volume/pki
git switch main

popd