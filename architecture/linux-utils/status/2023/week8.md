Good morning my dear ones,
I hope you had a good Valentines day, and you and your loved ones are doing well my friends! I appreciate the graciousness and kindness that each of you have shown towards me and each other :-) I feel very fortunate to be working with such a good group of men.
As always please feel free to ask me for help at anytime concerning whatever you need.
Blessing be upon you all!
- Bent
260-564-4868


Backups:
MySQL and MongoDB backups are being saved to MG-ENG-NAS/TS-453U-RP

Replication:
So far we have replicated MongoDb and Redis session storage for our web appe. Hopefully our SQL database can have replication when the time is right.

MongoDb Shared Cluster:
Highlights from https://www.mongodb.com/basics/replication:
With MongoDB, replication is achieved through a replica set. Writer operations are sent to the primary server (node), which applies the operations across secondary servers, replicating the data.
If the primary server fails (through a crash or system failure), one of the secondary servers takes over and becomes the new primary node via election. If that server comes back online, it becomes a secondary once it fully recovers, aiding the new primary node.
![Replication](https://webimages.mongodb.com/_com_assets/cms/mongodb-replication-pnxoiu53rz.svg?auto=format%2Ccompress)


MongoDB AKS:
- Storage: azure disk 
- 1 node and IP

Reports:
- Customer supplies report parameters and queue report to run
- ETL Pipeline generates MongoDB object with Id
- Customer can receive email with excel attachment or view report from teams tab.
- Report id is the parameter for the team tab power BI report.
- Report objects archived to Avilla qnap.
