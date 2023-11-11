# PostgreSQL Backup

<https://web.mit.edu/cygwin/cygwin_v1.3.2/usr/doc/postgresql-7.1.2/html/app-pgdump.html#:~:text=pg_dump%20also%20accepts%20the%20following,for%20the%20Unix%20domain%20socket>.

<https://stackoverflow.com/questions/2893954/how-to-pass-in-password-to-pg-dump>

<https://www.postgresql.org/docs/8.4/app-pgdump.html>

Summary: in this tutorial, you will learn how to backup the PostgreSQL databases using the pg_dump and pg_dumpall tool.

PostgreSQL comes with pg_dump and pg_dumpall tools that help you backup databases easily and effectively.

For ones who want to see the command to backup databases quickly, here it is:

pg_dump -U username -W -F t database_name > c:\backup_file.tar
Code language: SQL (Structured Query Language) (sql)

pg_dump also accepts the following command line arguments for connection parameters: -h host, --host=host.

```bash
## dump the database in custom-format archive

pg_dump -Fc mydb > db.dump

##  restore the database

pg_restore -d newdb db.dump

mkdir -p ~/backups/reports51/postgres/

# PGMASTER only needed for kubectl port forwarding command
export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)

export PGSSLMODE=require # for nodeport

export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)

pg_dump -h reports51 -p 30451 -U postgres zalando > ~/backups/reports51/postgres/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.dump

psql -U postgres -d zalando -h reports51 -p 30451 -f ~/backups/reports51/postgres/2023-10-25-14:05:42.sql.dump


```

## restore database

<https://github.com/zalando/postgres-operator/blob/master/docs/user.md#restore-in-place>

There is also a possibility to restore a database without cloning it. The advantage to this is that there is no need to change anything on the application side. However, as it involves deleting the database first, this process is of course riskier than cloning (which involves adjusting the connection parameters of the app).

First, make sure there is no writing activity on your DB, and save the UID. Then delete the postgresql K8S resource:

zkubectl delete postgresql acid-test-restore
Then deploy a new manifest with the same name, referring to itself (both name and UID) in the clone section:

metadata:
  name: acid-minimal-cluster

# [...]

spec:

# [...]

  clone:
    cluster: "acid-minimal-cluster"  # the same as metadata.name above!
    uid: "<original_UID>"
    timestamp: "2022-04-01T10:11:12.000+00:00"
This will create a new database cluster with the same name but different UID, whereas the database will be in the state it was at the specified time.

⚠️ The backups and WAL files for the original DB are retained under the original UID, making it possible retry restoring. However, it is probably better to create a temporary clone for experimenting or finding out to which point you should restore.
