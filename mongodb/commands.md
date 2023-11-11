# db.account_period_balance.find( {} )
# db.account_period_balance.countDocuments()
# db.account_period_balance.dataSize()
# db.account_period_balance.find({}).limit(10)
# db.account_period_balance.find({}).skip(db.account_period_balance.countDocuments() - 10)
# db.account_period_balance.find({}, $orderby: {$natural : -1}})

https://www.mongodb.com/docs/manual/reference/command/listDatabases/

https://www.mongodb.com/docs/v5.3/reference/mongo-shell/

mongosh --host 10.1.59.171 --port 27017 -u adminuser -p password123
db.adminCommand('listDatabases')

db.adminCommand(
   {
     listDatabases: 1
   }
)

https://www.mongodb.com/docs/mongodb-shell/reference/configure-shell-settings-api/