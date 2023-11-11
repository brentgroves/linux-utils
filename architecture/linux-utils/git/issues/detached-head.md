https://www.cloudbees.com/blog/git-detached-head

Git Detached HEAD: Reproducing the “Problem”
Let’s start with a quick demo showing how to reach the detached HEAD state. We’ll create a repository and add some commits to it:

mkdir git-head-demo
cd git-head-demo
git init
touch file.txt
git add .
git commit -m "Create file"
echo "Hello World!" > file.txt
git commit -a -m "Add line to the file"
echo "Second file" > file2.txt
git add .
git commit -m "Create second file"

With the commands above, we’ve created a new folder with a new repository inside it. Then we created a new empty file and committed that with the message “Create file.” Next, we added a line to that file and committed the change, with the message “Add a line to the file.” Finally, we’ve created another file with one line of text and committed that as well. If you use the git log –oneline command, you’ll see something like this:

Let’s say that, for testing purposes, we need to see how things were at the time of the second commit. How would we do that? As it turns out, we can check out a commit the same way we’d check out branches. Remember, branches are just names for commits. So, based on the example output above, we’d run git checkout 87ec91d. Keep in mind that if you’re following along by executing these commands on your own system, the hash for your commits will be different from those in the example. Use the log command to find it.

After running the command, we get the “You are in ‘detached HEAD’ state[…]” message. Before we go on, make sure you keep this in mind: you get to the detached HEAD state by checking out a commit directly.

What Is a HEAD in Git?
What does HEAD mean in Git? To understand that, we have to take a step back and talk fundamentals.

A Git repository is a collection of objects and references. Objects have relationships with each other, and references point to objects and to other references. The main objects in a Git repository are commits, but other objects include blobs and trees. The most important references in Git are branches, which you can think of as labels you put on a commit.

HEAD is another important type of reference. The purpose of HEAD is to keep track of the current point in a Git repo. In other words, HEAD answers the question, “Where am I right now?”

For instance, when you use the log command, how does Git know which commit it should start displaying results from? HEAD provides the answer. When you create a new commit, its parent is indicated by where HEAD currently points to.

Are you in ‘detached HEAD’ state?
You’ve just seen that HEAD in Git is only the name of a reference that indicates the current point in a repository. So, what does it mean for it to be attached or detached?

Most of the time, HEAD points to a branch name. When you add a new commit, your branch reference is updated to point to it, but HEAD remains the same. When you change branches, HEAD is updated to point to the branch you’ve switched to. All of that means that, in these scenarios, HEAD is synonymous with “the last commit in the current branch.” This is the normal state, in which HEAD is attached to a branch.

A visual representation of our demo repository would look like this:


**![head](https://images.ctfassets.net/vtn4rfaw6n2j/7D7VZoug8kpm44t5j6mtPG/31728e41f18999fd40140a389d7993ba/image5.png?fm=webp&q=85)**


As you can see, HEAD points to the controller branch, which points to the last commit. Everything looks perfect. After running git checkout 87ec91d, the repo looks like this:

**![detached head](https://images.ctfassets.net/vtn4rfaw6n2j/4h3Jo9gFVyegpYX0GTGp6G/65e5a06240f02c2929de13b76ed31dcd/image4.png?fm=webp&q=85)**

This is the detached HEAD state; HEAD is pointing directly to a commit instead of a branch.


Benefits of a Git Detached HEAD
Are there good reasons for you to be in the detached HEAD state? You bet there are!

As you’ve seen, you detach the HEAD by checking out a commit. That’s already useful by itself since it allows you to go to a previous point in the project’s history. Let’s say you want to check if a given bug already existed last Tuesday. You can use the log command, filtering by date, to start the relevant commit hash. Then you can check out the commit and test the application, either by hand or by running your automated test suite.

What if you could not only take a look at the past, but also change it? That’s what a detached HEAD allows you to do. Let’s review how the detached message starts:

You are in 'detached HEAD' state. You can look around, make experimental changes and commit them, and you can discard any commits you make in this state without impacting any branches by switching back to a branch.

In this state, you can make experimental changes, effectively creating an alternate history. So, let’s create some additional commits in the detached HEAD state and see how our repo looks afterward:

echo "Welcome to the alternate timeline, Morty!" > new-file.txt
git add .
git commit -m "Create new file"
echo "Another line" >> new-file.txt
git commit -a -m "Add a new line to the file"

We now have two additional commits that descend from our second commit. Let’s run git log –oneline and see the result:


This is what the diagram looks like now:

**![alternate history](https://images.ctfassets.net/vtn4rfaw6n2j/4nKELNZvRF0b23IWODsnhl/d8a7c0f261353901c37e89cf046d9e64/image6.png?fm=webp&q=85)**

What should you do if you want to keep those changes? And what should you do if you want to discard them? That’s what we’ll see next.

How Do I Fix a Detached HEAD in Git?
You can’t fix what isn’t broken. As I’ve said before, a detached HEAD is a valid state in Git. It’s not a problem. But you may still want to know how to get back to normal, and that depends on why you’re in this situation in the first place.

Scenario #1: I’m Here by Accident
If you’ve reached the detached HEAD state by accident—that is to say, you didn’t mean to check out a commit—going back is easy. Just check out the branch you were in before:

git checkout <branch-name>

If you’re using Git 2.23.0 or newer, you can also use switch instead of checkout:

git switch <branch-name>

# submodule problem
HEAD detached from dea85d5
nothing to commit, working tree clean

Submodules changed but not updated:

* volume/go/create-go-module/filter_main dea85d5...77e1e39 (2):
  > Merge branch 'main' of github.com:brentgroves/filter_main into HEAD

git switch main

Warning: you are leaving 2 commits behind, not connected to
any of your branches:

  77e1e39 Merge branch 'main' of github.com:brentgroves/filter_main into HEAD
  a03de64 updated source

If you want to keep them by creating a new branch, this may be a good time
to do so with:

 git branch <new-branch-name> 77e1e39

Switched to branch 'main'
Your branch is up to date with 'origin/main'.

git log --oneliner
fbf4915 (HEAD -> main, origin/main, origin/HEAD) updated source
dea85d5 updated source
57836b1 updated source code
715ba73 updated source code
e71710d updated source code
67fd66a updated source code
2d62d53 updated
fbd1965 Initial commit

