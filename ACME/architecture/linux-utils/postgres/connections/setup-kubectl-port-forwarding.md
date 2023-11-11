# setup-kubectl-port-forwarding-to-postgres-master-node

<https://postgres-operator.readthedocs.io/en/latest/user/#connect-to-postgresql>

export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)

kubectl port-forward $PGMASTER 6432:5432 -n default
