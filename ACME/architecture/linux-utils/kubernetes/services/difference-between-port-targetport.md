<https://www.baeldung.com/ops/kubernetes-k8s-service-targetport-vs-port#:~:text=What%20Is%20port%3F,the%20pods%20it's%20responsible%20for.&text=We%20set%20the%20port%20field,this%20Service's%20port%208080>.

What Is port? A Service definition specifies the port number that the Service will listen on for incoming traffic using the port field. The Service uses this port to route traffic to the pods it's responsible for. We set the port field to 8080, which directs incoming traffic to this Service's port 8080

What Is port?
A Service definition specifies the port number that the Service will listen on for incoming traffic using the port field. The Service uses this port to route traffic to the pods it’s responsible for.

Here’s an example of the YAML definition for a Service with the port field set to 8080:

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - name: http
      port: 8080
      protocol: TCP
      targetPort: 8080
We set the port field to 8080, which directs incoming traffic to this Service‘s port 8080. Similarly, we also set the targetPort field to 8080, which routes the traffic to the pods that this Service is responsible for, specifically to their port 8080.

3. What Is targetPort?
In a Service definition, the targetPort field plays a crucial role in routing traffic to the Service‘s pods. Specifically, this field is set to the pod’s port number that the Service is responsible for routing traffic to. By doing so, we can ensure that traffic is directed to the appropriate pods and that our Service functions as intended.

To illustrate, let’s suppose that a pod is running a web server on port 8080. In this case, the targetPort field in the Service definition would be set to 8080, which enables traffic to be routed to that specific pod. Correctly setting the targetPort field is essential for maintaining the reliability and availability of our application.

Here’s an example of the YAML definition for a Service with the targetPort field set to 8080:

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080
The targetPort field routes traffic to port 8080 on the Service‘s pods. The port field directs incoming traffic to port 80 on the Service.

4. The Difference Between port and targetPort
The primary distinction between port and targetPort is that port specifies the Service‘s listening port for incoming traffic. The targetPort field specifies the port number for routing traffic to the Service‘s pods.

To put it simply, port is used to listen for incoming traffic from external clients, while targetPort is the Service‘s internal communication port with the pods responsible for handling that traffic.
