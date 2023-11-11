https://www.mongodb.com/docs/database-tools/mongodump/

If you are archiving stale data to save on storage costs, consider 
Online Archive
 in 
MongoDB Atlas
. Online Archive automatically archives infrequently accessed data to fully-managed S3 buckets for cost-effective data tiering.

connection string:
mongodump mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]

https://www.tutorialspoint.com/mongodb/mongodb_create_backup.htm#:~:text=To%20create%20backup%20of%20database,backup%20of%20your%20remote%20server.

mongodump --host HOST_NAME --port PORT_NUMBER	This commmand will backup all databases of specified mongod instance.	mongodump --host tutorialspoint.com --port 27017

mongodump --dbpath DB_PATH --out BACKUP_DIRECTORY	This command will backup only specified database at specified path.	mongodump --dbpath /data/db/ --out /data/backup/

mongodump --collection COLLECTION --db DB_NAME	This command will backup only specified collection of specified database.	mongodump --collection mycol --db test

mongodump mongodb://adminuser:password123@reports11:30311 --out /home/brent/backups/mongo
mongodump mongodb://adminuser:password123@reports11:30311 --out /mnt/qnap_avi/mongo/$(/bin/date +\%Y-\%m-\%d-\%R:\%S)
 
/mnt/qnap_avi/mongo/2023-02-14-16:24:22
mongodb://adminuser@reports31:30331/admin?connectTimeoutMS=10000&authSource=admin&authMechanism=SCRAM-SHA-1&3t.uriVersion=3&3t.connection.name=reports31&3t.databases=admin,databaseName&3t.alwaysShowAuthDB=true&3t.alwaysShowDBFromUserRole=true

mongosh --host reports11 --port 30311 -u adminuser -p password123 --authenticationDatabase admin
const adminDb = db.getSiblingDB('admin');
use admin
db.system.users.find()
db.auth("adminuser", "password123");
const testDb = db.getSiblingDB('test');

https://hevodata.com/learn/install-mongodb-tools/

# insert a document into the collection
testDb.movies.insertOne(
  {
    title: "The Favourite",
    genres: [ "Drama", "History" ],
    runtime: 121,
    rated: "R",
    year: 2018,
    directors: [ "Yorgos Lanthimos" ],
    cast: [ "Olivia Colman", "Emma Stone", "Rachel Weisz" ],
    type: "movie"
  }
);
# retrieve the document
db.movies.find( { title: "The Favourite" } );
