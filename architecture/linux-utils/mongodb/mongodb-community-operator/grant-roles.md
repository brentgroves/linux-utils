db.createUser({user: "adminuser" , pwd: "password123", roles: [  "userAdminAnyDatabase","readWriteAnyDatabase" ]})
https://www.mongodb.com/docs/manual/reference/method/db.grantRolesToUser/
db.grantRolesToUser(
   "my-user",
   [ {role: "readWriteAnyDatabase", db: "admin"} ]
);

db.grantRolesToUser(
"my-user",
[{
  "role" : "clusterAdmin",
  "db" : "admin"
},
{
  "role" : "dbAdminAnyDatabase",
  "db" : "admin"
},
{
  "role" : "readWriteAnyDatabase",
  "db" : "admin"
}]
);
