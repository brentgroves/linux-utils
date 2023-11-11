Good morning dear ones,
I hope you are all refreshed and doing well on this Monday morning!  Thank you for your kindness and encouragements to one another which makes all the difference in working together :-) If you need my help with anything please feel free to contact me at home or work!
-Sincerely your,
Brent
260-564-4868 


MongoDB:
Deployed MongoDB on an Azure kubernetes cluster, aks.
The aks cluster comes with a load balancer for external access to MongoDB. 
Also had to deploy a MongoDB BI connector with external access through the same load balancer.

Power BI Reports:
Can connect to tons of data sources.
Connects to MongoDB by way of a MongoDB ODBC driver and a MySQL database.
Oddly enough this connector creates a normalized SQL schema in a MongoDB namespace and filters queries through MySQL somehow.

Our Reports:
Each one of our reports is stored as one object with an id in a MongoDB collection.
The customer can access the report using this object id indefinitely.
These report objects remain on the replicated MongoDB database for a period of time.
Then they are backed up to a QNAP.