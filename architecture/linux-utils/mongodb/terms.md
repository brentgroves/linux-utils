https://www.mongodb.com/docs/v5.0/core/databases-and-collections/

Databases and Collections
Overview
MongoDB stores data records as documents (specifically BSON documents) which are gathered together in collections. A database stores one or more collections of documents.

Databases
In MongoDB, databases hold one or more collections of documents. To select a database to use, in 
mongosh
, issue the use <db> statement, as in the following example:

mongosh --host 10.1.59.171 --port 27017 -u adminuser -p password123
show dbs
use myDB

Create a Database
If a database does not exist, MongoDB creates the database when you first store data for that database. As such, you can switch to a non-existent database and perform the following operation in 
mongosh

use myNewDB
db.myNewCollection1.insertOne( { x: 1 } )

The insertOne() operation creates both the database myNewDB and the collection myNewCollection1 if they do not already exist. Be sure that both the database and collection names follow MongoDB Naming Restrictions.

Views
A MongoDB view is a queryable object whose contents are defined by an aggregation pipeline on other collections or views. MongoDB does not persist the view contents to disk. A view's content is computed on-demand when a client 
queries
 the view. MongoDB can require clients to have permission to query the view. MongoDB does not support write operations against views.

For example, you can:

Create a view on a collection of employee data to exclude any private or personal information (PII). Applications can query the view for employee data that does not contain any PII.

Create a view on a collection of collected sensor data to add computed fields and metrics. Applications can use simple find operations to query the data.

Create a view that joins two collections containing inventory and order history respectively. Applications can query the joined data without managing or understanding the underlying complex pipeline.

