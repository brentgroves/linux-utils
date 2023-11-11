# First importance

I am with you always my son and I love you very much so do not worry! Also trust in my plan for you it is meant to teach you what you need to know as well as bring peace and joy to your life.  Remember to focus on forgiveness, humility, and generosity because this is what's most important to having a happy life!

Next:
Access the Kubernetes dashboard
<https://microk8s.io/#install-microk8s>
<https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md>
**[Study Contexts more especially how to stop dependant operaions](https://www.sohamkamani.com/golang/context/)**
Go run TB-test.sh publish success/failure.
<https://gist.github.com/cbess/d14f8ec78bf239b72645246c9ee3f67b> exec sproc
<https://www.linkedin.com/pulse/how-upload-file-via-graph-api-sharepoint-satheesh-kumar/>
<https://learn.microsoft.com/en-us/graph/api/chatmessage-post?view=graph-rest-1.0&tabs=http#example-4-send-a-message-with-file-attachment-in-it>
<https://www.techgeeknext.com/react/react-crud-example>

Good morning dear ones,
I hope all is going well for you and your loved ones in this beautuful Fall we are having. I am looking forward to working with each one of you and always please feel free to call me at work or at home at anytime about anything!

- Sincerely yours,
Bren
260-564-4868

The Report System Schedule:

- Work on the "report runner" as described below.
- Work on the "report SPA"
- Ask IT to create a K8s cluster and deploy reporting system over several weeks.
  - Download Ubuntu 22.04 server
  - Create 4 Ubuntu server VM
  - Install MicroK8s Kubernetes Cluster
  - Install AWS developed EBS dynamic storage, Mayastor.
  - Deploy MySQL
  - Deploy the report runner.
  - Deploy the report API.
  - Deploy the report SPA.
  
## IT k8s Administrator

Brendan is excited about helping to look after the reporting K8s cluster.

- Gave Brendan permisions to: devcon2, Azure Dev Ops project, and the reports5 k8s cluster.
  - sudo priviledges
  - Add Brendan's ed25519 public key to all reports5 nodes user's authorized_keys file using ssh-copy-id command.
  - Add Brendan's RSA public key to Azure Dev Ops Mobex Global Project.
  - Add to microk8s group. verify with:

```bash
        rdp devcon2 at 10.1.0.120
        open terminal
        ssh bcieslik@reports51
        microk8s status
        microk8s is running
        high-availability: yes
        datastore master nodes: 172.20.88.66:19001 172.20.88.67:19001 172.20.88.68:19001
        datastore standby nodes: 172.20.88.65:19001

```

Notes: The nodes are linked by static IP addresses so If there VMs are moved to a different hypervisor the IP addresses must stay the same.

- to monitor the reporting system.
- train himself on k8s

## PKI Admin

Mach2 and report system certificates must be generated every year. I suggest enlisting IT's help hear by do the following:

- Generating a private key from Niagara.
- Generating a CSR , SAN certificate, and certificate chain.
- Importing the certificate chain into Niagara.
- Use Niagara to set Jetty server to use new certificate chain.

## report runner

For each report database:
Each report has its own separate database.  For scalability there can be multiple regional databases per report.

- thread to monitor customer requests
- thread to run the ETL pipeline
- channel to pass info between the request and pipeline threads

## Go Lang

**[How to handle signals](https://www.developer.com/languages/os-signals-go/#:~:text=What%20are%20Signals%20in%20Go,%2C%20we%20press%20CTRL%2BC.)**
"The Go programming language is not built for system level programming like C, yet there are certain features that help developers interact with the underlying operating system at a bit of a low level, such as using signals."

The Go language's http package which is in the Go standard library. Seems to have everything you need to create an http server.  Wow a compiled low level language that comes with everything you need to create an http server in just a few lines of code!
With Go routines and contexts a developer has what they need to cordinate many activities and stopping gracefully stopping the code in the event of any failure such as a database being offline or any other type of networking error.

## OpenSSL vs NSS

**[OpenSSL vs NSS]<https://www.quora.com/How-does-one-decide-between-OpenSSL-GnuTLS-and-Mozillas-NSS>)**
"The fact is that OpenSSL almost certainly remains the most credible SSL/TLS library out there, followed closely by NSS and more distantly by GnuTLS."
I chose OpenSSL to implement our PKI because there is a lot of documentation for it and it seems to be the most popular for your typical business PKI at the moment.
Chromium, Firefox, Thunderbird, and Libre Office use NSS because it is more suited for development of an application that needs to use security object such as private keys and certificates and the fact that it comes with it's own security database assures its popularity.

## What is NSS

**[Network Security Services](https://wiki.archlinux.org/title/Network_Security_Services)**
Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.
Applications built with NSS can support SSL v2 and v3, TLS, PKCS #5, PKCS #7, PKCS #11, PKCS #12, S/MIME, X.509 v3 certificates, and other security standards.

NSS is required by many packages, including, for example, Chromium and Firefox.

cert9.db are also called "NSS databases". Paths to NSS databases for some applications are listed in the table below.

Application Path to NSS databases
chromium, evolution ~/.pki/nssdb/
firefox ~/.mozilla/firefox/<profile>/
thunderbird ~/.thunderbird/<profile>/
libreoffice-fresh configurable via Options [1]

**[Manage](https://man.archlinux.org/man/certutil.1)**
"Manage keys and certificate in both NSS databases and other NSS tokens"

## Plex printing

**[Zebra browser print](https://www.zebra.com/content/dam/zebra_new_ia/en-us/solutions-verticals/product/Software/Printer%20Software/Link-OS/browser-print/zebra-browser-print-user-guide-v1-3-en-us.pdf)**
Zebra has a new application called Browser Print. You can install that and use the js library they provide to print from the browser. When you install it will add a demo also. I used this recently and it works on chrome.

**[How to Print ZPL files directly to a Zebra printer using Generic Windows Text Printer](https://www.foldermill.com/kb/install-generic-text-driver-in-windows)**
"Installing the Generic Text Printer Driver for the Zebra or similar type of label printer will allow you to print ZPL directly from Notepad. This print driver supports all ASCII characters and most characters of other character sets, so you will be able to send text files like ZPL, TXT, or PRN containing the code. There will be no modification or file conversion to any other format in the middle of the printing process.
"

**[mobile ZPL print](https://play.google.com/store/apps/details?id=com.plex.zplprint&hl=en_US&gl=US&pli=1
)**

"The product <https://mobile.plexonline.com> supports printing labels, but the browser does not provide the ability to print labels. This app registers the "zpl" scheme on the device to add label printing capability. When the browser navigates to "zpl://?ip=192.168.33.2&port=9100&data=%5EXA%5EFO20%2C20%5EA0N%2C25%2C25%5EFDHello%20world.%5EFS%5EXZ" the operating system will direct the request to this application, which then extracts:

1. The ip address of the printer
2. The port of the printer
"

## Ceph Storage

**[Ceph](https://ceph.io/en/discover/)**
**[More Ceph](https://www.techbeatly.com/ceph-cluster-deployment-on-aws-mastering-distributed-storage/)**
"In today’s data-driven world, scalable and reliable storage solutions have become paramount. This is where Ceph, an open-source software-defined storage system, comes into play.
Ceph offers a flexible platform for efficiently managing vast amounts of data, meeting organizations’ storage demands. Combined with Amazon Web Services (AWS), Ceph on AWS provides unparalleled scalability, performance, and cost-effectiveness.
Benefits of Ceph as a Distributed Storage System:

Scalability: Ceph is designed to scale seamlessly from small deployments to massive petabyte-scale environments. Its distributed nature allows for the addition of storage nodes as the data volume increases, ensuring that businesses can accommodate their growing storage needs without disruption.
High Availability: Ceph replicates data across multiple nodes, ensuring that data remains accessible even during hardware failures or network outages. With built-in redundancy, Ceph eliminates single points of failure and provides continuous data availability.
Fault tolerance is another critical aspect of Ceph. It employs data redundancy and error correction mechanisms to protect against data loss. Ceph distributes data across nodes and utilizes techniques like replication or erasure coding to withstand component failures while preserving data integrity and reliability.
Ceph’s flexibility is a significant advantage for organizations with diverse storage requirements. It supports multiple storage interfaces, including object, block, and file storage. This versatility allows businesses to choose the most suitable storage model for their specific needs. Whether it’s storing virtual machine images, hosting databases, or managing large-scale file repositories, Ceph can adapt to various use cases seamlessly.
"
**[microceph](https://ubuntu.com/blog/cloud-storage-at-the-edge-with-microceph)**

## EBS Storage

**[EBS Storage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html)**
"Amazon Elastic Block Store (EBS) from AWS is designed for application workloads that benefit from fine tuning for performance, cost and capacity. Typical use cases include Big Data analytics engines (like the Hadoop/HDFS ecosystem and Amazon EMR clusters), relational and NoSQL databases (like Microsoft SQL Server and MySQL or Cassandra and MongoDB), stream and log processing applications (like Kafka and Splunk), and data warehousing applications (like Vertica and Teradata)."

## Mayastor EBS Storage

**[Mayastore](https://openebs.io/docs/2.12.x/concepts/mayastor)**
"Mayastor is currently under development as a sub-project of the Open Source CNCF project OpenEBS. OpenEBS is a "Container Attached Storage" or CAS solution which extends Kubernetes with a declarative data plane, providing flexible, persistent storage for stateful applications.

Design goals for Mayastor include:

Highly available, durable persistence of data.
To be readily deployable and easily managed by autonomous SRE or development teams.
To be a low-overhead abstraction.
OpenEBS Mayastor incorporates Intel's Storage Performance Development Kit. It has been designed from the ground up to leverage the protocol and compute efficiency of NVMe-oF semantics, and the performance capabilities of the latest generation of solid-state storage devices, in order to deliver a storage abstraction with performance overhead measured to be within the range of single-digit percentages.

"

## Compare Mayastor and Ceph

Ceph is a stand-alone storage system where you can add nodes just like you can with K8s whe Mayastor is managed by K8s and not a separate entity.

## What is an Organizational Unit

"What is an organizational unit in Active Directory? An OU is a container within a Microsoft Windows Active Directory (AD) domain that can hold users, groups and computers. It is the smallest unit to which an administrator can assign Group Policy settings or account permissions."

## What is RBAC

**[Solaris RBAC](https://docs.oracle.com/cd/E19253-01/816-4557/rbacref-28/index.html)**
By default Linux gives you all or nothing power when running sudo, some Unix systems such as Solaris use RBAC to provide much better authorization method similiar Windows OU and GPO.

Kubernetes is an RBAC compliant application.
"RBAC-compliant applications can check a user's authorizations prior to granting access to the application or specific operations within the application. This check replaces the check in conventional UNIX applications for UID=0."

## Authorization Summary

**[K8s RBAC](https://www.strongdm.com/blog/kubernetes-rbac-role-based-access-control)**
Some operating systems like Windows and Solaris have fine grained security authorization features such as RBAC or OU/GPO but Linux does not. Fortunately, Kubernetes has RBAC built in and the applications you deploy to it can as well.  So in comparison to Windows that uses OU/GPO to control every resource RBAC roles and access priviledges are defined by each RBAC compliant applications.
For example here are the standard K8s RBAC roles:
"
Cluster-admin: This “superuser” can perform any action on any resource in a cluster. You can use this in a ClusterRoleBinding to grant full control over every resource in the cluster (and in all namespaces) or in a RoleBinding to grant full control over every resource in the respective namespace.
Admin: This role permits unlimited read/write access to resources within a namespace. This role can create roles and role bindings within a particular namespace. It does not permit write access to the namespace itself.
Edit: This role grants read/write access within a given Kubernetes namespace. It cannot view or modify roles or role bindings.
View: This role allows read-only access within a given namespace. It does not allow viewing or modifying of roles or role bindings.

Simplified RBAC strategy:
Create role bindings based on user types instead of individual users and create ServiceAccounts for each application.

Creating roles for users per user type
To begin, decide on some generic user types and the level of access each requires. These decisions will depend on your organizational needs and the authentication method. Once you’ve evaluated, you can configure role bindings for each type of user.

As an example, let’s say your organization needs roles for three different user types: infrastructure monitoring team members, established devs, and cluster admins.

For the infrastructure monitoring teams, you could configure a Role that gives read-only access (using the verbs “get,” “list” and “watch”) to a given namespace. And admin could also map new devs, who are still getting the hang of things, or anyone else who needs read-only access, to this Role:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: read-only
  namespace: default
rules:
- apiGroups:
  - ""
  resources: ["*"]
  verbs:
  - get
  - list
  - watch

```

To apply the Role to a user, you must define a RoleBinding. This will give the user access to all resources within the namespace with the permissions defined in the Role configuration above:

```yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: RoleBinding
metadata:
  name: read-only-binding
roleRef:
  kind: Role
  name: read-only #The role name you defined in the Role configuration
  apiGroup: rbac.authorization.k8s.io
subjects:
– kind: User
  name: example #The name of the user to give the role to
  apiGroup: rbac.authorization.k8s.io

```

"  

<https://172.20.88.65:30587/>
eyJhbGciOiJSUzI1NiIsImtpZCI6Il9uTUVVWWlqUkZJOWlnZmlWaDB0TW51UFRWNXZNem1oaDZ0dVVMREx0cjgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJiMWM4MGVjNy04ZmFhLTRjNzUtYmMxNS0xODhiMGI0ODJkYmUiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.eSB-41atSvuQOb27CP18uAdJOAlOBu7a4NUQQT85bsRnSWEeW0aE29yEAwyBN5Zkwtjw8gPIaykiaNz4E1cm_F3B8cJRGSjxK3y2lJMiGWXN4Crh516PCQbouqTD6ZDsT2YSz3n4R_tsyhSOgtQGCP7_Dxp7sGhqhApz1ji9YT6pb8F8BGs7ZcKr1NHT-N1nJRhSsUtGIQU2I1Gcgn8lB4lf3XpLDO4hNoRp-riKYn9_SzA_EeJ4alcB4psBjMsmQptcuzdWheD426x8A3eRJSuJ0IBY5Qvc9q_m4PY0W81FXmZJTgJ-smOrsifN0cnE1QCmKI4c6IFyYKzv6I9Zrg
