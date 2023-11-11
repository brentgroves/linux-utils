microk8s kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: mayastor-nodeport
spec:
  type: NodePort
  selector:
    app: rest
  ports:
    - name: mayastor-nodeport
      nodePort: 30035
      port: 8081
      protocol: TCP
      targetPort: 8081
EOF           

microk8s kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: mayastor-nodeport
spec:
  type: NodePort
  selector:
    app: rest
  ports:
    - name: mayastor-nodeport
      nodePort: 30035
      port: 8080
      protocol: TCP
      targetPort: 8080
EOF