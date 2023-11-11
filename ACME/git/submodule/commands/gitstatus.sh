#!/bin/sh
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Fetch and update code in all submodules
# list of submodules: git@github.com:brentgroves/filter_main.git
#                     git@github.com:brentgroves/filter_private.git
# git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# If you set the configuration setting status.submodulesummary, 
# Git will also show you a short summary of changes to your submodules:
git config status.submodulesummary 1
git status
