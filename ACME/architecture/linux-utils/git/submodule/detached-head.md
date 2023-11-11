https://www.cloudbees.com/blog/git-detached-head

if you get the message:
git status
HEAD detached at b3d407b
nothing to commit, working tree clean

but everything looks good:
git log --oneline
b3d407b (HEAD -> main, origin/main, origin/HEAD) Fixed reports submodule commit issue
a6fbd1b Added/Changed Source Code
46f67e7 Added/Updated code
de78c63 Added/Updated code
2301fef Added/Changed Source Code
4ff1e58 Added/Changed Source Code
01a270b Added/Changed Source Code
e7bdf3f Added/Updated code
881f325 Added/Updated code
fb05f66 Initial commit

git switch main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.

