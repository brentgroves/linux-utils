https://developer.matomo.org/guides/git

Fixing the reference error 
When you forgot to push the submodule
Let's say you make some changes in the submodule. Then you commit these changes, but you forget to push the changes like below:

``` bash
cd plugins/SecurityInfo.
git checkout -b $MY_FEATURE_BRANCH $MAIN_BRANCH.
git add Controller.php && git commit -m "Update".
Here usually a push should happen, but you forgot it.
cd ../..
git add plugins/SecurityInfo this stages the submodule reference change
git commit -m 'Update submodule'
git push
```

When you push now, then the updating of the submodule won't work because the commit only exists on your local computer but was never pushed. 

To resolve this:
You could pull a commit that does exist and update your main branch with the old commit.
https://unfuddle.com/stack/tips-tricks/git-pull-specific-commit/