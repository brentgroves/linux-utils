https://www.mongodb.com/docs/bi-connector/current/connect/powerbi/

https://www.mongodb.com/community/forums/t/connecting-power-bi-to-mongodb-server/4455

https://www.mongodb.com/docs/bi-connector/current/tutorial/create-system-dsn/


https://community.powerbi.com/t5/Desktop/Trying-to-connect-to-MongoDB-using-MongoDB-ODBC-driver/m-p/699332

I am trying to connect PowerBI to MongoDB database using MongoDB ODBC connector after doing all steps listed in this link: https://docs.mongodb.com/bi-connector/master/local-quickstart/

 

To create a Data Source Name (DSN)  I have used https://docs.mongodb.com/bi-connector/current/tutorial/create-system-dsn/


0. https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-windows/
1. download odbc driver 1.4.3
2. install mongodb bi connector https://www.mongodb.com/try/download/bi-connector
2.alt https://hub.docker.com/r/yeasy/mongo-connector
https://eder-chamale.medium.com/building-a-docker-image-for-mongo-bi-connector-c9872b1821ba

2. create a dsn with ansi driver
mongodb://my-user:JesusLives1%21@20.221.103.132:30351/admin?
