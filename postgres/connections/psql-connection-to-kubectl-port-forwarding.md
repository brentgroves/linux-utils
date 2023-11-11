<https://jdbc.postgresql.org/documentation/ssl/>

# connecting to postgres

## setup kubectl port forwarding

<https://postgres-operator.readthedocs.io/en/latest/user/#connect-to-postgresql>

export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)

kubectl port-forward $PGMASTER 6432:5432 -n default

### connect using psql

pick a user password.
export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)
export PGPASSWORD=$(kubectl get secret zalando.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)
quoVESbqgd8VbMjknhUnP12UOpMfuXyM3dgwMUGYeNYayr8x6KaHbOZeJufWWeeU

{username}.{clustername}.credentials.postgresql.acid.zalan.do
export PGSSLMODE=require
export PGSSLMODE=disable

### connect with dbeaver

don't need the password param because it will prompt you and allow it to be saved
String url = "jdbc:postgresql://localhost/zalando?user=postgres&&port=6432&sslmode=disable";
