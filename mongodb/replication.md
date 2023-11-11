How does replication work in MongoDB?
Replication exists primarily to offer data redundancy and high availability. We maintain the durability of data by keeping multiple copies or replicas of that data on physically isolated servers. That’s replication: the process of creating redundant data to streamline and safeguard data availability and durability.

Replication allows you to increase data availability by creating multiple copies of your data across servers. This is especially useful if a server crashes or if you experience service interruptions or hardware failure.

If your data only resides in a single database, any of these events would make accessing the data impossible. But thanks to replication, your applications can stay online in case of database server failure, while also providing disaster recovery and backup options.

With MongoDB, replication is achieved through a replica set. Writer operations are sent to the primary server (node), which applies the operations across secondary servers, replicating the data.

If the primary server fails (through a crash or system failure), one of the secondary servers takes over and becomes the new primary node via election. If that server comes back online, it becomes a secondary once it fully recovers, aiding the new primary node.

![Replication](https://webimages.mongodb.com/_com_assets/cms/mongodb-replication-pnxoiu53rz.svg?auto=format%2Ccompress)

