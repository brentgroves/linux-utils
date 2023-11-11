https://www.mongodb.com/docs/database-tools/
**list tools** 
sudo dpkg -l mongodb-database-tools
sudo apt install ./mongodb-database-tools-*-100.6.0.deb


The MongoDB Database Tools are a collection of command-line utilities for working with a MongoDB deployment. The Database Tools include the following binaries:

Binary Import / Export
    mongodump
Creates a binary export of the contents of a 
mongod
 database.
    mongorestore
Restores data from a mongodump database dump into a 
mongod
 or 
mongos
    bsondump
Converts 
BSON
 dump files into 
JSON.
Data Import / Export
    mongoimport
Imports content from an 
Extended JSON
, CSV, or TSV export file.
    mongoexport
Produces a 
JSON
 or 
CSV
 export of data stored in a 
mongod
 instance.
Diagnostic Tools
    mongostat
Provides a quick overview of the status of a currently running 
mongod
 or 
mongos
 instance.
    mongotop
Provides an overview of the time a 
mongod
 instance spends reading and writing data.
GridFS Tools
    mongofiles
Supports manipulating files stored in your MongoDB instance in 
GridFS
 objects.
https://hevodata.com/learn/install-mongodb-tools/

Types of MongoDB Database Tools
In this post, you will discuss how to install MongoDB Tools in the Operating System of your choice, but before that let’s delve into a small introduction of these tools. 

The MongoDB  Database Tools consist of the following binaries: 

Data Import/Export tools 
mongoimport: Imports content into mongod, from an Extended JSON/CSV/TSV export file. 
mongoexport: Produces a JSON or CSV export of the data stored in a mongod instance. 
Binary Import / Export
mongodump: Creates a binary export of the data stored in a mongod database.
mongorestore: Restores data from a mongodump database dump into a mongod or mongos.
bsondump: Converts BSON dump files into JSON for further use by mongoexport OR other tools 
GridFS Tools
mongofiles: They are used for manipulating GridFS object files.
For storing objects internally, MongoDB uses the Binary JSON or BSON format, where the data is decomposed into binary format to enable faster reads by eliminating the need of parsing JSON with every read request. 

But BSON has a size limit of 16MB per file, so for files that exceed this 16MB limit, the GridFS protocol is used to divide a file into parts/chunks, and stores each chunk as a separate document.  

As you can see these tools are essential in enabling proper usage of your MongoDB. Since these tools interact extensively with the underlying file system and hence the operating system (OS), they are installed differently on different OS. 


Here we will discuss the latest version at the time of writing this post, which is 100.5.1 and it’s compatible with the following Unix-based (x86_64 architecture) systems. 

Amazon Linux 2 and 2013.03+
Debian 10, 9, and 8
RHEL / CentOS 8, 7, and 6
SUSE 12
Ubuntu 20.04, 18.04, 16.04, and 14.04


