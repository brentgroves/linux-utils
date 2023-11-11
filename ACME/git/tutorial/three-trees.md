https://www.atlassian.com/git/tutorials/undoing-changes/git-reset

The git reset command is a complex and versatile tool for undoing changes. It has three primary forms of invocation. These forms correspond to command line arguments --soft, --mixed, --hard. The three arguments each correspond to Git's three internal state management mechanism's, The Commit Tree (HEAD), The Staging Index, and The Working Directory.

Git Reset & Three Trees of Git
To properly understand git reset usage, we must first understand Git's internal state management systems. Sometimes these mechanisms are called Git's "three trees". Trees may be a misnomer, as they are not strictly traditional tree data-structures. They are, however, node and pointer-based data structures that Git uses to track a timeline of edits. The best way to demonstrate these mechanisms is to create a changeset in a repository and follow it through the three trees. 

To get started we will create a new repository with the commands below:

$ mkdir git_reset_test
$ cd git_reset_test/
$ git init .
Initialized empty Git repository in /git_reset_test/.git/
$ touch reset_lifecycle_file
$ git add reset_lifecycle_file
$ git commit -m"initial commit"
[main (root-commit) d386d86] initial commit
1 file changed, 0 insertions(+), 0 deletions(-)
create mode 100644 reset_lifecycle_file

empty file, reset_lifecycle_file. At this point, the example repository has a single commit (d386d86) from adding reset_lifecycle_file.

The working directory
The first tree we will examine is "The Working Directory". This tree is in sync with the local filesystem and is representative of the immediate changes made to content in files and directories.


$ echo 'hello git reset' > reset_lifecycle_file
 $ git status 
 On branch main
 Changes not staged for commit: 
 (use "git add ..." to update what will be committed) 
 (use "git checkout -- ..." to discard changes in working directory) 
 modified: reset_lifecycle_file

In our demo repository, we modify and add some content to the reset_lifecycle_file. Invoking git status shows that Git is aware of the changes to the file. These changes are currently a part of the first tree, "The Working Directory". Git status can be used to show changes to the Working Directory. They will be displayed in the red with a 'modified' prefix.

Staging index
Next up is the 'Staging Index' tree. This tree is tracking Working Directory changes, that have been promoted with git add, to be stored in the next commit. This tree is a complex internal caching mechanism. Git generally tries to hide the implementation details of the Staging Index from the user.

To accurately view the state of the Staging Index we must utilize a lesser known Git command git ls-files. The git ls-files command is essentially a debug utility for inspecting the state of the Staging Index tree.

git ls-files -s
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0   reset_lifecycle_file

Here we have executed git ls-files with the -s or --stage option. Without the -s option the git ls-files output is simply a list of file names and paths that are currently part of the index. The -s option displays additional metadata for the files in the Staging Index. This metadata is the staged contents' mode bits, object name, and stage number. Here we are interested in the object name, the second value (d7d77c1b04b5edd5acfc85de0b592449e5303770). This is a standard Git object SHA-1 hash. It is a hash of the content of the files. The Commit History stores its own object SHA's for identifying pointers to commits and refs and the Staging Index has its own object SHA's for tracking versions of files in the index.

Next, we will promote the modified reset_lifecycle_file into the Staging Index.
$ git add reset_lifecycle_file 
$ git status 
On branch main Changes to be committed: 
(use "git reset HEAD ..." to unstage) 
modified: reset_lifecycle_file

Here we have invoked git add reset_lifecycle_file which adds the file to the Staging Index. Invoking git status now shows reset_lifecycle_file in green under "Changes to be committed". It is important to note that git status is not a true representation of the Staging Index. The git status command output displays changes between the Commit History and the Staging Index. Let us examine the Staging Index content at this point.

 
$ git ls-files -s 
100644 d7d77c1b04b5edd5acfc85de0b592449e5303770 0 reset_lifecycle_file

We can see that the object SHA for reset_lifecycle_file has been updated from e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 to d7d77c1b04b5edd5acfc85de0b592449e5303770.

Commit history
The final tree is the Commit History. The git commit command adds changes to a permanent snapshot that lives in the Commit History. This snapshot also includes the state of the Staging Index at the time of commit.

$ git commit -am"update content of reset_lifecycle_file"
[main dc67808] update content of reset_lifecycle_file
1 file changed, 1 insertion(+)
$ git status
On branch main
nothing to commit, working tree clean
Here we have created a new commit with a message of "update content of resetlifecyclefile". The changeset has been added to the Commit History. Invoking git status at this point shows that there are no pending changes to any of the trees. Executing git log will display the Commit History. Now that we have followed this changeset through the three trees we can begin to utilize git reset.



