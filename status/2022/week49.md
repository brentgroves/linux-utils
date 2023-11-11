Thank you Father for quiting my heart when I ask you for help!
I trust you my Father for all of my needs!  Thank you for caring for us all and for reviving our spirits when we are down :-)

https://morphatic.com/2019/04/15/authorizing-feathers-api-requests-for-vue-react-angular-apps-using-auth0/
https://auth0.com/pricing
https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/webservices/authenticate-web-services-using-oauth
https://learn.microsoft.com/en-us/azure/active-directory/develop/msal-node-migration
https://manage.auth0.com/dashboard/us/dev-gfcd1ld5m2jtz0m0/connections/enterprise/waad/create
https://codesandbox.io/examples/package/@feathersjs/authentication
https://docs.feathersjs.com/api/authentication/oauth.html
https://docs.feathersjs.com/cookbook/authentication/auth0.html#strategy

Good morning my friends,
I hope you enjoyed doing whatever it is you do besides work this weekend! May you and your loved ones have a blessed Holiday season this year or at least get through it successfully depending on if you enjoy this time of year or not :-) As always please feel free to ask me for anything that I can help you with whenever you need me and I will do my best to help any way that I can!
-God bless
Brent
(260)564-4868


Goal to get new the version 2 of the reports deployment working so we don't have to worry about maintaining version 1 anymore. and so our customers have some way to run the Trial Balance report without asking me.

Send out a status update to report customers, Jake Kunkel, Dan, and Greg Phillips telling them the progress being made on their reports.

enhanced reporting system gives us:
Unlimited computing time.
Live data that shows the same content as a Plex screen.

Version #1:
Runs the ETL pipeline for the Trial Balance report at a scheduled time using a cron job.
Version #2:
Changed the cron jobs to insert report requests into a queue instead of running them directly.
Added a python API to insert ETL pipeline jobs into a queue by our customers using curl.
Added a report runner that pulls jobs from a queue to run ETL pipelines in order so that one pipeline can be completed before running another.
Version #3:
Add a web application to replace the command line interface of the python API.
Use a message broker and node.js API to inform the customer of when there jobs have been completed.

Would like to finish version #2 before working on the mean time to failure series of reports.

Wrote instructions to deploy mysql, mongodb, mosquitto, reports-cron, reports-api, and reports-runner to each k8s node using a sed and kustomize templating system.

reports:
trial-balance - Dan and Greg status 
mean-time-to-failure series - power bi at first, jake know Feb 1st or tell Kevin
mean-time-to-repair - sandwich uptimes. 
daily-production - not scheduled

Enhanced reporting system:
This system is meant to provide us with the capability to run reports requiring unlimited computing time and live Plex data but it can also be used to run any reports small or large.

reporting goals:
1. real-time data: See the same data as shown on Plex screens. Our existing reporting system runs off of a snapshot of the Plex database that is upto four hours old. 
2. long-running: capability to run reports that require more than a minute to compute.
3. Store data: Our existing system does not allow us to create our own database tables which we can use to store results from previous days, months, or years.
3. scalability: as users increase the number of instances of software also increases
4. rolling updates: as software is updated or fixed normal operations are not disrupted


pre-made software:
Kubernetes (k8s): keeps software running, allows scallability, and rolling updates. 
mssql: used for Plex and Azure data warehouse.
mysql: used for k8s data warehouse.
mongodb: faster non-relational database that scales well. 
mosquitto: publish/subscribe message broker that provides communication between other software.
crontab: used for report job scheduling
curl: command line tool to insert jobs into the reporting queue

software scripts or apps that we have created:
ETL scripts: moves data from Plex to k8s data warehouse.
reports queue: database table of reports to run.
reports-crontab: scheduled inserts of reporting jobs into the reports queue
reports-python API: customer inserts of reporting jobs into the reports queue 
reports-nodejs API: uses message broker to notify customers of report completion and call into the reports-python API. 
reports-runner: processes reporting jobs in the reports queue
reports-web-app: customer interface to reporting system that includes add/update/deleting report jobs. 

Hardware:
This is a list of the nodes on our four k8s clusters.  These nodes are either discarded PCs or virtual machines.
 <!-- The range of valid ports is 30000-32767 -->
IP              node        mysql   mosquitto mongodb
10.1.0.116      reports01   30001   30201
10.1.0.117      reports02   30002   30202
10.1.0.118      reports03   30003   30203
10.1.0.110      reports11   30011   30211     30311
10.1.0.111      reports12   30012   30212     30312
10.1.0.112      reports13   30013   30213     30313
172.20.88.61    reports31   30031   30231     30331
172.20.88.62    reports32   30032   30232     30332
172.20.88.63    reports33   30033   30233     30332
10.1.0.120      alb-ubu     30101   30111
172.20.88.16    avi-ubu     30102   30112
172.20.1.190    frt-ubu     30103   30113
10.1.1.83       moto        31008   30108
