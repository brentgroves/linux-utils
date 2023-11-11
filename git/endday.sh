#!/bin/bash
pushd .
cd ~/src/linux-utils
echo "in linux-utils"
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/Reporting
echo "in Reporting"
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/mobexsql
echo "in mobexsql"
git pull
git add -A 
git commit -m "updated source code"
git push -u origin main

# https://gist.github.com/gitaarik/8735255
# Make changes inside a submodule
# cd inside the submodule directory.
# Make the desired changes.
# git commit the new changes.
# git push the new commit.
# cd back to the main repository.
# In git status you'll see that the submodule directory is modified.
# In git diff you'll see the old and new commit pointers.
# When you git commit in the main repository, it will update the pointer.

cd ~/src/reports/volume/go/replib
echo "in replib"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/reports/volume/go/runner
echo "in runner"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/reports/volume/python/tutorials/flask_cert
echo "in flask_cert"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/reports/volume/pki
echo "in pki"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/reports
echo "in reports"
git add -A 
git commit -m "updated source code"
git push -u origin main

popd