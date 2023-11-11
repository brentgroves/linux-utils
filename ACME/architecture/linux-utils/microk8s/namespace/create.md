cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Namespace
metadata:
  name: test
  labels:
    name: test
EOF
