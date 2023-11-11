https://www.mongodb.com/docs/bi-connector/master/reference/mongosqld/#mongodb-binary-bin.mongosqld

mongosqld accepts incoming requests from a SQL client and proxies those requests to a mongod or mongos instance.
https://www.mongodb.com/docs/bi-connector/master/reference/mongosqld/#std-label-mongosqld-usage-examples

mongosqld with a Configuration File
If you wish to specify a configuration file which saves logs to /var/log/mongosqld.log and loads a schema from /var/schema.drdl, you may save a file such as the following to /etc/mongosqld.conf:

WARNING
All paths specified in the configuration file must be absolute, e.g. they must begin with /.

sudo touch /etc/mongosqld.conf
sudo chmod 666 /etc/mongosqld.conf
code /etc/mongosqld.conf
sudo touch /var/log/mongosqld.log
sudo chmod 666 /var/log/mongosqld.log

systemLog:
  path: /var/log/mongosqld.log
schema:
  path: /var/schema.drdl

You may then start mongosqld with the --config option:
mongosqld --config /etc/mongosqld.conf
tail -f -n 25 ~/log/mongosqld.log


RUN apt-get install -y libssl1.0.0 libssl-dev libgssapi-krb5-2 wget
libgssapi_krb5.so

# compass connection string
remember directConnection=true or will not work.
mongodb://my-user:JesusLives1%21@20.221.103.132:30351/?serverSelectionTimeoutMS=5000&connectTimeoutMS=10000&authSource=admin&authMechanism=SCRAM-SHA-256&directConnection=true&tls=false

mongosh 20.221.103.132:30351 -u my-user -p 

mongodb://my-user:JesusLives1!@20.221.103.132:30351/databaseName?authSource=admin

# Studio3T connection string
mongodb://my-user:JesusLives1%21@20.221.103.132:30351/?serverSelectionTimeoutMS=5000&connectTimeoutMS=10000&authSource=admin&authMechanism=SCRAM-SHA-256&3t.uriVersion=3&3t.connection.name=reports-aks&3t.alwaysShowAuthDB=true&3t.alwaysShowDBFromUserRole=true


For more information on starting mongosqld as a system service, see the Installation Guide for your operating system.



You can start 
mongosqld
 either with a schema file in .drdl format using the 
--schema
 option or by sampling data from a MongoDB instance to create the schema.

You can specify which namespace or namespaces to sample data from with the 
--sampleNamespaces
 option. If you don't specify any namespaces or a schema file, 
mongosqld
 samples data from all databases in the target MongoDB instance except the admin and local databases.

You can specify a database in which to store schema information with the 
--schemaSource
 option. Otherwise, 
mongosqld
 holds the schema in memory.

 Starting mongosqld with a Schema File
Use the 
--schema
 option to specify a schema file when starting 
mongosqld.

mongosqld --schema /path/to/schema-file.drdl

Use mongodrdl to create a schema file from a MongoDB instance.

Starting mongosqld with a Schema Database
Use the 
--schemaSource
 option to specify a database to store schema information.

mongosqld --schemaSource sampleDb

Starting mongosqld with Specified Namespaces
Use the 
--sampleNamespaces
 option to specify databases and collections for 
mongosqld
 to sample data from to create the schema.

mongosqld --sampleNamespaces contacts.addresses



