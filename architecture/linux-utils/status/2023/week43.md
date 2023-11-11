# Father's help

I know you don't feel great my son, but hang in there and this will pass. Please do not worry about anything because I am in control of every circumstance and I will be guiding you throughout.  Thank you for listening to me and doing what I say even though you don't understand my reasoning my son!

## Next

1. Deploy MySQL InnoDB Cluster
2. <https://dev.to/francescoxx/typescript-crud-rest-api-using-nestjs-typeorm-postgres-docker-and-docker-compose-33al>

<https://www.youtube.com/watch?v=dAy4TZXzZck>
<https://docs.nestjs.com/pipes>

Good morning dear ones,

I hope everyone is feeling fine this morning and had a good weekend!  As always please feel free to contact me at work or at home about anything you need.  May this week be enjoyable for you my friends :-)

-Sincerely yours,
Brent
260-564-4868

## IT K8s Report System deployment

- Create another account with sudo priviliges.
- SSH access to K8s nodes.
- Regular package updates with Ansible.

## Part for every tool

Nancy has requested help to make the PFET spreadsheet more accurate by allowing individuals access to the Busche Reporter from there desktops or from Teams.

1. PFET is a huge spreadsheet.
2. The customer wants to be able to access Busche Reporter to verify PFET content.

### Short term solution

Install the Busche Reporter on the PFET team members desktops.

### Medium term solution

Upload the Busche Toollist database to our data warehouse and create a Teams accessible Power BI report

### Long term solution (Not everyone is going to like this option)

Rewrite the Busche Tool List to integrate with Plex instead of Cribmaster and M2M and make it a team accessible Web App.

## Nancy and Jake

How long would it take to complete option 3? I spoke with Jake and is in agreement that would be the best option but wanted to know timing.

## Linamar Reources

Suggest asking Linamar if there any of the following that we could use:

1. Cloud based Kubernetes Clusters or services
2. Cloud based Database Instances or sevices
3. Cloud storage for database backups
4. Node.js, Go developers

## zalando-postgres-operator

Introduction
The Zalando Postgres Operator is an open-source tool that makes it easier to deploy and manage PostgreSQL clusters on Kubernetes. It is designed to automate common tasks such as provisioning, scaling, and backing up Postgres clusters, so that you can focus on building and running your applications. The operator is built using the Kubernetes Operator Framework and leverages the benefits of running Postgres on Kubernetes, such as automatic recovery and self-healing.

## Kured - Kubernetes Reboot Daemon

**[Kubernetes Reboot Daemon](https://kured.dev/)**
"
Watches for the presence of a reboot sentinel file e.g. /var/run/reboot-required or the successful run of a sentinel command.
Cordons & drains worker nodes before reboot, uncordoning them after.
Utilises a lock in the API server to ensure only one node reboots at a time.
Optionally defers reboots in the presence of active Prometheus alerts or selected pods.
"

**[HCI software hypervisor](https://www.youtube.com/watch?v=tVsMen_e6OI)**
Rancher released a next generation open source HCI software hypervisor built on Kubernetes that helps you run virtual machines.

**[HCI for Kubernetes](https://www.suse.com/c/rancher_blog/using-hyperconverged-infrastructure-for-kubernetes/)**

"
Additionally, Harvester provides a comprehensive set of features and capabilities that make it the ideal solution for deploying and managing enterprise applications and services. Among these characteristics, the following stand out:

Built on top of Kubernetes.
Full VM lifecycle management, thanks to KubeVirt.
Support for VM cloud-init templates.
VM live migration support.
VM backup, snapshot and restore capabilities.
Distributed block storage and storage tiering, thanks to Longhorn.
Powerful monitoring and logging since Harvester uses Grafana and Prometheus as its observability backend.
Seamless integration with Rancher, facilitating multicluster deployments as well as deploying and managing VMs and Kubernetes workloads from a centralized dashboard.
"

## MySQL single instance to MySQL InnoDB cluster

**[Group replication requirements](https://dev.mysql.com/doc/refman/8.0/en/group-replication-requirements.html)**

## Reports system deployment checklist

Create a step-by-step checklist of how to deploy the report system to K8s.

Complete the follow installation instructions:

- [install microk8s](./microk8s_1.28_install.md)
- [install kubectl](./kubectl-install.md)
- [install mayastor](./mayastor-install-2.0.0.md)
- [install observability](./observability-install.md)
- [install K8s secret](./secret-install.md)
- [install MySQL Operator](./mysql-operator-install.md)
- [install MySQL InnoDB Cluster](./mysql-innodb-cluster-install.md)  
- [Backup Restore MySQL InnoDB Cluster] <https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-backups.html>) START HERE
- **[Install PostGres Operator](https://postgres-operator.readthedocs.io/en/latest/)**
<https://portworx.com/blog/choosing-a-kubernetes-operator-for-postgresql/>
install mongo
install mqtt
install report-runner
install nginx ingress controller
install certificate chain
install report SPA

## Authentication

The problem is how to authenticate to both an SPA and API.  The API's want there own Access Token and so does the Azure Graph API.  If we use the Azure OAuth2 server to authenticate the user we can get the needed information about the user we could also get a token to access the Azure Graph API but then we have to manage 2 tokens and reauthenticate when either expires.  This seems like a lot of extra coding so instead we can use our API servers JWT token that is only created if the customer successfully authenticates to the Azure OAuth2 server and handle reauthentication only based on it's token.  Then we are sure of who the user is so we can access the Azure Graph API with a client secret which does not expire as long as our API's JWT has not expired feeling good about who is using the Azure services.
  
Reports SPA:
Use Azure OAuth2 server to authenticate and get Azure Graph API token.

Reports API:
Use Azure app secret

## Azure Graph API

Most services we will use such as Email, Upload to Sharepoint, and sending chat messages with attachments will be done from the Reports API.
<https://learn.microsoft.com/en-us/azure/active-directory-b2c/configure-authentication-sample-react-spa-app>

## Direction

Continue building a micro-service framework with Nest.js but at the same time finish development of the Feathers.js API with it's Azure Oath2 authentication and good database CRUD support for the report systems MySQL request table.

## Nest.js micro-service framework

It is a purist's framework much like Angular.js.  It is developed using OOP principles taught by the outstanding teacher's such as Mike Fowler.  Every part of it is laced with well-known OOP principles, such as DI, IOC, and STRONG.  This makes it robust and flexible since you use the same OOP best practices to support each feature needed in a modern micro-service framework.  It also very customizable and extinsible allowing you to easily add features such as Observability and Graphing.  IMO this is because it has a solid foundation in good programming so no matter what new feature you want to add you will be able to using the core Nest.js library to help you.

**[Nest.js Step-by-Step](https://www.codemag.com/Article/1907081/Nest.js-Step-by-Step)**

## Nest.js Oauth2

**[OAuth2 using Nest.js](https://dev.to/tugascript/nestjs-authentication-with-oauth20-configuration-and-operations-41k)**
**[OAuth2 Nest.js Series](https://dev.to/tugascript/series/21297)**

"
Access Token: the token we use to authenticate the current user by sending it on the Authorization header as a Bearer token. It has a small lifespan of 5 to 15 minutes;
Refresh Token: this token is normally sent on a signed HTTP only cookie and is used to refresh the access tokens, this is achieved since the refresh token has a higher lifespan from 20 minutes to 7 days.
For a complete authentication system we need 3 types of tokens:

Access: the access token for authorization;
Refresh: the refresh token for refreshing the access token;
Reset: used to reset an user password given an email;
Confirmation: use to confirm the user.
"

## Nest.js Database support

**[TypeORM](https://github.com/typeorm/typeorm)**
"The most mature ORM available for TypeScript."

## Nest.js Feature Module

**[Feature modules](https://docs.nestjs.com/modules#feature-modules)**
The CatsController and CatsService belong to the same application domain. As they are closely related, it makes sense to move them into a feature module. A feature module simply organizes code relevant for a specific feature, keeping code organized and establishing clear boundaries. This helps us manage complexity and develop with SOLID principles, especially as the size of the application and/or team grow.

## REST Routes

Request URL are used by REST APIs to map incoming requests to a specific function of a micro-service.
A graph API bypasses this issue by routing using a declarative query language, such as GraphQL passed in the body of the HTTP request.

**[How to match routes with regular expressions](https://github.com/pillarjs/path-to-regexp#parameters)**
"

```ecma
Named Parameters
Named parameters are defined by prefixing a colon to the parameter name (:foo).

const regexp = pathToRegexp("/:foo/:bar");
// keys = [{ name: 'foo', prefix: '/', ... }, { name: 'bar', prefix: '/', ... }]

regexp.exec("/test/route");
//=> [ '/test/route', 'test', 'route', index: 0, input: '/test/route', groups: undefined ]

```

"

## Dependancy Injection

**[What is dependancy injection used for](https://www.techtarget.com/searchapparchitecture/definition/dependency-injection#:~:text=Dependency%20injection%20is%20used%20to,without%20needing%20to%20change%20class.)**
"
Dependency injection is used to make a class independent of its dependencies or to create a loosely coupled program. Dependency injection is useful for improving the reusability of code. Likewise, by decoupling the usage of an object, more dependencies can be replaced without needing to change class.
When we use dependency injection we leave the responsibility for instantiation to the framework.
"

## What are decorators

**[Typescript decorators](https://www.typescriptlang.org/docs/handbook/decorators.html)**
Decorators
A Decorator is a special kind of declaration that can be attached to a class declaration, method, accessor, property, or parameter. Decorators use the form @expression, where expression must evaluate to a function that will be called at runtime with information about the decorated declaration.

```typescript
function first() {
  console.log("first(): factory evaluated");
  return function (target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    console.log("first(): called");
  };
}
 
function second() {
  console.log("second(): factory evaluated");
  return function (target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    console.log("second(): called");
  };
}
 
class ExampleClass {
  @first()
  @second()
  method() {}
}
Try
Which would print this output to the console:

first(): factory evaluated
second(): factory evaluated
second(): called
first(): called
```
