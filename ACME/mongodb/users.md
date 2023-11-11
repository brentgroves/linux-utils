https://www.mongodb.com/docs/manual/reference/method/js-user-management/

https://www.folkstalk.com/2022/09/mongodb-create-admin-user-for-all-databases-with-code-examples.html
use admin
db.createUser({ user: "mongoadmin" , pwd: "mongoadmin", roles: ["userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]})
https://www.mongodb.com/docs/manual/reference/method/db.getUsers/
mongosh --host 10.1.59.171 --port 27017 -u adminuser -p password123
db.getUsers({})

How do you create a database admin user in MongoDB?
MongoDB Create Administrator User

The first step is to specify the “username” and “password” which needs to be created.
The second step is to assign a role for the user.
The db parameter specifies the admin database which is a special Meta database within MongoDB which holds the information for this user.