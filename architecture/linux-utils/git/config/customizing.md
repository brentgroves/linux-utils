https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
cat ~/.gitconfig
[user]
	name = brentgroves
	email = brent.groves@gmail.com
[core]
	editor = nvim
[url "ssh://git@github.com/"]
   insteadOf = https://github.com/


Note how this commit template reminds the committer to keep the subject line short (for the sake of git log --oneline output), to add further detail under that, and to refer to an issue or bug tracker ticket number if one exists.

To tell Git to use it as the default message that appears in your editor when you run git commit, set the commit.template configuration value:

$ git config --global commit.template ~/.gitmessage.txt
$ git commit
Then, your editor will open to something like this for your placeholder commit message when you commit:

Subject line (try to keep under 50 characters)

Multi-line description of commit,
feel free to be detailed.

[Ticket: X]
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
# modified:   lib/test.rb
#
~
~
".git/COMMIT_EDITMSG" 14L, 297C   