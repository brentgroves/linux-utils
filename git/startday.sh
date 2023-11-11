#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
cd ~/src/linux-utils
git pull
cd ~/src/Reporting
git pull
cd ~/src/mobexsql
git pull

# --recurse-submodules don't seem to always pull all the commits
echo "pulling replib"
cd ~/src/reports/volume/go/replib
git pull

echo "pulling runner"
cd ~/src/reports/volume/go/runner
git pull

echo "pulling flask_cert"
cd ~/src/reports/volume/python/tutorials/flask_cert
git pull

echo "pulling pki"
cd ~/src/reports/volume/pki
git pull

cd ~/src/reports
git pull --recurse-submodules
