https://cloudoki.com/mongodb-docker/

By default, if you start a MongoDB instance, it won't have any authentication setup. This can be activated by making some changes to the config file. Since there is no configuration file, it needs to be created. You can find one by entering the container and taking /etc/mongod.conf.orig or you can get it on MongoDB's GitHub repo: https://github.com/mongodb/mongo/blob/master/rpm/mongod.conf. By default, MongoDB will look for a configuration file in /etc/mongod.conf.

You then add this block and restart the service:

security:
  authorization: "enabled"
The file should look like this:

# mongod.conf
# ogirinal default file can be found here: https://github.com/mongodb/mongo/blob/master/rpm/mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
# net:
#   port: 27017
#   bindIp: 127.0.0.1


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

security:
  authorization: "enabled"
Notice also the network interfaces. By keeping it commented, MongoDB will accept connections from any IP address. You can uncomment as is to accept only local connections, or you can add additional addresses.

Now, the problem with our configuration file is that it is not persisted and you would need to restart the MongoDB service inside the container. This is a bit nonsense.

The final solution is to keep the configuration file in your computer, mount another volume and tell MongoDB that it should read a configuration file.

I've created a cnf directory next to my data directory in /var/docker/mongo/. Side note: I now run all my local databases in Docker, and mount whatever volumes I need in /var/docker, such as /var/docker/mysql/.

Create the directory where I would mount the config volume:

mkdir -p /var/docker/mongo/cnf
Run mongo on Docker:

docker run --rm -d -p 27017:27017 --name mongodb \
-v /var/docker/mongo/data:/data/db \
-v /var/docker/mongo/cnf:/etc/mongo \
-e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
-e MONGO_INITDB_ROOT_PASSWORD=someStrongPassword \
mongo --config /etc/mongo/mongod.conf