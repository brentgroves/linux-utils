<https://docs.digitalocean.com/products/marketplace/catalog/kubernetes-metrics-server/>

Metrics server is an open source metrics API implementation, created and maintained by the Kubernetes SIG. Main purpose of metrics-server is to help the Kubernetes Horizontal Pod Autoscaler to automatically scale up or down your application workloads based on external factors (such as heavy HTTP traffic). In a nutshell, metrics-server works by collecting resource metrics from Kubelets and exposing them via the Kubernetes API Server to be consumed by the Horizontal Pod Autoscaler (aka HPA). Metrics API can also be accessed by kubectl top, making it easier to debug autoscaling pipelines.

Although you can query metrics-server for resource utilization metrics such as CPU and memory, it’s not advised to do so. This is due to the fact that provided metrics data may not be very accurate. For better results you would want to use a dedicated monitoring solution like Prometheus.

Please make sure to check metrics-server official documentation for more details.
