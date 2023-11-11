
# add your user to the group mail
# usermod -a -G mail $USER
https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/
sudo usermod -a -G groupName userName
The -a (append) switch is essential. Otherwise, the user will be removed from any groups, not in the list.

The -G switch takes a (comma-separated) list of additional groups to assign the user to.

You need to logout and log back in unless you run the following command.

From inside a shell, you can issue the following command

su - $USER
id will now list the new group:


In general (for the GUI, or for already running processes, etc.), the user will need to log out and log back in to see their new group added. For the current shell session, you can use newgrp:



View All Groups on the System
If you want to view a list of all groups on your system, you can use the getent command:

getent group

Add a New Group
RELATED: What's the Difference Between Sudo and Su in Linux?

If you want to create a new group on your system, use the groupadd command following command, replacing new_group with the name of the group you want to create. You’ll need to use sudo with this command as well (or, on Linux distributions that don’t use sudo, you’ll need to run the su command on its own to gain elevated permissions before running the command).

sudo groupadd mynewgroup

Add an Existing User Account to a Group
To add an existing user account to a group on your system, use the usermod command, replacing examplegroup with the name of the group you want to add the user to andexampleusername  with the name of the user you want to add.

usermod -a -G examplegroup exampleusername
For example, to add the user geek to the group sudo , use the following command:

usermod -a -G sudo geek
To view the numerical IDs associated with each group, run the id  command instead:


