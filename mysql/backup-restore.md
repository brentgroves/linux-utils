first follow the procedure found in the mysql directory in the
<git@github.com>:brentgroves/k8s-train.git repository to deploy
mysql to a k8s cluster.

ftp most recent dw backup found in the ~/backups/db folder of moto.

# notes

<https://stackoverflow.com/questions/53268697/error-3098-hy000-the-table-does-not-comply-with-the-requirements-by-an-extern>
I have this problem too. I found that MySQL Group Replication requires tables must have an explicit primary key defined.
<https://dev.mysql.com/blog-archive/enforce-primary-key-constraints-on-replication/>
<https://dev.mysql.com/doc/refman/8.0/en/group-replication-requirements.html>
SELECT require_table_primary_key_check FROM performance_schema.replication_applier_configuration;

<https://virtual-dba.com/blog/how-to-use-mysql-config-editor/>
mysql_config_editor print --all
mysql_config_editor set --login-path=client --host=10.1.0.116 --port=31008 --user=root --password
mysql_config_editor set --login-path=client --host=frt-ubu --port=31008 --user=root --password

# backup all databases

mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /mnt/qnap_avi/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > ~/backups/reports31/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

# restore all the databases

mysql -u root -p -h 127.0.0.1 --port=3306 < ~/backups/reports31/mysql/2023-10-19-17:29:22.sql.bak
mysql -u root -p -h 10.1.0.118 --port=31008 < ~/backups/db/2022-08-18-16:58:43.sql.bak

# backup just the test database

mysqldump -u root -p -h frt-ubu --port=31008 --column-statistics=0 --add-drop-table --databases test > ~/backups/db/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

# restore just the test database

mysql -u root -p -h 10.1.0.118 test --port=31008 < ~/backups/db/2022-08-18-16:58:43.sql.bak

<https://stackoverflow.com/questions/52423595/mysqldump-couldnt-execute-unknown-table-column-statistics-in-information-sc>
mysqldump -u root -p -h frt-ubu --port=31008 --column-statistics=0 test > dump2.sql
