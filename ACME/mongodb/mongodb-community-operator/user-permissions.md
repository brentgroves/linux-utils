db.getSiblingDB("admin").getUsers({ showCredentials: true })

Use db.getUsers() command:

db.getUsers({ showCredentials: true })
Note, users are defined on a database, typically admin. So you would have to run

db.getSiblingDB("admin").getUsers({ showCredentials: true })
In case you need to scan all databases, you could use this one:

db.adminCommand({ listDatabases: 1, nameOnly: true }).databases.forEach(function (doc) {
   db.getSiblingDB(doc.name).getUsers({ showCredentials: true }).forEach(function (user) {
      printjson({ _id: user._id, user: user.user, db: user.db, roles: user.roles });
   });
});


use admin
db.runCommand({ createRole: "_ReadWriteAnyDatabase",
  privileges: [
    { resource: { db: "", collection: "" }, actions: [ "collMod", "createCollection" ] }
  ],
  roles: [
    "readWriteAnyDatabase",
    { role: "read", db : "admin" }
  ]
})