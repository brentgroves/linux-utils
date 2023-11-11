<https://www.linuxtechi.com/how-to-install-postgresql-on-ubuntu/>

Enable PostgreSQL Package Repository
PostgreSQL 15 package is not available in the default package repository, so enable its official package repository using following commands.

$ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
$ wget -qO- <https://www.postgresql.org/media/keys/ACCC4CF8.asc> | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null
sudo apt update

sudo apt install postgresql-client -y
psql --version

<https://askubuntu.com/questions/1040765/how-to-install-psql-without-postgres>
sudo apt-get install -y postgresql-client
psql --version

dsn="database=hkp host=/var/run/postgresql port=5432 sslmode=disable"

/usr/lib/postgresql/11/bin/psql -p 5432
psql -h localhost -d hkp -p 5432 -U docker
psql database=hkp host=/var/run/postgresql port=5432 sslmode=disable

-h hostname
--host=hostname
Specifies the host name of the machine on which the server is running. If the value begins with a slash, it is used as the directory for the Unix-domain socket.
