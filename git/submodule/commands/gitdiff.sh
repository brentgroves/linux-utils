#!/bin/sh
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Fetch and update code in all submodules
# list of submodules: git@github.com:brentgroves/filter_main.git
#                     git@github.com:brentgroves/filter_private.git
# git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# At this point if you run git diff we can see both that we have modified our .gitmodules file and also that there are a number of commits that we’ve pulled down 
# and are ready to commit to our submodule project.git config status.submodulesummary 1
git diff