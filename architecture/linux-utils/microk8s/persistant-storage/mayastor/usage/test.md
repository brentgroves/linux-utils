deploy to test namespace:  
kubectl config use-context test
kubectl config current-context
test

cat <<EOF | kubectl create -f -
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  storageClassName: mayastor
  accessModes: [ReadWriteOnce]
  resources: { requests: { storage: 5Gi } }
---
apiVersion: v1
kind: Pod
metadata:
  name: test-nginx
spec:
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: test-pvc
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - name: pvc
          mountPath: /usr/share/nginx/html
EOF

kubectl get pods

NAME         READY   STATUS    RESTARTS   AGE
test-nginx   1/1     Running   0          85s

It works.

deploy statefulset to test namespace using mayastor sc:  
kubectl config use-context test
cat <<EOF | kubectl create -f -
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: registry.k8s.io/nginx-slim:0.8
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      storageClassName: mayastor
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
EOF

kubectl get pods

kubectl get msp -n mayastor
NAME                      NODE        STATUS   CAPACITY      USED         AVAILABLE
microk8s-reports13-pool   reports13   Online   21449670656   5368709120   16080961536
microk8s-reports12-pool   reports12   Online   21449670656   6442450944   15007219712
microk8s-reports11-pool   reports11   Online   21449670656   6442450944   15007219712


deploy statefulset to test namespace using mayastor-3 sc:  
kubectl config use-context test
cat <<EOF | kubectl create -f -
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: registry.k8s.io/nginx-slim:0.8
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      storageClassName: mayastor-3
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
EOF

kubectl get pods                                

NAME    READY   STATUS    RESTARTS   AGE
web-0   1/1     Running   0          4m54s
web-1   1/1     Running   0          4m43s

it works.

deploy mysql statefulset to test namespace using mayastor-3 sc:  
kubectl config use-context test
cat <<EOF | kubectl create -f -
---
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
---    
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  serviceName: "mysql"
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              key: password3
              name: lastpass
        - name: TZ
          value: America/Fort_Wayne
        image: brentgroves/mysql:8.0
        imagePullPolicy: Always
        name: mysql
        ports:
        - containerPort: 3306
          name: mysql-port
          protocol: TCP
        volumeMounts:
        - mountPath: /var/lib/mysql
          name: mysql-store
      terminationGracePeriodSeconds: 10
  volumeClaimTemplates:
  - metadata:
      name: mysql-store
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 1Gi
      storageClassName: mayastor-3
EOF
kubectl get pods
NAME      READY   STATUS    RESTARTS   AGE
mysql-0   1/1     Running   0          6m33s


kubectl config use-context microk8s
kubectl delete namespace
cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Namespace
metadata:
  name: test
  labels:
    name: test
EOF
