Thank you Father for directing me and convincing me of your good plan for us all!

Good morning dear ones,
I hope this email finds you all well and in good spirits, and may  each of you find a portion of enjoyment in his work and strength to endure any hardships that may come your way!
Happy Easter,
Brent 
260-564-4868

Tool boss / Plex sync:
As you may know in the past we owned our own tool bosses and were able to write scripts to syncronize them with Cribmaster and M2M.  Of course this is not the case now since MSC owns them. But we can programmatically inform them when there databases are not upto-date.  Nancy, Jamie, and Jake are concerned that we don't know how much each job's tooling cost is.  MSC should be able to make reports to give us this information since when tooling is pulled the tool setter selects a job for it as a standard part of the UI process flow.  This should help catagorize tool costing, but IMO much more could be done to improve this process. Namely creating job restrictions that only allow tool setters to pull certain tools for each job and making sure the correct jobs are associated with the tool bosses where the jobs are currently running.  The output of our efforts would be CSV / Excel files that show the job restriction issues found at each plant emailed to MSC.

CFSSL PKI/TLS CA for Certificate Management
Created self-signed certificates before but this is much better method than I have ever used before.
- Tested CFSSL from local server and from an HTTP API server to generate a CA root certificate that can be used to generate other TLS certificates. The HTTP API server could be deployed to one of the k8s and to generate a certificate we would: 
1. Add the root certificate to the Windows trusted store.
2. create a CSR such as:
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Albion",
      "O": "system:masters",
      "OU": "MIS Reports",
      "ST": "Indiana"
    }
  ]
}
3. run the following command replacing localhost with our Azure AKS ingress path associated with our CFSSL service:
cfssl gencert -remote="localhost:8888" -config ca-config.json -profile kubernetes admin-csr.json | cfssljson -bare admin2

From the website:
https://blog.cloudflare.com/introducing-cfssl/
"CFSSL Public Key Infrastructure is not only a tool for bundling a certificate, but it can also be used as a CA. This is possible because it covers the basic features of certificate creation including creating a private key, building a certificate signature request, and signing certificates.
...
the certificate contains the server name, the trusted certificate authority (CA) that vouches for the authenticity of the certificate, and the server’s public encryption key."

Useful CFSSL links:
https://blog.cloudflare.com/introducing-cfssl/
https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
https://computingforgeeks.com/build-pki-ca-for-certificates-management-with-cloudflare-cfssl/
https://www.youtube.com/watch?v=jsD_lAE8Odg


Mobex CA:
A CA used to generate in-house certificates
1. Add the Mobex CA root certificate to the Windows trusted store.
2. create a CSR such as:
{
  "CN": "reports5",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Detroit",
      "O": "system:masters",
      "OU": "Nutanix Reports K8s cluster",
      "ST": "Michigan"
    }
  ]
}
3. run the following command replacing localhost with our Azure AKS ingress path associated with our CFSSL service:
cfssl gencert -remote="https://reports5/mobexca:8888" -config ca-config.json -profile kubernetes reports5-csr.json | cfssljson -bare reports5


Kubernetes Certificate Manager:
CFSSL is good enough for our internal web sites but not Microsoft Teams. So I installed cert-manager in Azure AKS to enable the creation and management of TLS certificates requiring a CA recognized by Microsoft Teams.

https://github.com/cert-manager/cert-manager
``` From the web site:
cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.

It supports issuing certificates from a variety of sources, including Let's Encrypt (ACME), HashiCorp Vault, and Venafi TPP / TLS Protect Cloud, as well as local in-cluster issuance.

cert-manager also ensures certificates remain valid and up to date, attempting to renew certificates at an appropriate time before expiry to reduce the risk of outages and remove toil.
```
Automated Certificate Management Environment (ACME):
https://cert-manager.io/docs/configuration/acme/
To prove we own reports-ingress.centralus.cloudapp.azure.com our cert-manager configures our ingress to route traffic to a small web server that presents a computed key to the ACME CA server. 

Here is the k8s issuer definition.

apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: bgroves@mobexglobal.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: example-issuer-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: nginx

Let's Encrypt:
Production/Staging Rate limits but free.

CloudFlare's PKI/TLS tools:
It used to be a time consuming process to create a self-signed certificate and I didn't even know about using PKI to get production certificates from a CA.  Now there is a Canonical command line tool for using the CloudFlare CFSSL package that does about anything you would want to do with TLS certificates.
Why is it built using the golang programming language? Because it can insert TLS objects into Kubernetes which is built using golang.
From the website: https://github.com/cloudflare/cfssl
CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates. It requires Go 1.16+ to build.


Azure CLI:
https://www.couchbase.com/blog/json-database/
What is NoSQL? Not Only SQL.
Why learn about JSON? JSON data is ubiquitous: information exchange, object representation, API responses, and microservices all use JSON. 
What query language does Azure CLI and AWS CLI use? The industry standard JMESPath JSON query language.  This is the kind of language we would use instead of SQL for a JSON/NoSQL database where we are dealing with objects as well as structures which can mimic SQL relational tables.
Why learn Azure CLI? If you learn one JSON query language it is easy to pick up the others.
Why does Azure use a JSON query language?  Because Azure manages cloud services with a NoSQL/JSON database.
Why is it good to learn JMESPath?  It is similar to other JSON query languages that are used in NOSQL databases such as Mongo, Couchbase, or Azure Cosmos.
What is the advantage of a NOSQL or JSON database over a traditional SQL database that uses relational tables? 
- JSON databases can implement relational tables using JSON.
- JSON database can contain objects as well as structures that mimic relational tables.
- Objects are great for saving complete result sets such as reports.
- relational tables are great for storing information in an isolated structure that is easily updated and manipulated.
The growing list of JSON query languages:
jq - linux command line program.
SQL++ 
MongoDB query language
JMESPath
JSONiq (based on XQuery)
UNQL (like SQL)
JaQL (functional)
JsonPath (XPath-like)
Json Query (sort of XPath-like)
GraphQL (template-based, typed)

What is SQL++? 
SQL++ https://www.couchbase.com/sqlplusplus/


# JMESPath links
https://jmespath.org/
https://learn.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash#dictionary-and-list-cli-results
https://jmespath.org/tutorial.html

example queries:
# filter ==
az vm list --query "[?storageProfile.osDisk.osType=='Linux'].{Name:name,  admin:osProfile.adminUsername}" --output table
az ad group list --output table --query "[?securityEnabled].{name:displayName, description:description, objectId:objectId}"
# filter >=
az vm list --query "[?storageProfile.osDisk.diskSizeGb >=\`5\`].{Name:name,  admin:osProfile.adminUsername, DiskSize:storageProfile.osDisk.diskSizeGb }" --output table
# functions to filter
az vm list --query "[?contains(storageProfile.osDisk.managedDisk.storageAccountType,'SSD')].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType}"
# pipes and functions to filter
az vm list --query "[].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType} | [? contains(Storage,'SSD')]"
# functions to manipulate the output
az vm list --query "sort_by([].{Name:name, Size:storageProfile.osDisk.diskSizeGb}, &Size)" --output table
# format output is JSON by default
az network public-ip list
# tsv to assign output to a variable 
export STATIC_IP=23.101.116.170
export PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].[id]" --output tsv)
echo $PUBLICIPID
# table format outputs ASCII and is aligned.
az vm list --query "[].{Name:name, OS:storageProfile.osDisk.osType, Admin:osProfile.adminUsername}" --output table




