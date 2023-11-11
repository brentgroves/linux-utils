<https://komodor.com/learn/kubernetes-operator/>

4 Problems Kubernetes Operators Can Solve
Kubernetes has many powerful features for deploying and managing applications at scale, but it does have some limitations that operators can help to address. Some of the main limitations that operators can solve are:

Complexity: Complex applications often require a lot of custom configuration and operational knowledge to deploy and manage on Kubernetes. Operators can encode this knowledge into the operator itself, making it easier to deploy and manage these applications.

Custom logic: Kubernetes provides a set of core features that can be used to deploy and manage applications, but it may not always have the specific features needed to manage certain types of applications. Operators can provide custom logic to handle these cases, making it possible to use Kubernetes to manage a wider range of applications.

Custom resource definitions: Some applications require custom resources that are not part of the core Kubernetes API. Operators can create custom resource definitions (CRDs) to represent these resources, and provide custom logic for managing them.
Ongoing management: Applications often require ongoing management, such as updates, backups, and scaling. Operators can provide custom logic to handle these tasks, making it easier to manage applications over time.

How Operators Manage Kubernetes Applications
Kubernetes operators are designed to manage Kubernetes applications in a more automated and efficient way. They do this by providing domain-specific knowledge and custom logic to handle the deployment and ongoing management of applications on Kubernetes. Here are some of the main ways in which operators manage Kubernetes applications:

Domain-specific knowledge: Operators can provide domain-specific knowledge and custom logic to handle the deployment and management of applications in a specific domain, such as databases or message brokers. This can make it easier to deploy and manage complex applications that require specialized knowledge.

Removing difficult manual tasks: Operators can automate a wide range of tasks that would otherwise be performed manually, such as updates, backups, and scaling. This can make it easier to manage applications over time and reduce the workload of operators.

Making it easier to deploy foundation services: Operators can make it easier to deploy and run the foundation services that applications depend on, such as databases, message brokers, and other types of infrastructure. This can save time and effort when deploying applications on Kubernetes.

Providing a consistent way to distribute software: Operators can provide a consistent way to distribute software on Kubernetes clusters, making it easier to deploy applications consistently across multiple clusters.
Reducing support burdens: Operators can help to identify and correct problems with applications, reducing the support burden on operators and making it easier to manage applications over time.
Implementing SRE: Operators can help to implement site reliability engineering (SRE) principles in Kubernetes, making it easier to ensure that applications are reliable and available.
