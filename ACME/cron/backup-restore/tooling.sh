#!/usr/bin/bash
# printenv > /tmp/print_envs_result
mysqldump -u root -p -h moto --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /home/bgroves@BUSCHE-CNC.COM/backups/db/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak
