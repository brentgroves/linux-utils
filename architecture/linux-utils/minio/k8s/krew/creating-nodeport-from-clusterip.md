# Creating a nodeport

## Use Cluster IP values to create a Nodeport

```yaml
kubectl get svc mycluster -o yaml

apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2023-10-20T22:46:52Z"
  labels:
    mysql.oracle.com/cluster: mycluster
    tier: mysql
  name: mycluster
  namespace: default
  ownerReferences:
  - apiVersion: mysql.oracle.com/v2
    blockOwnerDeletion: true
    controller: true
    kind: InnoDBCluster
    name: mycluster
    uid: 6b76dbaf-38c0-4707-b992-d9a537db8b86
  resourceVersion: "5187195"
  uid: a44df7a1-f7bf-4dc4-beb2-2f3893c218b4
spec:
  clusterIP: 10.152.183.194
  clusterIPs:
  - 10.152.183.194
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: mysql
    port: 3306
    protocol: TCP
    targetPort: 6446
  - name: mysqlx
    port: 33060
    protocol: TCP
    targetPort: 6448
  - name: mysql-alternate
    port: 6446
    protocol: TCP
    targetPort: 6446
  - name: mysqlx-alternate
    port: 6448
    protocol: TCP
    targetPort: 6448
  - name: mysql-ro
    port: 6447
    protocol: TCP
    targetPort: 6447
  - name: mysqlx-ro
    port: 6449
    protocol: TCP
    targetPort: 6449
  - name: router-rest
    port: 8443
    protocol: TCP
    targetPort: 8443
  selector:
    component: mysqlrouter
    mysql.oracle.com/cluster: mycluster
    tier: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

```

## Map ClusterIP to Nodeport

The selector and target port values are especially important.

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: mycluster-np
  namespace: default
  labels:
    mysql.oracle.com/cluster: mycluster
    tier: mysql
spec:
  type: NodePort
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  selector:
    component: mysqlrouter
    mysql.oracle.com/cluster: mycluster
    tier: mysql    
  ports:
  - name: mycluster-np
    nodePort: 30051
    # A Service definition specifies the port number that the Service will listen on for incoming traffic using the port field. 
    port: 3306
    protocol: TCP
    # pod’s port number that the Service is responsible for routing traffic to
    targetPort: 6446
```
