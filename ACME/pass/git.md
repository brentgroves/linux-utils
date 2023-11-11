https://www.passwordstore.org/
https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
https://github.com/docker/docker-credential-helpers

pass git pull origin master
pass git push origin master

Creating the git repo
Now that ssh is all set up you need to create the git repo, I keep everything in the git users home folder so if you’ve just ssh’d in as the git user you can run:

git init --bare pass-repo
This will create a folder called pass-repo which will have a lot of auto generated git files in it, we can ignore all of that we’re done working on the server side for now.

Back to our local machine
On your local machine you just need to set up the remote for your password store’s git repo using the following command

pass git remote add origin ssh://git@<your server's ip>:/home/git/pass-repo
You can then start pushing to and pulling from the remote using pass git push origin master and pass git pull origin master respectively. Pass will take care of the rest of the git commands for you, but again if you ever get stuck you can either watch my talk or try Github’s excellent interactive tutorial to learn more about git.

