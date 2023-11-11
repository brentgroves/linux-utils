https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-clone-a-git-repository-with-submodules-init-and-update

There is actually an alternative to going through these three steps. You can use the –recurse-submodules switch on the clone. This approach, shown below, might be easier.

git clone --recurse-submodules https://github.com/cameronmcnz/surface.git 
pushd ~/src
git clone --recurse-submodules git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports

# long way
Git submodule clone
The commands issued to clone the git repository and all submodules are:
submodule@example:~$ git clone https://github.com/cameronmcnz/surface.git
submodule@example:~$ git submodule init
submodule@example:~$ git submodule update
The clone operation will obviously happen after multiple repositories have been created and submodules added to them. For more information on how to perform other git submodule operations, check out our full listing of “git submodule how to” tutorials.

