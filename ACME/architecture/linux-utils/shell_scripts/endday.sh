#!/bin/sh
cd ~/src/linux-utils
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/Reporting
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/mobexsql
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main
