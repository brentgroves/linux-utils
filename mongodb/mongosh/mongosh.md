https://www.mongodb.com/docs/mongodb-shell/install/
mongosh is available as a PPA for Ubuntu 20.04 (Focal) and Ubuntu 18.04 (Bionic).

wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

sudo apt-get update

sudo apt-get install -y mongodb-mongosh

https://www.mongodb.com/docs/mongodb-shell/connect/

Connect With Authentication
To connect to a MongoDB deployment that requires authentication, use the --username and --authenticationDatabase options. mongosh prompts you for a password, which it hides as you type.

For example, to authenticate as user alice on the admin database, run the following command:

mongosh "mongodb://mongodb0.example.com:28015" --username alice --authenticationDatabase admin

To provide a password as part of the connection command instead of using the prompt, use the --password option. Use this option for programmatic usage of mongosh, like a 
driver.

