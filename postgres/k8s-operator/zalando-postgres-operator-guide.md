# zalando-postgres-operator

<https://medium.com/@zkapishov/zalando-postgres-operator-in-production-the-way-of-helm-ccfd639ccb2d>

Table of content:

Introduction to Zalando Postgres Operator: Briefly explain what the Zalando Postgres Operator is and why it’s useful for managing PostgreSQL clusters on Kubernetes.
Deployment Process: Describe the process for deploying the Zalando Postgres Operator to a Kubernetes cluster, including any dependencies that need to be met.
Monitoring and Backup: Discuss the built-in options for monitoring and backup up PostgreSQL clusters managed by the Zalando Postgres Operator.
Postgresql.yml Manifest: Provide an overview of the additional options available in the postgresql.yml manifest and how they can be used to customize the behavior of the operator.
Conclusion: Summarize the key points covered in the article and provide some additional resources for readers who want to learn more about the Zalando Postgres Operator.

Introduction
The Zalando Postgres Operator is an open-source tool that makes it easier to deploy and manage PostgreSQL clusters on Kubernetes. It is designed to automate common tasks such as provisioning, scaling, and backing up Postgres clusters, so that you can focus on building and running your applications. The operator is built using the Kubernetes Operator Framework and leverages the benefits of running Postgres on Kubernetes, such as automatic recovery and self-healing.

Deploy
There are several options in order to deploy the Kubernetes operator in your cluster:

In this post, Zalando Postgres Operator will be deployed via Helm chart. Helm is a package manager for Kubernetes that allows for easy installation and management of Kubernetes resources. Some benefits of using Helm include:

Simplified deployment of complex applications
Versioning and rollbacks
Reusability
Customizable
As a best practice, I highly recommend using automation tools for the deployment. There are two options:

**![Automation Tools](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*87tf7XCxwp_aHkHdzqevSw.png)**

Depending on my stack, Gitlab CI will be used. GitLab CI/CD (Continuous Integration and Continuous Deployment) is a built-in feature of GitLab that allows developers to automate the process of building, testing, and deploying code. Some benefits of using GitLab CI/CD include:

Simplified pipeline management
Speed and efficiency
Improved collaboration
Easy to customize
Easy to integrate with other tools
However, another workaround using Gitops tools, such as Argo CD and Flux is a better option. The significant benefit of the Argo CD/Flux approach is that they can synchronize with a repository, and constantly observe the state of deployment, and auto recovery in case of deviation from the target state. I recommend using CD tools for infrastructure applications.

There are three components needed for the usage:

**![CI/CD](https://miro.medium.com/v2/resize:fit:720/format:webp/1*iOOM8elsLVTdRO-40tU6Lg.png)**

```yaml
Zalando operator:

deploy-operator:
 stage: deploy
 environment:
   name: production
 script:
   ##connect to the cluster via gitlab agent
   - kubectl config get-contexts
   - kubectl config use-context devops/gitlab-agent:k8s
   ##install Helm chart
   - helm upgrade postgres-operator ./charts/postgres-operator
     --values ./charts/postgres-operator/values.yaml
     --install
     --namespace postgresql-system
     --create-namespace
 when: manual

```

## Operator UI

With Operator UI, we can get the possibility of creating Postgres clusters via GUI. In general, it is just an easy-to-use constructor of a Custom Resource Definition postgresql.yaml manifest. However, it does not include all the capabilities of the Zalando Operator. Instead, we write and customize the operator’s CRD manually, and deploy them in GitLab CI jobs via kubectl.

```yaml
deploy-operator-ui:
 stage: deploy
 environment:
   name: production
 script:
   ##connect to the cluster via gitlab agent
   - kubectl config get-contexts
   - kubectl config use-context devops/gitlab-agent:k8s
   ##install Helm chart
   - helm upgrade postgres-operator-ui ./charts/postgres-operator-ui
     --values ./charts/postgres-operator-ui/values.yaml
     --install
     --namespace postgresql-system
     --create-namespace
 when: manual


## The default cluster YAML definition in Operator GUI is:

kind: "postgresql"
apiVersion: "acid.zalan.do/v1"
 
metadata:
  name: "acid-example-cluster"
  namespace: "postgresql-prod"
  labels:
    team: acid
 
spec:
  teamId: "acid"
  postgresql:
    version: "14"
  numberOfInstances: 3
  volume:
    size: "10Gi"
  users:
    testuser: []
  databases:
    testuser: testuser
  allowedSourceRanges:
    # IP ranges to access your cluster go here
  
  resources:
    requests:
      cpu: 100m
      memory: 100Mi
    limits:
      cpu: 500m
      memory: 500Mi
```

## Pgadmin4

Pgadmin4 is a platform for administrating PostgreSQL databases. It is just an option, not a compulsory component of the stack. Other administration platforms can be used.

```yaml
deploy-pgadmin4:
 stage: deploy
 environment:
   name: production
 script:
   ##connect to the cluster via gitlab agent
   - kubectl config get-contexts
   - kubectl config use-context devops/gitlab-agent:k8s
   ##install Helm chart
   - helm upgrade pgadmin4 ./pgadmin4
     --values ./pgadmin4/values.yaml
     --install
     --create-namespace
     --set-string VolumePermissions.enabled="true"
     --namespace postgresql-prod
 when: manual
```

## Monitoring

In order to monitor and grab the metrics from Postgres clusters, we implement a sidecar container with Postgres exporter, which collects the metrics and sends them to Prometheus.

Use the sidecar support in the values file:

```yaml
sidecars:
   - name: "exporter"
     image: "quay.io/prometheuscommunity/postgres-exporter:latest"
     ports:
       - name: exporter
         containerPort: 9187
         protocol: TCP
     resources:
       limits:
         cpu: 500m
         memory: 256M
       requests:
         cpu: 100m
         memory: 200M
     env:
     - name: "DATA_SOURCE_URI"
       value: 127.0.0.1:5432
     - name: "DATA_SOURCE_USER"
       value: "$(POSTGRES_USER)"
     - name: "DATA_SOURCE_PASS"
       value: "$(POSTGRES_PASSWORD)"
     - name: "PG_EXPORTER_AUTO_DISCOVER_DATABASES"
       value: "true"
```

Add pod monitors to your Prometheus:

We use Prometheus Operator, so for this stack, overwritten values will be:

```yaml
additionalPodMonitors:
 - name: "postgresql"
   selector:
     matchLabels:
       application: spilo
   podTargetLabels:
   - spilo-role
   - cluster-name
   - team
   namespaceSelector:
     any: false
     matchNames:
     - "postgresql-prod"
     - "postgresql-dev"
   podMetricsEndpoints:
   - port: exporter
     interval: 15s
     scrapeTimeout: 10s
```

## Alerts

It is also recommended to configure alerts on metrics with Alert Manager. The templates for PostgreSQL alerts can be found here.

## Backup

There are two kinds of backups:

WAL archiving and physical basebackups
Logical backup
WAL archiving and physical basebackups is a mandatory option. WAL archiving allows you to recover the database to a specific point in time, while physical basebackups allow you to restore the entire cluster to a previous state. These two methods can be combined to provide a comprehensive disaster recovery solution.

Logical backups can be considered as a simple dump of a database. It generates a file containing SQL statements that can be used to recreate the database. These backups can be used to restore the data to a different version or type of database and selectively restore specific tables or rows.

We use both of them, storing all the backup files in Google Cloud Storage. In addition, we implemented local backups. Our custom cronjob dumps the needed database and sends the file to a backup server.

Setup GCP:
Create K8s secret resource with Service Account’s credentials:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: gsp-ser-acc-json-file
  namespace: default
type: Opaque
stringData:
  key.json: |-
    <GCP .json credentials>
```

## Overwrite the chart values

```yaml
 configAwsOrGcp:
 # Additional Secret (aws or gcp credentials) to mount in the pod
 additional_secret_mount: "gsp-ser-acc-json-file"
 
 # Path to mount the above Secret in the filesystem of the container(s)
 additional_secret_mount_path: "/var/secrets/google"
 
 ## AWS region used to store ESB volumes
 #aws_region: eu-central-1
 
 # enable automatic migration on AWS from gp2 to gp3 volumes
 enable_ebs_gp3_migration: false
 # defines maximum volume size in GB until which auto migration happens
 # enable_ebs_gp3_migration_max_size: 1000
 
 # GCP credentials that will be used by the operator / pods
 gcp_credentials: "/var/secrets/google/key.json"
```

## Create a K8s Configmap resource with the following variables if you want to use WAL-G instead of WAL-E

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: pod-env-overrides
  namespace: postgres-system
data:
  # Any env variable used by spilo can be added
  USE_WALG_BACKUP: "true"
  USE_WALG_RESTORE: "true"
  CLONE_USE_WALG_RESTORE: "true"
```

## Update the option in a values file

pod_environment_configmap: "postgresql-system/pod-env-overrides"
2. Configure Logical backups:

Update the parameters in the values file:

```yaml
configLogicalBackup:
 # image for pods of the logical backup job (example runs pg_dumpall)
 logical_backup_docker_image: "registry.opensource.zalan.do/acid/logical-backup:v1.8.0"
 # path of google cloud service account json file
 logical_backup_google_application_credentials: "/var/secrets/google/key.json"
 
 # prefix for the backup job name
 logical_backup_job_prefix: "logical-backup-"
 # storage provider - either "s3" or "gcs"
 logical_backup_provider: "gcs"
 # S3 Access Key ID
 logical_backup_s3_access_key_id: ""
 # S3 bucket to store backup results
 logical_backup_s3_bucket: "backups-bucket"
 # S3 region of bucket
 logical_backup_s3_region: ""
 # S3 endpoint url when not using AWS
 logical_backup_s3_endpoint: ""
 # S3 Secret Access Key
 logical_backup_s3_secret_access_key: ""
 # S3 server side encryption
 logical_backup_s3_sse: "AES256"
 # S3 retention time for stored backups for example "2 weeksweek" or "7 days"
 logical_backup_s3_retention_time: "7 days"
 # backup schedule in the cron format
 logical_backup_schedule: "30 00 * * *"
Add parameter to postgresql.yml manifest:
apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: example-cluster
spec:
  enableLogicalBackup: true

```

Postgresql.yml
In order to deploy PostgreSQL clusters, I created our own helm chart, and store it in a private Chartmuseum, an open-source chart repository.

All available options of a specification of postgresql.yml can be found here.

Relying on the cluster needs, we use both HDD and Ceph(on HDD) as storage classes. Keep in mind that Ceph is significantly slower in I/O operations, so it is recommended only for development environments or small databases. There is a faster alternative for Ceph, called Linstor.

In production, it is needed to have at least three replicas of a cluster, located on different worker nodes.

Additionally, Enable the pod antiaffinity option in the operator values file, so the pods of the same statefulset will not locate on the same workers:

enable_pod_antiaffinity: true
As it is required for database clusters to use disks, we deployed a Rancher local-path provisioner into the Kubernetes cluster. The Local Path Provisioner is a Kubernetes storage provisioner that allows you to create Persistent Volumes on a local storage device, such as a disk or SSD, on a worker node.

In this case, we deploy our Postgres clusters only on dedicated workers, with enough resources for DB usage. To do so, we added taints and tolerations to restrict other pods for scheduling and node affinity to assign Postgres pods to dedicated nodes:

apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: example-cluster
spec:
   tolerations:

- key: dedicated
     operator: Equal
     value: postgresql
     effect: NoSchedule
 nodeAffinity:
   requiredDuringSchedulingIgnoredDuringExecution:
     nodeSelectorTerms:
  - matchExpressions:
    - key: dedicated
         operator: In
         values:
      - postgresql
If you want to predefine additional users in a cluster manifest, you can add the following to the spec:

spec:
…
  users:
    testuser: []
    readuser: [NOSUPERUSER, INHERIT, NOCREATEDB, NOCREATEROLE, NOREPLICATION]
…
There is a list of available user attributes:

                   - bypassrls
                   - BYPASSRLS
                   - nobypassrls
                   - NOBYPASSRLS
                   - createdb
                   - CREATEDB
                   - nocreatedb
                   - NOCREATEDB
                   - createrole
                   - CREATEROLE
                   - nocreaterole
                   - NOCREATEROLE
                   - inherit
                   - INHERIT
                   - noinherit
                   - NOINHERIT
                   - login
                   - LOGIN
                   - nologin
                   - NOLOGIN
                   - replication
                   - REPLICATION
                   - noreplication
                   - NOREPLICATION
                   - superuser
                   - SUPERUSER
                   - nosuperuser
                   - NOSUPERUSER
Another option is the ability to create databases with pre-assigned roles for the owner, reader, and writer, without having to specifically identify them within the users or databases sections:

spec:
…
  databases:
    testuser: testuser
  preparedDatabases:
    testuser:
      defaultUsers: true
…
In addition, there are some cases when you need external files located in the Postgres container. F.e. dictionaries. A workaround for that will be using an init container and a shared volume.

Create Dockerfile and copy the needed files:
FROM registry.opensource.zalan.do/acid/spilo-14:2.1-p6
RUN mkdir /shared-data
COPY *.dict*.affix *.stop /shared-data/
2. Build an image and push it to your registry.

3. Define an init container in the cluster YAML manifest:

spec:
…
initContainers:

- name: shared-data
   image: myregistry.mydomen.com/myrepo:dev
   volumeMounts:
  - name: shared-data
       mountPath: /usr/share/postgresql/14/tsearch_data/
   command: ['sh','-c','cd /shared-data/ && mv *.dict *.affix *.stop /usr/share/postgresql/14/tsearch_data/']
…

4. Define additional volume for your Postgres cluster:

spec:
…
additionalVolumes:

- name: shared-data
   mountPath: /usr/share/postgresql/14/tsearch_data/
   volumeSource:
     emptyDir: {}
…
Databases, larger than 100Gb, can face a problem with WAL archiving and physical basebackups. My error was “ERROR: canceling statement due to conflict with recovery”. The solution for this is to configure:

spec:
…
postgresql:
  parameters:
     max_standby_archive_delay: "900"
     max_standby_streaming_delay: "900"
…
Conclusion
In conclusion, the Zalando Postgres Operator is a powerful tool for managing PostgreSQL clusters on Kubernetes. It simplifies the deployment, scaling, monitoring, and backup of PostgreSQL clusters. I hope that this post has been informative and helpful for those who are new to the Postgres Operator or have been using it for a while. With the Zalando Postgres Operator, managing PostgreSQL clusters on Kubernetes becomes more efficient and reliable, which can help you to focus on your application and business logic. I encourage you to give it a try and see how it can benefit your organization.

Helm chart template:

apiVersion: acid.zalan.do/v1
kind: postgresql
metadata:
 labels:
   {{- include "postgresql.labels" . | nindent 4 }}
   team: {{ .Values.labels.team }}
 name: {{ .Values.labels.team }}-{{ include "postgresql.fullname" . }}
spec:
 {{- if .Values.enableLogicalBackup.enabled }}
 enableLogicalBackup: true
 {{- end }}
 allowedSourceRanges: null
 teamId: {{ .Values.labels.team }}
 tolerations:

- key: dedicated
     operator: Equal
     value: postgresql
     effect: NoSchedule
 nodeAffinity:
   requiredDuringSchedulingIgnoredDuringExecution:
     nodeSelectorTerms:
  - matchExpressions:
    - key: dedicated
         operator: In
         values:
      - postgresql
 {{- with .Values.users }}
 users:
   {{- toYaml . | nindent 4 }}
 {{- end }}
 {{- with .Values.databases }}
 databases:
   {{- toYaml . | nindent 4 }}
 {{- end }}
 {{- if .Values.enablePreparedDatabases.enabled }}
 preparedDatabases: {{- toYaml .Values.preparedDatabases | nindent 4 }}
 {{- end }}
 {{- if .Values.enableInitContainers.enabled }}
 initContainers: {{- toYaml .Values.initContainers | nindent 2 }}
 {{- end }}
 numberOfInstances: {{ .Values.numberOfInstances }}
 postgresql:
   version: {{ .Values.postgresql.version | quote }}
   {{- with .Values.parameters }}
   parameters: {{- toYaml . | nindent 6 }}
   {{- end }}
 resources:
   limits:
     cpu: {{ .Values.limits.cpu }}
     memory: {{ .Values.limits.memory }}
   requests:
     cpu: {{ .Values.requests.cpu }}
     memory: {{ .Values.requests.memory }}
 volume:
   size: {{ .Values.size }}
   storageClass: {{ .Values.storageClass }}
 {{- if .Values.enableAdditionalVolumes.enabled }}
 additionalVolumes: {{- toYaml .Values.additionalVolumes | nindent 2 }}
 {{- end }}
Values.yml:

# Team label

labels:
 team: linkedin

# Enable logical backup to gcs

enableLogicalBackup:
 enabled: true

# user

users:

# user: []

# read: [ NOSUPERUSER, INHERIT, NOCREATEDB, NOCREATEROLE, NOREPLICATION ]

# database name

databases:

# db: user

# db2: user

# Additional read and write users

enablePreparedDatabases:
 enabled: False
preparedDatabases: {}

# preparedDatabases

# db

# defaultUsers: true

# Add init container

enableInitContainers:
 enabled: False
initContainers: []

# initContainers

# - name: shared-data

# image: your-image:custom

# - name: shared-data

# mountPath: /usr/share/postgresql/14/tsearch_data/

# command: ['sh','-c','cd /shared-data/ && mv *.dict *.affix *.stop /usr/share/postgresql/14/tsearch_data/']

# Number of instances

numberOfInstances: 1

# PostgreSQL version

postgresql:
 version: "14"

# additional postgres parameters

parameters: {}

# max_standby_archive_delay: "900"

# max_standby_streaming_delay: "900"

# Resource limits

limits:
 cpu: 500m
 memory: 500Mi

# Resource requests

requests:
 cpu: 100m
 memory: 100Mi

# Size of the PV

size: 10Gi
storageClass: local-path

# Add additional volume to postgres pods

enableAdditionalVolumes:
 enabled: False
additionalVolumes: []

# additionalVolumes

# - name: shared-data

# mountPath: /usr/share/postgresql/14/tsearch_data/

# volumeSource

# emptyDir: {}
