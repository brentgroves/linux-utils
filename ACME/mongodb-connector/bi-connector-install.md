https://www.mongodb.com/docs/bi-connector/master/tutorial/install-bi-connector-debian/
https://eder-chamale.medium.com/building-a-docker-image-for-mongo-bi-connector-c9872b1821ba
Prerequisites
OpenSSL installed on your host.
To verify OpenSSL is installed on your system, run the following command:
dpkg -l | grep -i openssl
If OpenSSL is not installed, use your package manager to install it.

MongoDB User Permissions
If your MongoDB instance uses 
authentication
, your BI Connector instance must also use authentication. The user that connects to MongoDB via the mongosqld program must have permission to read from all the namespaces you wish to sample data from.

Install the BI Connector
# 1 Download the BI Connector from the 
MongoDB Download Center.
https://www.mongodb.com/try/download/bi-connector
mongodb-bi-linux-x86_64-ubuntu2004-v2.14.5.tgz

# 2 Install the MongoDB Connector for BI.
Extract the .tar archive you downloaded.
tar -xvzf mongodb-bi-linux-x86_64-ubuntu2004-v2.14.5.tgz
Install the programs within the bin/ directory into a directory listed in your system PATH.
pushd /home/brent/Downloads/bi-connector/mongodb-bi-linux-x86_64-ubuntu2004-v2.14.5
sudo install -m755 bin/mongo* /usr/local/bin/
# how to start bi connector
https://www.mongodb.com/docs/bi-connector/master/reference/mongosqld/#mongodb-binary-bin.mongosqld


# bi connect 

https://docs.mongodb.com/bi-connector/master/reference/mongosqld/#mongodb-host-options

# from mongosqld.conf
    # auth:
    #   username: <string>
    #   password: <string>
    #   source: <string> # This is the name of the database to authenticate against.
    #   mechanism: SCRAM-SHA-1
    #   gssapiServiceName: mongodb

    auth:
      username: my-user
      password: JesusLives1!
      source: admin
      mechanism: SCRAM-SHA-256
      gssapiServiceName: mongodb

    auth:
      username: <username>
      password: <password>
      source: <auth-db-name>
      mechanism: <auth-mechanism>
      gssapiServiceName: <service>   

security:
  enabled: true
  defaultMechanism: "SCRAM-SHA-256"
  defaultSource: "admin"
  gssapi:
    hostname: <string>
    serviceName: "mongosql"

127.0.0.1:3307
https://github.com/emmanuelvisage/docker-mongo-bi-connector/issues/1
https://www.mongodb.com/docs/bi-connector/master/reference/mongosqld/#std-option-mongosqld.--auth
mongosqld --auth \
          --mongo-authenticationSource admin \
         kubectl delete pod reports-mongodb-0  --mongo-authenticationMechanism SCRAM-SHA-256 \
          --mongo-uri "mongodb://20.221.103.132:30351/?serverSelectionTimeoutMS=5000&connectTimeoutMS=10000&directConnection=true"  \
          --addr "0.0.0.0" \
          --defaultAuthMechanism SCRAM-SHA-256 \
          --mongo-username my-user \
          --mongo-password JesusLives1!

          --addr "127.0.0.1,172.20.88.64" \
          --logPath=/log/sqld.log \

          /logs
mongosqld.log
docker rm $(docker stop $(docker ps -a -q --filter ancestor=brent/mongobi --format="{{.ID}}"))
docker run --publish 3307:3307 brent/mongobi /bin/bash
docker run -d -p 3307:3307 --name mongo-bi brent/mongobi
docker exec -it mongo-bi /bin/bash 

172.20.88.64:3307
touch ~/log/mongosqld.log
chmod 666 ~/log/mongosqld.log
mongosqld --config=/etc/mongosqld.conf
tail -f -n 25 ~/log/mongosqld.log

mongosqld --mongo-uri "mongodb://20.221.103.132:30351/?connect=direct
mongosqld --mongo-uri "mongodb://20.221.103.132:30351/?connect=direct

mongosqld --mongo-uri "mongodb://my-user:JesusLives1%21@20.221.103.132:30351/?serverSelectionTimeoutMS=5000&connectTimeoutMS=10000&authSource=admin&authMechanism=SCRAM-SHA-256&directConnection=true&tls=false"

https://stackoverflow.com/questions/50338686/mongodb-connector-for-bi-using-compose-io

docker build -t brentgroves/mongobi .
docker run -d -p 3307:3307 --name mongo-bi brentgroves/mongobi
docker tag brentgroves/mongobi brentgroves/mongobi:1
docker push brentgroves/mongobi:1