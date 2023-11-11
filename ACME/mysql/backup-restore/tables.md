<https://mysqldump.guru/how-to-mysqldump-specific-tables.html>

mysqldump my_database my_table1 my_table2 my_table3 > my_backup.sql

mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > ~/backups/reports31/mysql/tables/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

-- ETL.script_history definition

CREATE TABLE `script_history` (
  `script_history_key` int NOT NULL AUTO_INCREMENT,
  `script_key` int NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `done` bit(1) NOT NULL,
  `error` bit(1) DEFAULT NULL,
  `time` int DEFAULT NULL,
  PRIMARY KEY (`script_history_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
