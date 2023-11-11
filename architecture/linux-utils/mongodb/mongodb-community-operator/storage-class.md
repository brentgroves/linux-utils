apiVersion: mongodbcommunity.mongodb.com/v1
kind: MongoDBCommunity
spec:
  statefulSet:
    spec:
      volumeClaimTemplates:
        - metadata:
            name: data-volume
          spec:
            accessModes: ["ReadWriteOnce"]
            storageClassName: mayastor
            resources:
              requests:
                storage: 5G
        - metadata:
            name: logs-volume
          spec:
            accessModes: [ "ReadWriteOnce" ]
            storageClassName: mayastor
            resources:
              requests:
                storage: 2G