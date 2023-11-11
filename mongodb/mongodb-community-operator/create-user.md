db.createUser({user: "adminuser" , pwd: "password123", roles: [  "userAdminAnyDatabase","readWriteAnyDatabase" ]})
https://www.mongodb.com/docs/manual/reference/method/db.grantRolesToUser/
db.grantRolesToUser(
   "my-user",
   [ "readWriteAnyDatabase" ]
)


db.runCommand(