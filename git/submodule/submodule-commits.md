https://github.blog/2016-02-01-working-with-submodules/
pushd /home/brent/src/reports/volume/ca
git add -A
git commit -am 'updated ca'
-a, --all
           Tell the command to automatically stage files that have been modified and deleted, but new files you have not told Git about are not affected.

# !!! if you forget this step you will be pushing a local commit that a remote user will not have access to see fix-not-our-ref-error.md
git push -u origin main 

# update main repo with new submodule commit number.
cd ..
git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   ca (new commits)

Submodules changed but not updated:

* volume/ca 2e2a0d6...1bfd5fb (1):
  > update #1 to ca submodule

no changes added to commit (use "git add" and/or "git commit -a")

# need to update version pointer to sub_main submodule
git add -A
git commit -am 'update version pointer to sub_main submodule commit #2 and submodule markdown'
git push -u origin main

git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

# pull updates made on another system
git pull --recurse-submodules
git status
On branch main
Your branch is up to date with 'origin/main'.
