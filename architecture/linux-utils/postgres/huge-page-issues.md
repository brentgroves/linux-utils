## Hugepage issue

This article says it's very important but because of a sys bus error we can not enable hugepages.
<https://www.percona.com/blog/why-linux-hugepages-are-super-important-for-database-servers-a-case-with-postgresql/>
<https://stackoverflow.com/questions/67941955/kubernetes-postgres-bus-error-core-dumped>

Since we cannot use Mayastor and I have not tried rock ceph or minio opted to enable hostpath-storage as the default storage class.

<https://www.percona.com/blog/why-linux-hugepages-are-super-important-for-database-servers-a-case-with-postgresql/>

The article says huge pages are important and they are required for mayastor but I can't get any postgres operator to work with hugepages enabled get a system bus error. This may be because Mayastor has used them all.

<https://www.postgresql.org/message-id/HE1PR0701MB256920EEAA3B2A9C06249F339E110%40HE1PR0701MB2569.eurprd07.prod.outlook.com>

sudo sysctl vm.nr_hugepages=0

# set hugepages to 0 for postgres to work on k8s

sudo sysctl vm.nr_hugepages=0
sudo nvim /etc/sysctl.conf
cat /etc/sysctl.conf

sudo cat /proc/meminfo | grep HugePages

HugePages_Total:      72
HugePages_Free:       63
HugePages_Rsvd:       63
HugePages_Surp:       72
Hugepagesize:       2048 kB

<https://stackoverflow.com/questions/67941955/kubernetes-postgres-bus-error-core-dumped>

1

After having the problem myself it seems that it strongly relates to huge_pages being activated in the underlying OS in sysctl.conf.

The relationship of the error to huge_pages was not clear for me from skimming through the previous answer, hence this is a small write-up to make it clearer and directly summarize possible solutions.

Possible solutions for k8s:
Disable huge_pages in the OS with setting vm.nr_hugepages = 0 in sysctl.conf, taken from here. Please note that a restart might be necessary for the changes to take effect.
Disable huge_pages in postgresql by modifying postgresql config with the option huge_pages = off, taken from here.
Solution for bitnami helm chart:
In case you run into this problem while trying to deploy postgresql with bitnami charts. The postgresql.conf.sample can't be modified directly due to permission problems. But this github thread provides an example helm config to get the bitnami chart working.

primary:
  extendedConfiguration: |-
    huge_pages = off
  extraVolumeMounts:
    - name: pg-sample-config
      mountPath: /opt/bitnami/postgresql/share/postgresql.conf.sample
      subPath: postgresql.conf.sample
  extraVolumes:
    - configMap:
        name: pg-sample-config
      name:  pg-sample-config
extraDeploy:

- apiVersion: v1
    kind: ConfigMap
    metadata:
      name: pg-sample-config
    data:
      postgresql.conf.sample: |-
        huge_pages = off

        Been researching this for 2 hours so I decided to give up and seek help just to discover a stackoverflow issue which fixes my problem.

<https://github.com/bitnami/charts/issues/15419#issuecomment-1463301139>

It appears that there is some underlying issue with hugepages and k8s. Disabling it fixes the issue.

sysctl.conf:
vm.nr_hugepages = 0
Adding additional tags for future reference:
postgresql hangs on Generating local authentication configuration, postgresql restarts on generating local authentication configuration, postgresql crash bus error during initdb, initdb crash

I believe I hit the same issue (postgres works through docker run, but not k8s). The issue I hit was that huge pages were enabled, but they were not working through k8s, and Postgres wouldn't fall back properly to not using huge pages. I think there are several possible solutions to the problem:

The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.
 The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".
 Data page checksums are disabled.
 fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 10
selecting default shared_buffers ... 400kB
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
Bus error (core dumped)
child process exited with exit code 135
initdb: removing contents of data directory "/var/lib/postgresql/data"
running bootstrap script ...

Modify the docker image to be able to set huge_pages = off in /usr/share/postgresql/postgresql.conf.sample before initdb was ran (this is what I did).
Turn off huge page support on the system (vm.nr_hugepages = 0 in /etc/sysctl.conf).
Fix Postgres's fallback mechanism when huge_pages = try is set (the default).
Modify the k8s manifest to enable huge page support (<https://kubernetes.io/docs/tasks/manage-hugepages/scheduling-hugepages/>).
Modify k8s to show that huge pages are not supported on the system, when they are not enabled for a specific container.
