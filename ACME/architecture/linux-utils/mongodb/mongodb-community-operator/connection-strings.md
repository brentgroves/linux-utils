https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/connect-from-inside-k8s/#connect-from-inside-k8s

kubectl get secret <connection-string-secret-name> -n <my-namespace> \
-o json | jq -r '.data | with_entries(.value |= @base64d)'

kubectl get secret example-mongodb-admin-my-user -n mongo \
-o json | jq -r '.data | with_entries(.value |= @base64d)'


{
  "connectionString.standard": "mongodb://my-user:JesusLives1%21@example-mongodb-0.example-mongodb-svc.mongo.svc.cluster.local:27017,example-mongodb-1.example-mongodb-svc.mongo.svc.cluster.local:27017,example-mongodb-2.example-mongodb-svc.mongo.svc.cluster.local:27017/admin?replicaSet=example-mongodb&ssl=false",
  "connectionString.standardSrv": "mongodb+srv://my-user:JesusLives1%21@example-mongodb-svc.mongo.svc.cluster.local/admin?replicaSet=example-mongodb&ssl=false",
  "password": "JesusLives1!",
  "username": "my-user"
}

kubectl get svc -n mongo

example-mongodb-svc   ClusterIP   None         <none>        27017/TCP   38m
kubectl port-forward service/example-mongodb-svc -n mongo 8000:27017



1. kubectl get secret example-mongodb-admin-my-user -n mongo \
-o json

  {
    "apiVersion": "v1",
    "data": {
        "connectionString.standard": "bW9uZ29kYjovL215LXVzZXI6SmVzdXNMaXZlczElMjFAZXhhbXBsZS1tb25nb2RiLTAuZXhhbXBsZS1tb25nb2RiLXN2Yy5tb25nby5zdmMuY2x1c3Rlci5sb2NhbDoyNzAxNyxleGFtcGxlLW1vbmdvZGItMS5leGFtcGxlLW1vbmdvZGItc3ZjLm1vbmdvLnN2Yy5jbHVzdGVyLmxvY2FsOjI3MDE3LGV4YW1wbGUtbW9uZ29kYi0yLmV4YW1wbGUtbW9uZ29kYi1zdmMubW9uZ28uc3ZjLmNsdXN0ZXIubG9jYWw6MjcwMTcvYWRtaW4/cmVwbGljYVNldD1leGFtcGxlLW1vbmdvZGImc3NsPWZhbHNl",
        "connectionString.standardSrv": "bW9uZ29kYitzcnY6Ly9teS11c2VyOkplc3VzTGl2ZXMxJTIxQGV4YW1wbGUtbW9uZ29kYi1zdmMubW9uZ28uc3ZjLmNsdXN0ZXIubG9jYWwvYWRtaW4/cmVwbGljYVNldD1leGFtcGxlLW1vbmdvZGImc3NsPWZhbHNl",
        "password": "SmVzdXNMaXZlczEh",
        "username": "bXktdXNlcg=="
    },
    "kind": "Secret",
    "metadata": {
        "creationTimestamp": "2023-02-17T23:53:08Z",
        "name": "example-mongodb-admin-my-user",
        "namespace": "mongo",
        "ownerReferences": [
            {
                "apiVersion": "mongodbcommunity.mongodb.com/v1",
                "blockOwnerDeletion": true,
                "controller": true,
                "kind": "MongoDBCommunity",
                "name": "example-mongodb",
                "uid": "7eaba8d0-6e77-4b99-a676-11675232e60e"
            }
        ],
        "resourceVersion": "2367945",
        "uid": "688346e0-ea7e-4087-8694-5eb759e43139"
    },
    "type": "Opaque"
}

2. kubectl get secret example-mongodb-admin-my-user -n mongo \
-o json | jq -r '.data | with_entries(.value |= @base64d)'


{
  "connectionString.standard": "mongodb://my-user:JesusLives1%21@example-mongodb-0.example-mongodb-svc.mongo.svc.cluster.local:27017,example-mongodb-1.example-mongodb-svc.mongo.svc.cluster.local:27017,example-mongodb-2.example-mongodb-svc.mongo.svc.cluster.local:27017/admin?replicaSet=example-mongodb&ssl=false",
  "connectionString.standardSrv": "mongodb+srv://my-user:JesusLives1%21@example-mongodb-svc.mongo.svc.cluster.local/admin?replicaSet=example-mongodb&ssl=false",
  "password": "JesusLives1!",
  "username": "my-user"
}


# try to connect to pod
kubectl -n mongo exec --stdin --tty example-mongodb-0 -- /bin/bash
mongo -u adminuser