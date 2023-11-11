#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
cd ~/src
rm -rf ~/src/linux-utils
git clone git@github.com:brentgroves/linux-utils.git
rm -rf ~/src/mobexsql
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/mobexsql
rm -rf ~/src/reports
git clone --recursive git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
## git switch main if detached head
cd ~/src/reports/volume/go/replib
git switch main
cd ~/src/reports/volume/go/runner
git switch main
cd ~/src/reports/volume/python/tutorials/flask_cert
git switch main
cd ~/src/reports/volume/pki
git switch main

popd

