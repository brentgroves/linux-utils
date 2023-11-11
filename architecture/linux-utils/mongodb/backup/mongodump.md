https://www.mongodb.com/docs/database-tools/mongodump/#std-label-mongodump-examples
https://studio3t.com/whats-new/i-need-some-sample-datasets-for-mongodb-studio3t_ama/

mongodump --host "10.1.59.171:27017" -u adminuser -p password123
mongodump --host "10.1.59.171:27017" -u adminuser -p password123

mongodump --host "10.1.59.171:27017" --db=db1 --archive=db1.20221123.archive -u mongoadmin -p mongoadmin --authenticationDatabase admin
mongodump --host "10.1.59.171:27017" -u adminuser --archive=test.20150715.archive --authenticationDatabase admin
mongodump --host "10.1.59.171:27017" --db=admin --archive=admin.20221123.archive -u adminuser -p password123
mongodump --archive=test.20150715.archive --db=test --host "10.1.59.171:27017" -u adminuser -p password123

mongorestore --archive="mongodump-test-db" 

Copy and Clone Databases
Starting in version 4.2, MongoDB removes the deprecated copydb command and clone command.

As an alternative, users can use 
mongodump
 and mongorestore (with the mongorestore options --nsFrom and --nsTo).

For example, to copy the test database from a local instance running on the default port 27017 to the examples database on the same instance, you can:

Use 
mongodump
 to dump the test database to an archive mongodump-test-db:

mongodump --archive="mongodump-test-db" --db=test

Use mongorestore with --nsFrom and --nsTo to restore (with database name change) from the archive:

mongorestore --archive="mongodump-test-db" --nsFrom='test.*' --nsTo='examples.*'

Alternatively, instead of using an archive file, you can 
mongodump
 the test database to the standard output stream and pipe into mongorestore

mongodump --archive --db=test | mongorestore --archive  --nsFrom='test.*' --nsTo='examples.*'


Use mongodump with a Collection
The following operation creates a dump file that contains only the collection named records in the database named test. In this case the database is running on the local interface on port 27017:

mongodump  --db=test --collection=records

Use mongodump with a Database and Exclude Specified Collections
The following operation dumps all collections in the test database except for users and salaries:

mongodump  --db=test --excludeCollection=users --excludeCollection=salaries

Use mongodump with a Database and Exclude Specified Collections
The following operation dumps all collections in the test database except for users and salaries:

mongodump  --db=test --excludeCollection=users --excludeCollection=salaries


Output to an Archive File
To output the dump to an archive file, run 
mongodump
 with the --archive option and the archive filename. For example, the following operation creates a file test.20150715.archive that contains the dump of the test database.

mongodump --archive=test.20150715.archive --db=test

Compress the Output
To compress the files in the output dump directory, run 
mongodump
 with the new --gzip option. For example, the following operation outputs compressed files into the default dump directory.

mongodump --gzip --db=test

To compress the archive file output by 
mongodump
, use the --gzip option in conjunction with the 
--archive
 option, specifying the name of the compressed file.

mongodump --archive=test.20150715.gz --gzip --db=test

https://www.mongodb.com/docs/database-tools/mongodump/#std-label-mongodump-examples