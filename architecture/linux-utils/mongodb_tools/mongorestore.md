mongorestore <options> <connection-string> <directory or file to restore>

db.movies.deleteMany({})
mongorestore mongodb://adminuser:password123@reports11:30311 /home/brent/backups/mongo
mongorestore mongodb://adminuser:password123@reports11:30311 /mnt/qnap_avi/mongo/2023-02-14-16:24:22

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
