#!/bin/sh
# https://git-scm.com/book/en/v2/Git-Tools-Submodules
# Fetch and update code in all submodules
# list of submodules: git@github.com:brentgroves/filter_main.git
#                     git@github.com:brentgroves/filter_private.git
# git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# Pulling Upstream Changes from the Project Remote
# Let’s now step into the shoes of your collaborator, who has their 
# own local clone of the MainProject repository. Simply executing git 
# pull to get your newly committed changes is not enough:

# By default, the git pull command recursively fetches submodules 
# changes, as we can see in the output of the first command above. 
# However, it does not update the submodules. This is shown by the 
# output of the git status command, which shows the submodule is 
# “modified”, and has “new commits”. What’s more, the brackets showing 
# the new commits point left (<), indicating that these commits are 
# recorded in MainProject but are not present in the local DbConnector 
# checkout. To finalize the update, you need to run git submodule 
# update:

# If you want to automate this process, you can add the 
# --recurse-submodules flag to the git pull command (since Git 2.14). 
# This will make Git run git submodule update right after the pull, 
# putting the submodules in the correct state. Moreover, if you want 
# to make Git always pull with --recurse-submodules, you can set the 
# configuration option submodule.recurse to true (this works for git 
# pull since Git 2.15). This option will make Git use the 
# --recurse-submodules 
# flag for all commands that support it (except clone).

git pull --recurse-submodules

# cd ~/src/linux-utils
# git pull
# cd ~/src/Reporting
# git pull
# cd ~/src/mobexsql
# git pull