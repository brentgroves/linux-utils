# Database backup

<https://mysqldump.guru/how-to-mysqldump-specific-tables.html>

## backup just one database

mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --databases ETL > ~/backups/reports31/mysql/database/ETL$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak
mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --databases Plex > ~/backups/reports31/mysql/database/Plex$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak
mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --databases Azure > ~/backups/reports31/mysql/database/Azure$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

mysqldump -u root -p -h frt-ubu --port=31008 --column-statistics=0 --add-drop-table --databases test > ~/backups/db/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

## restore just one database with port forwarding enabled

### create database first

<https://stackoverflow.com/questions/5132923/how-to-add-a-primary-key-to-a-mysql-table>
create database ETL;
ALTER TABLE goods ADD PRIMARY KEY(id)

rename table goods to goods_old;
mysql -u root -p -h 127.0.0.1 ETL --port=3306 < ~/backups/reports31/mysql/database/ETL2023-10-19-18:47:30.sql.bak
create database Plex;
mysql -u root -p -h 127.0.0.1 Plex --port=3306 < ~/backups/reports31/mysql/database/Plex2023-10-19-19:19:47.sql.bak
create database Azure;
mysql -u root -p -h 127.0.0.1 Azure --port=3306 < ~/backups/reports31/mysql/database/Azure2023-10-19-19:26:27.sql.bak

## restore just one database with nodeport service running

mysql -u root -p -h reports51 ETL --port=30051 < ~/backups/db/2022-08-18-16:58:43.sql.bak
