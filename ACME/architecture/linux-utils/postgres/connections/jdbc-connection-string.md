<https://jdbc.postgresql.org/documentation/ssl/>

# connecting to postgres jdbc connection string

## setup kubectl port forwarding

<https://postgres-operator.readthedocs.io/en/latest/user/#connect-to-postgresql>

export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)

kubectl port-forward $PGMASTER 6432:5432 -n default

## with dbeaver and kubectl port forwarding

don't need the password param because it will prompt you and allow it to be saved
String url = "jdbc:postgresql://localhost/zalando?user=postgres&&port=6432&sslmode=disable";
