https://www.mongodb.com/docs/database-tools/mongodump/#mongodb-binary-bin.mongodump

# connect to a mongodb instance
https://www.mongodb.com/docs/database-tools/mongodump/#connect-to-a-mongodb-instance

this will create a dump directory with bson files
BSON stands for Binary Javascript Object Notation. It is a binary-encoded serialization of JSON documents. BSON has been extended to add some optional non-JSON-native data types, like dates and binary data.

mongodump --host="mongodb0.example.com:27017"  [additional options]

mongodump --host "10.1.59.171:27017" -u adminuser -p password123


mongodump --uri="mongodb://mongodb0.example.com:27017" [additional options]

https://www.mongodb.com/docs/manual/core/backups/#ImportExportTools-mongorestore

https://www.mongodb.com/docs/manual/core/backups/#back-up-with-filesystem-snapshots

https://www.mongodb.com/docs/manual/core/backups/#back-up-with-cp-or-rsync

https://www.mongodb.com/docs/manual/core/backups/#back-up-with-mongodump

mongodump
 reads data from a MongoDB database and creates high fidelity BSON files which the 
mongorestore
 tool can use to populate a MongoDB database. 
mongodump
 and 
mongorestore
 are simple and efficient tools for backing up and restoring small MongoDB deployments, but are not ideal for capturing backups of larger systems.

mongodump
 and 
mongorestore
 operate against a running mongod process, and can manipulate the underlying data files directly. By default, 
mongodump
 does not capture the contents of the local database.

mongodump
 only captures the documents in the database. The resulting backup is space efficient, but 
mongorestore
 or mongod must rebuild the indexes after restoring data.

When connected to a MongoDB instance, 
mongodump
 can adversely affect mongod performance. If your data is larger than system memory, the queries will push the working set out of memory, causing page faults.

Applications can continue to modify data while 
mongodump
 captures the output. For replica sets, 
mongodump
 provides the 
--oplog
 option to include in its output oplog entries that occur during the 
mongodump
 operation. This allows the corresponding 
mongorestore
 operation to replay the captured oplog. To restore a backup created with 
--oplog
, use 
mongorestore
 with the 
--oplogReplay
 option.