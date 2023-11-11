I love you my son and will always be there for you!
https://github.com/mongodb/mongodb-kubernetes-operator/issues/267
https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/multi-cluster-connect-from-outside-k8s/
https://stackoverflow.com/questions/57623894/how-access-mongodb-in-kubernetes-from-outside-the-cluster
https://statehub.io/resources/guides/deploying-mongodb-on-kubernetes-using-statehub/
https://www.youtube.com/watch?v=2Xszdg-4T6A&t=1368s
https://stackoverflow.com/questions/57623894/how-access-mongodb-in-kubernetes-from-outside-the-cluster
https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/deploy-replica-set/
https://www.mongodb.com/blog/post/run-secure-containerized-mongodb-deployments-using-the-mongo-db-community-kubernetes-oper
https://www.mongodb.com/blog/post/run-secure-containerized-mongodb-deployments-using-the-mongo-db-community-kubernetes-oper
Good morning dear ones,
I hope you and your loved ones are doing well and I look forward to working with each one of you this week as oppurtunities arise! I do feel very greatful to have the oppurtunity to work with such a great group of guys :-)
As always feel free to get in contact with me if there is anything that you need at work or at home.
Sincerely yours,
-Brent

Enhanced Reporting System
k8s:
Posix for cloud development.

Role based access control (RBAC):
It is a way to assign user rights to applications based on roles.

app armor:
It is a way for admins to assign resources to applictions.
    Limits:
      cpu:     1
      memory:  500M
    Requests:
      cpu:     500m
      memory:  400M

mongodb storage:
installed a k8s csi driver for our nfs server to be used by mongodb.
when mongodb is installed onto the k8s cluster it uses the nfs csi driver to claim space on the nfs server. Thinking about changing this to store the databases on our freeNAS server.
next storage: migrate from nfs to more modern openEBS cstor storage. 
https://openebs.io/docs/concepts/cstor 
why: Each mongodb replica has its database on the node its running on. All writes are done to 3 storage devices at once. Easy backup via snapshots.  
https://openebs.io/docs/concepts/cstor  

mongodb replica-set:
https://www.mirantis.com/blog/kubernetes-replication-controller-replica-set-and-deployments-understanding-replication-options/
Why? So that multiple databases can have the same data.
How? Instead of connecting to a single database you connect to a database cluster. So each database update is made to all of the databases within the cluster.
Using the opensource mongodb kubernetes community operator which does not have automatic backup as the professional operator.


A replica set is a group of MongoDB deployments that maintain the same data set. Replica sets provide redundancy and high availability and are the basis for all production deployments.
