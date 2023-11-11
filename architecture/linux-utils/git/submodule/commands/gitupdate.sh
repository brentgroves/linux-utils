#!/bin/sh
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Fetch and update code in all submodules
# list of submodules: git@github.com:brentgroves/filter_main.git
#                     git@github.com:brentgroves/filter_private.git
# git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# There is an easier way to do this as well, if you prefer to not manually fetch and merge in the subdirectory. 
# If you run git submodule update --remote, Git will go into your submodules and fetch and update for you.
# Git will by default try to update all of your submodules when you run 
# git submodule update --remote. If you have a lot of them, you may want 
# to pass the name of just the submodule you want to try to update.
# Git will by default try to update all of your submodules when you run git submodule update --remote. 
# If you have a lot of them, you may want to pass the name of just the submodule you want to try to update.
git submodule update --remote
