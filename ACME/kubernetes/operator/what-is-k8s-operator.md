<https://komodor.com/learn/kubernetes-operator/>

What Is a Kubernetes Operator?
A Kubernetes operator is a method of packaging, deploying, and managing a Kubernetes application. An operator uses the Kubernetes API to automate tasks such as deployment, scaling, and management of applications.

Operators are typically implemented as custom controllers that extend the Kubernetes API with new resources, and provide custom logic for managing these resources. For example, a database operator might create a custom resource called Database that represents a database instance, and provide custom logic for creating and managing instances of this resource.

```bash
kubectl get crds 
innodbclusters.mysql.oracle.com                       2023-10-07T20:09:05Z
mysqlbackups.mysql.oracle.com                         2023-10-07T20:09:05Z

```

Operators allow you to encode operational knowledge and best practices for running a specific application on Kubernetes into the operator itself, making it easier to deploy and manage complex applications on Kubernetes. They also allow you to use the Kubernetes API and tools such as kubectl to manage your applications, rather than having to use custom scripts or tools.

Operators are an increasingly popular way to deploy and manage applications on Kubernetes, and are used by a growing number of organizations to automate the management of complex applications such as databases, message brokers, and other types of infrastructure.

This is part of a series of articles about Kubernetes Architecture.
