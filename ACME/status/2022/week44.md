Thank you Father for you mercy and love!
https://docs.oracle.com/javase/tutorial/deployment/jar/appman.html

https://www.skylit.com/javamethods/faqs/createjar.html
https://stackoverflow.com/questions/4597866/java-creating-jar-file
https://cs.iupui.edu/~ajharris/240/jarFiles.html
https://www.digitalocean.com/community/tutorials/java-repl-jshell
https://code.visualstudio.com/docs/java/java-tutorial
https://www.baeldung.com/java-create-jar
https://docs.oracle.com/javase/tutorial/deployment/jar/build.html
https://www.webucator.com/article/how-to-create-a-jar-file-in-java/
continue working on the tool boss/cribmaster jdbc ETL program to copy the items table into the MySQL DW.\
Test connection to CM,ToolBoss, and Azure SQL Server.
python: Plex to MySQL/Azure MSSQL DW.
Java: CM/TB to MySQL/Azure MSSQL Dw.

Happy Halloween everyone,
I feel thankful to be working with each one of you guys!  If there is anything I can do for you please feel free ask.
God bless
Brent
260-564-4868

MTBF Report SSIS scripts

Add jre to dockerfile.

Ask about Reconciliation Process Update.

Goal: 
Get Trial Balance report access through curl to Dan and Greg.

Reporting:
k8s deployments for cron, reporting API, and a report runner.
Plan for all 3 containers to process the same ETL scripts through as shared volume. 

Ansible automation:
There is a module for cron and apt. Plan to use the apt module to ensure the k8s nodes stay updated and our rebooted regularly.   

ETL Scripts:
These scripts are used unaltered by cron jobs, report API, and the upcoming report runner. These three processes each have there own docker container and k8s deployment but use the exact same ETL scripts. These ETL scripts currently use python scripts calling both ODBC drivers and python specific database modules to do there work.

ODBC/JDBC/Python Database module:
Plex: We have ODBC drivers from Plex and they work fine on Ubuntu 22.04 and unixodbc.
Azure DW: We use Microsoft supplied ODBC drivers for Azure SQL servers and they work fine on Ubuntu 22.04
MySQL DW: We use a Python database module for specifically designed for MySQL databases. 
Cribmaster/Made2Manage/Tool Boss/Tool List: 
We did use the same Microsoft supplied ODBC drivers as we use for our Azure SQL Server but Microsoft does not currently support Ubuntu 16.04,18.04,20.04, or 22.04 so they no longer work. Microsoft does currently support Debian so we could change our docker base image from Ubuntu to debian. 
Another option is to use the jTDS JDBC driver and a python bridge to JDBC drivers, but the bridge does not support output parameters to stored procedures and is not well mainted. The most supported alternative to connecting to non-azure mssql servers from linux is found in Java DB using JDBC drivers. JDBC drivers are also used on dbeaver and all of the universal database clients that I have used,ie. there are JDBC drivers for all new and old databases that I have worked with. So for creating ETL scripts for Cribmaster/Tool Boss/Tool list/Made2Mange it seems wise to make small Java apps instead of python scripts.

JDBC ETL Script:
Test this by creating an app to move tool list items to MySQL DW.

IT support:
Jared added the DNS entries for SSL connections to the reporting API. Thank you. 
When the 3 reporting containers are running was going to ask Jared about setting up port forwarding to MySQL data warehouses:
Thank you for considering this request!
<!-- The range of valid ports is 30000-32767 --> 
10.1.0.120 alb-ubu 30101 
172.20.88.16 avi-ubu 30102 
172.20.1.190 frt-ubu 30103 
10.1.0.116 reports01 30001 
10.1.0.117 reports02 30002 
10.1.0.118 reports03 30003 
10.1.0.110 reports11 30011 
10.1.0.111 reports12 30012 
10.1.0.112 reports13 30013 
172.20.88.61 reports31 30031 
172.20.88.62 reports32 30032 
172.20.88.63 reports33 30033 
10.1.1.83 moto 31008 
