# What is an **[API Gateway](https://www.nginx.com/learn/api-gateway/#:~:text=An%20API%20gateway%20is%20a%20data%2Dplane%20entry%20point%20for,%2C%20routing%2C%20and%20load%20balancing)**

API Gateway and Microservices Architecture
For microservices‑based applications, an API gateway acts as a single point of entry into the system. It sits in front of the microservices and simplifies both the client implementations and the microservices app by decoupling the complexity of an app from its clients.

In a microservices architecture, the API gateway is responsible for request routing, composition, and policy enforcement. It handles some requests by simply routing them to the appropriate backend service, and handles others by invoking multiple backend services and aggregating the results.

An API gateway might provide other capabilities for microservices such as authentication, authorization, monitoring, load balancing, and response handling, offloading implementation of non-functional requirements to the infrastructure layer and helping developers to focus on core business logic, speeding up app releases.

Learn more about Building **[Microservices Using an API Gateway](https://www.nginx.com/blog/building-microservices-using-an-api-gateway/)** on our blog.

API Gateway for Kubernetes
Containers are the most efficient way to run microservices, and Kubernetes is the de facto standard for deploying and managing containerized applications and workloads.

Depending on the system architecture and app delivery requirements, an API gateway can be deployed in front of the Kubernetes cluster as a load balancer (multi-cluster level), at its edge as an Ingress controller (cluster-level), or within it as a service mesh (service-level).
