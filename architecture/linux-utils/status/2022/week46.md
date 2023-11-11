Thank you for this work my Father and the joy you give me doing it!
Thank you for teaching me that there is more to life than work!
Thank you for teaching me that the best part of life is caring and helping other people!
Thank you for helping me to remain calm and to trust in your timing and plan for us all!

Good afternoon my friends,
I hope you all had a very pleasant weekend and our prepared for the cold weather that is already upon us!  Thanks to each of you for helping make this place a great place to work :-)  If you need my help with anything this week please feel free to ask or call me 260-564-4868.
-sincerely yours,
Brent 

Ran Oct 2021 to Oct 2022 Trial Balance report for Dan Martin.

Testing new way of inserting report jobs into a mysql table instead of just running them with cron or the API directly.

Testing new architecture that adds all cron scheduled and one-time report request to a reporting queue so that jobs can be ran one at a time by the report runner so that multiple requests don't interfere with one another.

Working on reporting api endpoints to be accessed by curl utility initially.
https://reports31/report_help (email text file of how to use this email.) 
https://reports31/report (run etl, generate reports, send email)
https://reports31/crontab (add/delete crontab entries)
https://reports31/crontab_check (check syntax of crontab entry)
https://reports31/crontab_help (email report of all records in crontab table)

Working on several other k8s deployments.
reports-cron-monitor: k8s deployment of a simple html file to view and update the reporting job queue using the reporting api.
reports-server: k8s deployment of an open-source report server that uses the reporting API to generate excel, pdf, and HTML reports. https://jsreport.net/ has been around for a long time and I have used it in the past.
reports-viewer: k8s deployment of a simple html file that uses the reports-server to view and export the Trial Balance report.

IT support:
Requested both public and private keys for mobexglobal.com to add to our k8s ingress controllers for secure connections from Microsoft teams hosted Power BI reports.

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

List of Docker Containers found on each k8s node:
mysql: Each node has it's own MySql server and a unique tcp port.
reports-volume-init: This init container has all scripts and apps used by the reporting software.
reports-cron: container that runs the cron process. it pulls jobs from MySql.Reports.crontab table and updates itself every minute.
reports-api: implements the endpoints described below. Its main function is to insert jobs into MySql.Reports.crontab and MySql.Reports.queue.
reports-runner: Pull report requests one at a time and process them by running ETL scripts, genereting excel, and sending an email.  
Shared Volume:
reports-volume: temporary storage that gets reinitialized with all script and apps every time the k8s reports pod gets restarted.


check crontab format:
If user enters an incorrect crontab item then return an error message.
https://medium.com/@geoffrey.mariette/python-cron-syntax-checker-87562f06ad4c




