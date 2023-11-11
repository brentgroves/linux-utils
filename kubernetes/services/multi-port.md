<https://livebook.manning.com/concept/kubernetes/multiple-port#:~:text=Your%20service%20exposes%20only%20a,pod's%20ports%208080%20and%208443>.

Your service exposes only a single port, but services can also support multiple ports. For example, if your pods listened on two ports—let’s say 8080 for HTTP and 8443 for HTTPS—you could use a single service to forward both port 80 and 443 to the pod’s ports 8080 and 8443. You don’t need to create two different services in such cases. Using a single, multi-port service exposes all the service’s ports through a single cluster IP.

apiVersion: v1
kind: Service
metadata:
  name: kubia
spec:
  ports:

- name: http
    port: 80
    targetPort: 8080
- name: https
    port: 443
    targetPort: 8443
  selector:
    app: kubia
