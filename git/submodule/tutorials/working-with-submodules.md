https://github.blog/2016-02-01-working-with-submodules/
pushd ~/src/reports
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
git submodule add git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/sub_main volume/go/tutorials/sub_main

Cloning into '/home/brent/src/reports/volume/go/tutorials/sub_main'...
remote: Azure Repos
remote: Found 8 objects to send. (49 ms)

Receiving objects: 100% (8/8), done.
git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   .gitmodules
        new file:   volume/go/tutorials/sub_main

Submodule changes to be committed:

* volume/go/tutorials/sub_main 0000000...2e2a0d6 (2):
  > updated source


git add -A
git commit -am 'added sub_main submodule'
git push -u origin main
  -u, --set-upstream
           For every branch that is up to date or successfully pushed, add upstream (tracking) reference, used by argument-less git-pull(1) and other commands. For more information, see branch.<name>.merge
           in git-config(1).


pushd ~/src/reports
git log --oneline # log shows commits from Project reports
c23a011 (HEAD -> main, origin/main, origin/HEAD) updated filter_main submodule
9ce3eb3 updated filter_main submodule
cba4391 updated source
581fcc7 updated source code

pushd /home/brent/src/reports/volume/go/tutorials/sub_main
git log --oneline
2e2a0d6 (HEAD -> main, origin/main, origin/HEAD) updated source
44300a2 Added README.md, .gitignore (Go) files

# update main.go of sub_main
git add -A
git commit -am 'update #1 to sub_main submodule'
-a, --all
           Tell the command to automatically stage files that have been modified and deleted, but new files you have not told Git about are not affected.

git push -u origin main 

cd ..
git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   sub_main (new commits)

Submodules changed but not updated:

* volume/go/tutorials/sub_main 2e2a0d6...1bfd5fb (1):
  > update #1 to sub_main submodule

no changes added to commit (use "git add" and/or "git commit -a")

# need to update version pointer to sub_main submodule
git add -A
git commit -am 'update version pointer to sub_main submodule'
git push -u origin main

git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean


# joining a project with submodules
Joining a project using submodules
Now, say you’re a new collaborator joining Project Slingshot. You’d start by running git clone to download the contents of the slingshot repository. At this point, if you were to peek inside the rock folder, you’d see … nothing.

Again, Git expects us to explicitly ask it to download the submodule’s content. You can use git submodule update --init --recursive here as well, but if you’re cloning slingshot for the first time, you can use a modified clone command to ensure you download everything, including any submodules:

# on different machine
cd ~/src
git clone --recursive git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports

Cloning into 'reports'...
remote: Azure Repos
remote: Found 783 objects to send. (115 ms)
Receiving objects: 100% (783/783), 133.70 MiB | 35.84 MiB/s, done.
Resolving deltas: 100% (325/325), done.
Submodule 'volume/go/create-go-module/filter_main' (git@github.com:brentgroves/filter_main) registered for path 'volume/go/create-go-module/filter_main'
Submodule 'volume/go/tutorials/sub_main' (git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/sub_main) registered for path 'volume/go/tutorials/sub_main'
Cloning into '/home/brent/src/r2/reports/volume/go/create-go-module/filter_main'...
remote: Enumerating objects: 29, done.        
remote: Counting objects: 100% (29/29), done.        
remote: Compressing objects: 100% (21/21), done.        
remote: Total 29 (delta 14), reused 18 (delta 7), pack-reused 0        
Receiving objects: 100% (29/29), 4.10 KiB | 4.10 MiB/s, done.
Resolving deltas: 100% (14/14), done.
Cloning into '/home/brent/src/r2/reports/volume/go/tutorials/sub_main'...
remote: Azure Repos        
remote: Found 11 objects to send. (38 ms)        
Receiving objects: 100% (11/11), done.
Resolving deltas: 100% (2/2), done.
Submodule path 'volume/go/create-go-module/filter_main': checked out 'fbf49155dd9a0642f985532a257970f3bdbd395d'
Submodule path 'volume/go/tutorials/sub_main': checked out '1bfd5fbc7d09ce528c7c6302abb11769e66a396c'





