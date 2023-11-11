#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
cd ~
rm ~/dotfiles
git clone https://github.com/brentgroves/dotfiles.git
cd ~/src
rm -rf ~/src/repsys
git clone --recursive git@github.com:brentgroves/repsys.git
## git switch main if detached head
cd ~src/repsys/git
git switch main
cd ~src/repsys/projects
git switch main

cd ~/src/reports/volume/go/replib
git switch main
cd ~/src/reports/volume/go/runner
git switch main
cd ~/src/reports/volume/python/tutorials/flask_cert
git switch main
cd ~/src/reports/volume/pki
git switch main

popd

