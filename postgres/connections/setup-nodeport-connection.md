# create a nodeport connection

## create a nodeport service

```bash
pushd /home/brent/src/reports/k8s
kubectl apply -f ./manifests/postgres-operator/nodeport.yaml
service/acid-minimal-cluster-0-np created
# or 
pushd /home/brent/src/linux-utils/postgres/connections
kubectl apply -f ./nodeport.yaml
service/acid-minimal-cluster-0-np created

kubectl get svc acid-minimal-cluster-0-np -owide         
NAME                        TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
acid-minimal-cluster-0-np   NodePort   10.152.183.21   <none>        5432:30451/TCP   4s    application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master

# connection to nodeport requires ssl and I don't know how to change the hba_file in zalando operator. Although it may be possible reference https://github.com/YuriSalesquw/postgres-operator/commit/c704844d676a9ca87b4aec3f2e65941836be21d2 and https://github.com/zalando/postgres-operator/issues/330

psql -U postgres -d zalando -h reports51 -p 30451
select * from pg_hba_file_rules();
hostssl   | {all}         | {all}       | all       |                                         | md5 
// select * from pg_hba_file_rules();
String url = "jdbc:postgresql://reports51/zalando?user=postgres&password=2mcnagDpaJkj3sIsl1wASZPvni8ndzqogofdLzkolNZNM3ibS0u0mZUFNH60a8aT&port=6432&sslmode=require";
```
