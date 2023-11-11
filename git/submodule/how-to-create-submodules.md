https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-add-submodules-to-GitHub-repos

Clone the parent or top-level repository.
In the root of the parent, issue a “git submodule add” command and provide the GitHub repository’s URL.
Issue a “git status” command to verify a .gitmodules file is created in the parent project.
Add the .gitmodules file to the index and perform a git commit.
Push the GitHub submodule add commit back to the server.
GitHub submodule add commands
The following is the list of commands performed in the GitHub submodule add example.

submodule@example:~$ git clone https://github.com/cameronmcnz/surface.git
submodule@example:~$ git log --oneline
submodule@example:~$ git cd surface
submodule@example:~$ git submodule add https://github.com/cameronmcnz/submarines.git
submodule@example:~$ git status
submodule@example:~$ git git add .
submodule@example:~$ git git commit -m "Add GitHub submodule"
