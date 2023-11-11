https://devopscube.com/install-postgresql-on-ubuntu/
https://www.enterprisedb.com/postgres-tutorials/how-install-postgres-ubuntu


https://www.bigbinary.com/blog/configure-postgresql-to-allow-remote-connection
In order to fix this issue we need to find postgresql.conf. In different systems it is located at different place. I usually search for it.

$ find / -name "postgresql.conf"
/var/lib/pgsql/9.4/data/postgresql.conf

sudo nvim /var/lib/docker/volumes/devel_pg_data/_data/postgresql.conf

Open postgresql.conf file and replace line
listen_addresses = 'localhost'
with
listen_addresses = '*'

Now restart postgresql server.
$ netstat -nlt


https://nst.sourceforge.net/nst/docs/faq/ch06s02.html#:~:text=To%20enable%20the%20PostgreSQL%20server,used%20to%20start%20the%20server.

By default, the setup_postgresql script starts the PostgreSQL database such that it only accepts Unix-domain connections. This means you will not be able to connect to the database from external machines.

To enable the PostgreSQL server to accept TCP connections, you must modify two configuration files and then restart the server.

You must add the -i option to the /etc/sysconfig/pgsql/postgresql configuration file which is used to start the server.

Figure 6.1. Configuring PostgreSQL for TCP Connections

PGDATA=/mnt/ram4/var/lib/pgsql/data
PGPORT=5432
PGOPTS="-i"