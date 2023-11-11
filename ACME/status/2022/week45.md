Thank you, Father, for teaching us how to enjoy our work!
Thank you, Father, for helping us to believe that you love us!
Father thank you for helping me to hang in there today!
I trust you!
Praise you!

Next: runner->app.py
goal: get next report from Report.report_queue and then run it.



I worked on moving shared data from containers to volumes last week.

Shared Volumes:
Because k8s and docker containers work best by having only 1 process running so the controller can monitor that process, PID 1, and keep it running at all times we need a way to access shared resources without duplicating them in multiple containers. Since k8s volumes are not persistent we initialize them at startup from a static container or by retrieving data from the network, database, or internet.

Mounted Volume:
Persistent storage containing data that resides outside of the k8s cluster which is mounted and accessible to a container such as: Database files, NFS, Azure, or a directory on a local hard drive.

As a result of moving shared data from containers to volumes, our k8s now looks a little different.

k8s objects on each node:
The reports-etl-volume: A shared-data volume initialized with the ETL scripts.
The reports-crontab-volume: A shared-data volume initialized by an python script pulling records from the MySQL report-job table.
The reports-etl container: Runs the cron process.
The reports-api container: Runs the api to populate the report-job table, and queues one-time reports to the MySQL report-queue table.
Command to queue a report:
curl -X POST http://reportsXXX.bushe-cnc.com:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"username@buschegroup.com","start_period":202201,"end_period":202207}'
The reports-runner container:  Python script that pulls job records from the report-queue and runs the appropriate parameterized pipeline to generate an email an excel or html report.

I felt we needed to move from ODBC to JDBC to connect to our less TLS friendly databases.

JDBC:
It is easier to connect to all types of databases with Java and JDBC drivers. I imagine many universal database clients use JDBC instead of ODBC since the drivers are much easier to find and they work so well. You can find several different JDBC drivers for almost any database including Access, Firebird, MySQL, MSSQL, SQL-Lite, DB2, Oracle, PostgreSQL.

We now have a simple java build environment that uses only the java compiler and jar utility for builds and Visual Studio Code for debugging. We also have an ETL program, mobex.etl.restrictions2.jar, to copy the Albion tool boss restrictions to the Azure and MySql data warehouses.

IT Support:
Please consider the following request to make reporting easier from Microsoft Teams.
A Power BI report hosted on Microsoft Teams needs a public endpoint to connect to our internal data warehouses to work. We can make this connection more secure by having the public and private keys to the TLS certificate for mobexglobal.com. The TLS public and private keys would be added to our k8s Nginx ingress controllers to perform TLS termination before passing the network traffic to the data warehouses or the reporting API. In order to make this work we also need port forwarding to the following k8s nodes hosting MySQL databases:
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


The shared-data volume was initialized by an init-container but I changed the container but the volume has the same data it had originally.
build a new revision of reports-etl-volume and update the revision of the init container.
Cron jobs: How we can modify the crontab from the reports-api if cron is running on the reports-etl container. 
add a cron job to call crontab /etc/cron.d/etl-crontab every minute.
etl-crontab is on a shared volume and can be updated by reports-api and processed on reports-etl.
curl is used to add/remove a report cronjob from etl-crontab
on container restarts an init container initializes /etc/cron.d/etl-crontab from a database table.
the database table has named cron job for calling ETL pipelines which generates reports and emails excel files or html reports. 
# must be ended with a new line "LF" (Unix) and not "CRLF" (Windows)
# greg-weekly-tb-yearly
0 0 * * 0 cd /app/etl/PipeLine && ./TrialBalance.sh gphilips@buschegroup.com 12 >> /home/brent/10 
# dan-daily-tb-current-period
10 23 * * * cd /app/etl/PipeLine && ./TrialBalance.sh dmartin@buschegroup.com 1 >> /home/brent/cron.log
* * * * * crontab /etc/cron.d/etl-crontab
# An empty line is required at the end of this file for a valid cron file.
Method to maintain cron jobs
1. make a table unique-name,command,min,hour,etc.
2. add and remove records from this table via curl and reports-api.
3. make a python script to generate etl-crontab-new from this table.
4. every minute call the python script && cp /etc/cron.d/etl-crontab-new /etc/cron.d/etl-crontab && crontab /etc/cron.d/etl-crontab 

https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/
the cron process which is in /usr/sbin for silent daemon processes.

https://redhat-scholars.github.io/kubernetes-tutorial/kubernetes-tutorial/jobs-cronjobs.html
https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
Goal: change TrialBalance.sh to get data from db-user-pass
make an reports-crontab image with the crontab-template.
make a crontab-volume then make reports-crontab run crontab-init-template.sh whose parameters are changed by sed-k8s-reports.sh to copy the correct environment variable initialized crontab to /etc/cron.d.
make another secrets object reports31 which contains MYSQL_HOST,MYSQL_PORT,AZURE_DW.
Then mount to /params and change TrialBalance.sh to get environment variables from /params:
export MYSQL_HOST=$(cat /params/MYSQL_HOST)  

kubectl create secret generic reports31 \
  --from-file=MYSQL_HOST=./reports31.txt \
  --from-file=MYSQL_PORT=./mysql_port.txt \
  --from-file=AZURE_DW=./azure_dw_0.txt

https://www.spectrocloud.com/blog/how-to-share-data-between-containers-with-k8s-shared-volumes/
REVIEW THE DEPLOYMENT.YAML AND APPLY IT TO K8S
make templating for reports-api and add container to the reports-pod
Create reports31-crontab dockerfile and use as a shared volume mounted to /etc/cron.d.
Then add an ansible cron module function to reports-api. 
If populating reports31-volume with the cp -R /app/* /data/ works then try reports31-crontab with an entrypoint that copies data from Reports.run-reports table into the crontab file.

JDBC:
It is easier to connect to all types of databases with Java and JDBC. Universal database clients use JDBC instead of ODBC. You can find many JDBC drivers for any database from Access to MongoDB.
setup a simple java build environment which uses only the java compiler and jar utility for builds and Visual Studio Code for debugging. Then created an mobex.etl.restrictions2.jar program to copy the Albion tool boss restrictions to the Azure and MySql data warehouses.

IT Support:
Please consider the following request to make reporting easier from Microsoft Teams.
A Power BI report hosted on Microsoft Teams needs a public endpoint to connect to our internal data warehouses to work. We can make this connection more secure by having the public and private keys to the TLS certificate for mobexglobal.com. Both the TLS public and private keys would be added to our k8s Nginx ingress controllers in order to perform TLS termination before passing the network traffic to the data warehouses. In order to make this work we also need port forwarding to the following k8s nodes hosting MySQL databases:
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

May your will be done, Father!

ETL:
Deploy java app to copy Albion tool boss restrictions to the data warehouse. Then add a cron table entry to run this app weekly.

ETL definitions from: https://medium.com/@israelmwangoka_96436/real-time-etl-with-java-groovy-73c4fb2ced40
and https://www.javatpoint.com/etl-process
Batch ETL: Means data is being extracted from sources after particular time intervals, processed and load it into destinations i.e. data is processed in batches.
Real-Time ETL: This is probably the latest ETL technology in which data is processed immediately upon their arrival. Sometimes this is called Stream processing or Real-Time processing.

Shared Volume:
Because k8s and docker containers work best by having only 1 process running so the controller can monitor that process, PID 1, and keep it running at all times we need a way to access shared resources without duplicating them in multiple containers. Our shared volume contains static resources such as static java and python ETL scripts and jar files. 
Mounted Volume:
Storage for data which changes such as a database or cron table which is mounted and accessible to a container such as: NFS, Azure, or a directory on a local hard drive.

IT support:
What are the requirements for a teams based Power BI report data source or web app?
Purchase a domain name and TLS certificate for mobexglobal.net and need access to the private key for tls termination. 
If we could add port forwarding to these MySQL databases then we could use them in Teams accessible Power BI reports.
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

Can we register a mobexglobal.net and have a subdomain such as database.mobexglobal.net which we port forward to?
<!-- mgsqlmi.public.48d444e7f69b.database.mobexglobal.net -->


