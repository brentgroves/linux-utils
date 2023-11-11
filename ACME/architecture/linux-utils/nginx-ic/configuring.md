https://docs.nginx.com/nginx-ingress-controller/configuration/global-configuration/configmap-resource/
ConfigMap Resource
The ConfigMap resources allows you to customize or fine tune NGINX behavior.

The ConfigMap resources allows you to customize or fine tune NGINX behavior. For example, set the number of worker processes or customize the access log format.

Using ConfigMap
Our installation instructions deploy an empty ConfigMap while the default installation manifests specify it in the command-line arguments of the Ingress Controller. However, if you customized the manifests, to use ConfigMap, make sure to specify the ConfigMap resource to use through the command-line arguments of the Ingress Controller.

Create a ConfigMap file with the name nginx-config.yaml and set the values that make sense for your setup:

kind: ConfigMap
apiVersion: v1
metadata:
  name: nginx-config
  namespace: nginx-ingress
data:
  proxy-connect-timeout: "10s"
  proxy-read-timeout: "10s"
  client-max-body-size: "2m"
See the section Summary of ConfigMap Keys for the explanation of the available ConfigMap keys (such as proxy-connect-timeout in this example).

Create a new (or update the existing) ConfigMap resource:

$ kubectl apply -f nginx-config.yaml
The NGINX configuration will be updated.

ConfigMap and VirtualServer/VirtualServerRoute Resource
The ConfigMap affects every VirtualServer and VirtualServerRoute resources. However, the fields of those resources allow overriding some ConfigMap keys. For example, the connect-timeout field of the upstream overrides the proxy-connect-timeout ConfigMap key.

See the doc about VirtualServer and VirtualServerRoute resources.

