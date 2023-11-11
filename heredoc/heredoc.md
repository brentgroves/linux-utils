https://linuxize.com/post/create-a-file-in-linux/
https://linuxize.com/post/bash-heredoc/
Creating a File using Heredoc
Here document or Heredoc is a type of redirection that allows you to pass multiple lines of input to a command.
This method is mostly used when you want to create a file containing multiple lines of text from a shell script.

For example, to create a new file file1.txt you would use the following code:
cat << EOF > file1.txt
Some line
Some other line
EOF
CopyCopyCopyCopy
The body of the heredoc can contain variables, special characters, and commands.

command to create file and set permissions.
install -m 777 /dev/null filename.txt

sudo curl --output /usr/share/keyrings/nginx-keyring.gpg  \
      https://unit.nginx.org/keys/nginx-keyring.gpg
This eliminates the packages cannot be authenticated warnings during installation.

<!-- https://askubuntu.com/questions/741410/skipping-acquire-of-configured-file-main-binary-i386-packages-as-repository-x -->
To configure Unit’s repository, create the following file named /etc/apt/sources.list.d/unit.list:
sudo install -m 666 /dev/null /etc/apt/sources.list.d/unit.list
sudo cat << EOF > /etc/apt/sources.list.d/unit.list
deb [arch=amd64 signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
deb-src [arch=amd64 signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
EOF
