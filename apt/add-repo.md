<!-- https://askubuntu.com/questions/741410/skipping-acquire-of-configured-file-main-binary-i386-packages-as-repository-x -->
To configure Unit’s repository, create the following file named /etc/apt/sources.list.d/unit.list:
sudo install -m 666 /dev/null /etc/apt/sources.list.d/unit.list
sudo cat << EOF > /etc/apt/sources.list.d/unit.list
deb [arch=amd64 signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
deb-src [arch=amd64 signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
EOF