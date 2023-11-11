#!/bin/sh
# update 3
cd ~/src/reports/volume/go/create-go-module/filter_main
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/reports/volume/go/create-go-module/filter_private
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/reports
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main 
# since I am going to each subdirectory and pushing --recurse option is not needed.
# git push --recurse-submodules=on-demand