https://stackoverflow.com/questions/46456239/how-to-expose-a-headless-service-for-a-statefulset-externally-in-kubernetes
https://www.howtoforge.com/create-a-statefulset-in-kubernetes/

https://loft.sh/blog/kubernetes-statefulset-examples-and-best-practices/

Use the StatefulSets controller in the Kubernetes cluster for deploying stateful applications, such as Oracle, MySQL, Elasticsearch, and MongoDB. While cloning and syncing data must still be completed manually, StatefulSets go a long way in easing the complexity involved in deploying stateful applications.

What Are StatefulSets?
A StatefulSet is the Kubernetes controller used to run the stateful application as containers (Pods) in the Kubernetes cluster. StatefulSets assign a sticky identity—an ordinal number starting from zero—to each Pod instead of assigning random IDs for each replica Pod. A new Pod is created by cloning the previous Pod’s data. If the previous Pod is in the pending state, then the new Pod will not be created. If you delete a Pod, it will delete the Pod in reverse order, not in random order. For example, if you had four replicas and you scaled down to three, it will delete the Pod numbered 3.


When to Use StatefulSets
There are several reasons to consider using StatefulSets. Here are two examples:

Assume you deployed a MySQL database in the Kubernetes cluster and scaled this to three replicas, and a frontend application wants to access the MySQL cluster to read and write data. The read request will be forwarded to three Pods. However, the write request will only be forwarded to the first (primary) Pod, and the data will be synced with the other Pods. You can achieve this by using StatefulSets.
Deleting or scaling down a StatefulSet will not delete the volumes associated with the stateful application. This gives you your data safety. If you delete the MySQL Pod or if the MySQL Pod restarts, you can have access to the data in the same volume.

Take a look at the MySQL database deployment. Assume you are creating Pods for the MySQL database using the Kubernetes Deployment object and scaling the Pods. If you are writing data on one MySQL Pod, do not replicate the same data on another MySQL Pod if the Pod is restarted. This is the first problem with the Kubernetes Deployment object for the stateful application.

Stateful applications always need a sticky identity. While the Kubernetes Deployment object offers random IDs for each Pod, the Kubernetes StatefulSets controller offers an ordinal number for each Pod starting from zero, such as mysql-0, mysql-1, mysql-2, and so forth.

Stateful sets can read from all pods and get identical responses but the controller will only write to mysql-0 and then sync the write to the other volumes.

For stateful applications with a StatefulSet controller, it is possible to set the first Pod as primary and other Pods as replicas—the first Pod will handle both read and write requests from the user, and other Pods always sync with the first Pod for data replication. If the Pod dies, a new Pod is created with the same name.

The diagram below shows a MySQL **primary and replica architecture** with persistent volume and data replication architecture.

Now, add another Pod to that. The fourth Pod will only be created if the third Pod is up and running, and it will clone the data from the previous Pod.

n summary, StatefulSets provide the following advantages when compared to Deployment objects:

Ordered numbers for each Pod
The first Pod can be a primary, which makes it a good choice when creating a replicated database setup, which handles both reading and writing
Other Pods act as replicas
New Pods will only be created if the previous Pod is in running state and will clone the previous Pod’s data
Deletion of Pods occurs in reverse order