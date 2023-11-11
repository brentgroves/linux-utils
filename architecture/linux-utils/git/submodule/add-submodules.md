https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-add-submodules-to-GitHub-repos

https://gist.github.com/gitaarik/8735255#adding-a-submodule
You can add a submodule to a repository like this:

cd ~/src/reports
git submodule add git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/pki volume/pki
git status
git add -A
git commit -m "added submodule"
git push

With default configuration, this will check out the code of the awesome_submodule.git repository to the path_to_awesome_submodule directory, and will add information to the main repository about this submodule, which contains the commit the submodule points to, which will be the current commit of the default branch (usually the master branch) at the time this command is executed.

After this operation, if you do a git status you'll see two files in the Changes to be committed list: the .gitmodules file and the path to the submodule. When you commit and push these files you commit/push the submodule to the origin.

Getting the submodule's code
If a new submodule is created by one person, the other people in the team need to initiate this submodule. First you have to get the information about the submodule, this is retrieved by a normal git pull. If there are new submodules you'll see it in the output of git pull. Then you'll have to initiate them with:

git submodule init
This will pull all the code from the submodule and place it in the directory that it's configured to.

If you've cloned a repository that makes use of submodules, you should also run this command to get the submodule's code. This is not automatically done by git clone. However, if you add the --recurse-submodules flag, it will.


git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/pki