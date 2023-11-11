# Install MinIO with Kubectl Krew plugin

## references

<https://docs.onepanel.ai/docs/deployment/configuration/miniotenants/>
<https://krew.sigs.k8s.io/docs/user-guide/setup/install/>

## remove

kubectl minio tenant delete tenant1

## Install Krew

**[Install kubectl krew plugin](../../kubectl/krew-plugin.md)**

<https://docs.onepanel.ai/docs/deployment/configuration/miniotenants/>

```bash
kubectl minio init --output > minio_init.yaml
kubectl apply -f minio_init.yaml
namespace/minio-operator created

kubectl get all -n minio-operator

# create tenant
kubectl create ns example
namespace/example created

```

- In minio-tenant.yaml, change the namespace to be your namespace. Also, make sure to set the storage value to however much space you want to give the tenant. Keep in mind it creates 4 volumes, so it's storage * 4.
- Apply the configuration:

```bash
pushd ~/src/reports/k8s/krew
kubectl apply -f minio-tenant.yaml
secret/minio-autocert-no-encryption-minio-creds-secret created
secret/minio-autocert-no-encryption-console-secret created
tenant.minio.min.io/minio-autocert-no-encryption created

# Make sure everything is running
kubectl get pods -A
```

**[MinIO Operator Components](https://min.io/docs/minio/kubernetes/upstream/operations/installation.html#minio-operator-installation)**
The MinIO Operator exists in its own namespace.

Within the Operator’s namespace, the MinIO Operator utilizes two pods: - The Operator pod for the base Operator functions to deploy, manage, modify, and maintain tenants. - Console pod for the Operator’s Graphical User Interface, the Operator Console.

When you use the Operator to create a tenant, the tenant must have its own namespace. Within that namespace, the Operator generates the pods required by the tenant configuration.

Each pod runs three containers:

MinIO Container that runs all of the standard MinIO functions, equivalent to basic MinIO installation on baremetal. This container stores and retrieves objects in the provided mount points (persistent volumes).

InitContainer that only exists during the launch of the pod to manage configuration secrets during startup. Once startup completes, this container terminates.

SideCar container that monitors configuration secrets for the tenant and updates them as they change. This container also monitors for root credentials and creates an error if it does not find root credentials.

```bash
mc alias set myminio <https://reports51:30551/> ACCESS_KEY SECRET KEY
mc alias set myminio https://reports51:30551/ UP63J4CEXJW8NOOMTYD4 PYBavmtRjBNjFrq6lGUVBSUenO83jC0aIvPrEPek
mc: <ERROR> Unable to initialize new alias from the provided credentials. Get "https://reports51:30551": tls: failed to verify certificate: x509: certificate is valid for tenant1-ss-0-0.tenant1-hl.example.svc.cluster.local, minio.example.svc.cluster.local, minio.example, minio.example.svc, *., *.example.svc.cluster.local, not reports51.

mc alias set reports51 https://reports51:30551/ UP63J4CEXJW8NOOMTYD4 PYBavmtRjBNjFrq6lGUVBSUenO83jC0aIvPrEPek

## try to get this one to work with nginx
mc alias set reports51 https://reports51.busche-cnc.com:30551/ UP63J4CEXJW8NOOMTYD4 PYBavmtRjBNjFrq6lGUVBSUenO83jC0aIvPrEPek
mc: <ERROR> Unable to initialize new alias from the provided credentials. Get "https://reports51.busche-cnc.com:30551": tls: failed to verify certificate: x509: certificate is valid for tenant1-ss-0-0.tenant1-hl.example.svc.cluster.local, minio.example.svc.cluster.local, minio.example, minio.example.svc, *., *.example.svc.cluster.local, not reports51.busche-cnc.com.


mc alias set minio http://192.168.2.105:9000 testaccess supersecret

mc alias set reports-alb https://reports-alb.busche-cnc.com:30551/ giFVHq2xcbsvC72IDxw7 TZPOPsf74FGHJuUzWtKDWU4x2LYKkPGtred3uCZv

mc alias set minio http://reports-alb:9000 testaccess supersecret
mc alias get minio

https://stackoverflow.com/questions/66161424/minio-does-not-seem-to-recognize-tls-https-certificates,...

```

  Username: UP63J4CEXJW8NOOMTYD4
  Password: PYBavmtRjBNjFrq6lGUVBSUenO83jC0aIvPrEPek

openssl s_client -connect <https://reports51:30551> -showcerts
openssl s_client -showcerts -connect reports51:30551 </dev/null

reports-alb
giFVHq2xcbsvC72IDxw7
TZPOPsf74FGHJuUzWtKDWU4x2LYKkPGtred3uCZv

mc ls minio minio/test-bucket/
mc anonymous get minio/test-bucket
Access permission for `minio/test-bucket` is `private`
mc anonymous set public minio/test-bucket
mc anonymous get minio/test-bucket
Access permission for `minio/test-bucket` is `public`
mc anonymous links --recursive minio/test-bucket
<http://reports-alb:9000/test-bucket/TB-202209_to_202309_on_10-24_DM_GP.xlsx>
<http://reports-alb:9000/test-bucket/test.xlsx>
<https://reports51:30551/test-bucket/TB-202209_to_202309_on_10-18_DM_GP.xlsx?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=4P4FNV6AA3HUC86M95XI%2F20231031%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231031T213626Z&X-Amz-Expires=86398&X-Amz-Security-Token=eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NLZXkiOiI0UDRGTlY2QUEzSFVDODZNOTVYSSIsImV4cCI6MTY5ODgyNTc3NCwicGFyZW50IjoiVVA2M0o0Q0VYSlc4Tk9PTVRZRDQifQ.BpyQkXENSsQV7DhFBE9yCx9tMzZZg97r_ncynulNzpCfrVeZxW_vpls8zkaotDpdbySu8y0dQ1Cd2-MpwL2mEg&X-Amz-SignedHeaders=host&versionId=null&X-Amz-Signature=904e91add370eb14cd1202df9e34f6ad645004ae7bef45966cfd4978d3197ccf>

mc anonymous list

## Tenant Creation

**[MinIO Tenant Creation](https://github.com/minio/operator/tree/master/kubectl-minio)**
**[Kubectl MinIO plugin Tenant Creation](https://min.io/docs/minio/kubernetes/upstream/reference/kubectl-minio-plugin.html)**

Command: kubectl minio tenant create TENANT_NAME --servers SERVERS --volumes TOTAL_VOLUMES --capacity TOTAL_RAW_CAPACITY [options]

Creates a MinIO Tenant based on the passed values. Please note that plugin adds anti-affinity rules to the MinIO Tenant pods to ensure multiple pods don't end up on the same physical node. To disable this, use the -enable-host-sharing flag during tenant creation.

example: kubectl minio tenant create tenant1 --servers 4 --volumes 16 --capacity 16Ti

kubectl minio tenant create tenant1 --servers 1 --volumes 4 --capacity 10Gi --namespace example

Options:

--namespace=minio
--kes-config=kes-secret
--output

<https://github.com/minio/operator/issues/1388>
W1030 23:09:05.760480 2213506 warnings.go:70] unknown field "spec.pools[0].volumeClaimTemplate.metadata.creationTimestamp"

Tenant 'tenant1' created in 'example' Namespace

  Username: UP63J4CEXJW8NOOMTYD4
  Password: PYBavmtRjBNjFrq6lGUVBSUenO83jC0aIvPrEPek
  Note: Copy the credentials to a secure location. MinIO will not display these again.

APPLICATION SERVICE NAME    NAMESPACE SERVICE TYPE SERVICE PORT
MinIO       minio           example   ClusterIP    443
Console     tenant1-console example   ClusterIP    9443

kubectl minio tenant info tenant1
kubectl minio tenant info tenant1
Tenant 'tenant1', Namespace 'example', Total capacity 10 GiB

Current status: Initialized
MinIO version: minio/minio:RELEASE.2023-10-07T15-07-38Z
MinIO service: minio/ClusterIP (port 443)
Console service: tenant1-console/ClusterIP (port 9443)

POOL SERVERS VOLUMES(SERVER) CAPACITY(VOLUME)
0    1       4               2.5 GiB

MinIO Root User Credentials:
MINIO_ROOT_USER="2FM1SE1H11R3F7Y0443V"
MINIO_ROOT_PASSWORD="4FLx8NN1bWNF9PsEQvziSNNCPYwF7MpiKwctLQlw"

microk8s kubectl get pods -A
example          tenant1-ss-0-0                                 2/2     Running   0            2m51s

kubectl get pvc --all-namespaces

NAMESPACE   NAME               STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
example     0-tenant1-ss-0-0   Bound    pvc-2865d033-28d3-4ae2-9103-fb817ca772fc   2560Mi     RWO            microk8s-hostpath   19h
example     1-tenant1-ss-0-0   Bound    pvc-31ecb747-da76-4952-99f6-a09fda86022c   2560Mi     RWO            microk8s-hostpath   19h
example     2-tenant1-ss-0-0   Bound    pvc-100cc4f0-7e76-466f-9b56-525d9a1292dd   2560Mi     RWO            microk8s-hostpath   19h
example     3-tenant1-ss-0-0   Bound    pvc-04ac4ebe-6eae-487d-9f28-fc2506eb6cd1   2560Mi     RWO            microk8s-hostpath   19h

<https://github.com/minio/operator/tree/master/kubectl-minio>

mc alias set minio <http://10.1.184.157:9000> minio minio123
mc alias set minio <http://10.1.184.157:9000> minio minio123

mc: Configuration written to `/home/brent/.mc/config.json`. Please update your access credentials.
mc: Successfully created `/home/brent/.mc/share`.
mc: Initialized share uploads `/home/brent/.mc/share/uploads.json` file.
mc: Initialized share downloads `/home/brent/.mc/share/downloads.json` file.
mc: <ERROR> Unable to initialize new alias from the provided credentials. Client sent an HTTP request to an HTTPS server.
 ✘ brent@reports53  ~ 

## Create a New Tenant from onepanal tutorial from 2021 #

To create a tenant we must first create a namespace.

microk8s kubectl create ns example

Then create a file called minio-tenant.yaml and fill it with the content below.
