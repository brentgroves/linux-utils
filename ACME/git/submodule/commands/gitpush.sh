#!/bin/sh
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Fetch and update code in all submodules
# list of submodules: git@github.com:brentgroves/filter_main.git
#                     git@github.com:brentgroves/filter_private.git
# git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports

# In order to make sure this doesn’t happen, you can ask Git to check 
# that all your submodules have been pushed properly before pushing 
# the main project. The git push command takes the --recurse-submodules 
# argument which can be set to either “check” or “on-demand”. 
# The “check” option will make push simply fail if any of the committed 
# submodule changes haven’t been pushed.

# is to go into each submodule and manually push to the remotes to make
#  sure they’re externally available and then try this push again. If 
#  you want the “check” behavior to happen for all pushes, you can make 
#  this behavior the default by doing git config push.recurseSubmodules 
#  check.

# The other option is to use the “on-demand” value, which will try to 
# do this for you.

git push --recurse-submodules=on-demand