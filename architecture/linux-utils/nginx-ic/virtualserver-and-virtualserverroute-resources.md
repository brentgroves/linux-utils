https://docs.nginx.com/nginx-ingress-controller/configuration/virtualserver-and-virtualserverroute-resources
VirtualServer and VirtualServerRoute Resources
The VirtualServer and VirtualServerRoute resources are load balancing configurations recommended as an alternative to the Ingress resource.

The VirtualServer and VirtualServerRoute resources, introduced in release 1.5, enable use cases not supported with the Ingress resource, such as traffic splitting and advanced content-based routing. The resources are implemented as Custom Resources.

This document is the reference documentation for the resources. To see additional examples of using the resources for specific use cases, go to the examples/custom-resources folder in our GitHub repo.

irtualServer Specification
The VirtualServer resource defines load balancing configuration for a domain name, such as example.com. Below is an example of such configuration:

apiVersion: k8s.nginx.org/v1
kind: VirtualServer
metadata:
  name: cafe
spec:
  host: cafe.example.com
  tls:
    secret: cafe-secret
  upstreams:
  - name: tea
    service: tea-svc
    port: 80
  - name: coffee
    service: coffee-svc
    port: 80
  routes:
  - path: /tea
    action:
      pass: tea
  - path: /coffee
    action:
      pass: coffee
  - path: ~ ^/decaf/.*\\.jpg$
    action:
      pass: coffee
  - path: = /green/tea
    action:
      pass: tea