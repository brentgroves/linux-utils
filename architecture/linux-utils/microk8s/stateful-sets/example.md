Use the StatefulSets controller in the Kubernetes cluster for deploying stateful applications, such as Oracle, MySQL, Elasticsearch, and MongoDB. While cloning and syncing data must still be completed manually, StatefulSets go a long way in easing the complexity involved in deploying stateful applications.

How to Create a StatefulSet in Kubernetes
In this section, you will learn how to create a Pod for MySQL database using the StatefulSets controller.

#Create a Secret
To start, you will need to create a Secret for the MySQL application that will store sensitive information, such as usernames and passwords. Here, I am creating a simple Secret. However, in a production environment, using the HashiCorp Vault is recommended. Use the following code to create a Secret for MySQL:

apiVersion: v1
kind: Secret
metadata:
  name: mysql-password
type: opaque
stringData:
  MYSQL_ROOT_PASSWORD: password

Create a MySQL StatefulSet Application
Before creating a StatefulSet application, check your volumes by getting the persistent volume list:
kubectl get pv
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-reports31-pvc   Bound    pvc-d042188e-7e0a-4182-8fcd-e4b089ef5630   5Gi        RWO            mayastor       47h

Next, get the persistent volume claim list:

kubectl get pvc
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-reports31-pvc   Bound    pvc-d042188e-7e0a-4182-8fcd-e4b089ef5630   5Gi        RWO            mayastor       47h

Last, get the storage class list:

kubectl get storageclass

NAME         PROVISIONER               RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
mayastor-3   io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  3d20h
mayastor     io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  3d20h

Then use the following code to create a MySQL StatefulSet application in the Kubernetes cluster:

apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql-set
spec:
  selector:
    matchLabels:
      app: mysql
  serviceName: "mysql"
  replicas: 3
  template:
    metadata:
      labels:
        app: mysql
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: mysql
        image: mysql:5.7
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: mysql-store
          mountPath: /var/lib/mysql
        env:
          - name: MYSQL_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: mysql-password
                key: MYSQL_ROOT_PASSWORD
  volumeClaimTemplates:
  - metadata:
      name: mysql-store
    spec:
      accessModes: ["ReadWriteOnce"]
      storageClassName: "linode-block-storage-retain"
      resources:
        requests:
          storage: 5Gi

Here are a few things to note:

The kind is a StatefulSet. kind tells Kubernetes to create a MySQL application with the stateful feature.
The password is taken from the Secret object using the secretKeyRef.
The Linode block storage was used in the volumeClaimTemplates. If you are not mentioning any storage class name here, then it will take the default storage class in your cluster.
The replication count here is 3 (using the replica parameter), so it will create three Pods named mysql-set-0, mysql-set-1, and mysql-set-2.

Next, save the code using the file name mysql.yaml and execute using the following command:

kubectl apply -f mysql.yaml
Now that the MySQL Pods are created, get the Pods list:

kubectl get pods

NAME          READY   STATUS      RESTARTS   AGE
mysql-set-0   1/1         Running        0                 142s
mysql-set-1   1/1         Running        0                 132s
mysql-set-2   1/1         Running        0                 120s

Create a Service for the StatefulSet Application
Now, create the service for the MySQL Pod. Do not use the load balancer service for a stateful application, but instead, create a headless service for the MySQL application using the following code:

apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  ports:
  - port: 3306
  clusterIP: None
  selector:
    app: mysql

Save the code using the file name mysql-service.yaml and execute using the following command:

kubectl apply -f mysql-service.yaml
Get the list of running services:

kubectl get svc

Create a Client for MySQL
If you want to access MySQL, then you will need a MySQL client tool. Deploy a MySQL client using the following manifest code:

apiVersion: v1
kind: Pod
metadata:
  name: mysql-client
spec:
  containers:
  - name: mysql-container
    image: alpine
    command: ['sh','-c', "sleep 1800m"]
    imagePullPolicy: IfNotPresent

Save the code using the file name mysql-client.yaml and execute using the following command:

kubectl apply -f mysql-client.yaml
Then enter this into the MySQL client:

kubectl exec --stdin --tty mysql-client -- sh
Finally, install the MySQL client tool:

apk add mysql-client    

Access the MySQL Application Using the MySQL Client
Next, access the MySQL application using the MySQL client and create databases on the Pods.

If you are not already in the MySQL client Pod, enter it now:

kubectl exec -it mysql-client /bin/sh
To access MySQL, you can use the same standard MySQL command to connect with the MySQL server:

mysql -u root -p -h host-server-name
For access, you will need a MySQL server name. The syntax of the MySQL server in the Kubernetes cluster is given below:

stateful_name-ordinal_number.mysql.default.svc.cluster.local

#Example
mysql-set-0.mysql.default.svc.cluster.local

Connect with the MySQL primary Pod using the following command. When asked for a password, enter the one you made in the “Create a Secret” section above.

mysql -u root -p -h mysql-set-0.mysql.default.svc.cluster.local
Next, create a database on the MySQL primary, then exit:

create database erp;
exit;
Now connect the other Pods and create the database like above:

mysql -u root -p -h mysql-set-1.mysql.default.svc.cluster.local

mysql -u root -p -h mysql-set-2.mysql.default.svc.cluster.local

Remember that while Kubernetes helps you set up a stateful application, you will need to set up the data cloning and data sync by yourself. This cannot be done by the StatefulSets.

Best Practices
If you are planning to deploy stateful applications, such as Oracle, MySQL, Elasticsearch, and MongoDB, then using StatefulSets is a great option. The following points need to be considered while creating stateful applications:

Create a separate namespace for databases.
Place all the needed components for stateful applications, such as ConfigMaps, Secrets, and Services, in the particular namespace.
Put your custom scripts in the ConfigMaps.
Use headless service instead of load balancer service while creating Service objects.
Use the HashiCorp Vault for storing your Secrets.
Use the persistent volume storage for storing the data. Then your data won’t be deleted even if the Pod dies or crashes.

Deployment objects are the most used controller to create Pods in Kubernetes. You can easily scale these Pods by mentioning replication count in the manifest file. For stateless applications, using Deployment objects is most suitable. For example, assume you are planning to deploy your Node.js application and you want to scale the Node.js application to five replicas. In this case, the Deployment object is well suited.

Conclusion
In this article, you learned about Kubernetes’s two main controllers for creating Pods: Deployments and StatefulSets. A Deployment object is well suited for stateless applications, and the StatefulSets controller is well suited for stateful applications. If you are planning to deploy stateful applications, such as MySQL and Oracle, then you should use the StatefulSets controller instead of the Deployment object.

The StatefulSets controller offers an ordinal number feature for each Pod starting from zero. This helps stateful applications easily set up a primary-replica architecture, and if a Pod dies, a new Pod is re-created using the same name. This is a very useful feature and does not break the chain of stateful application clusters. If you are scaling down, then it deletes in the reverse order.

Use the StatefulSets controller in the Kubernetes cluster for deploying stateful applications, such as Oracle, MySQL, Elasticsearch, and MongoDB. While cloning and syncing data must still be completed manually, StatefulSets go a long way in easing the complexity involved in deploying stateful applications.

