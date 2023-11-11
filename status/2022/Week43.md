Trial Balance: 
Greg needed this ran this week, before I had the API done. 

Ansible playbooks (automation tool): 
Created an inventory file of catagorized hosts
Use to programmatically add/remove cron jobs for running and emailing reports and excel files. 
Update cache and upgrade apt packages on a regular basis
Install all software to make a Ubuntu development system

UBU k8s cluster: 
Have a k8s node for Albion,Avilla,and Fruitport.
Each of the nodes have the following software installed:
MetalX Load balancer
NGinx ingress controller
MySQL server
ETL scripts that run at the same time as the Plex reporting server updates. 
Reporting API to allow report requests from postman or curl.


IT support:
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
10.1.1.83 moto 31008 

API paths accessible through k8s ingress: 
Reports, tooling, azure 

Tools: 
sed: stream editor used for templating of k8s YAML and docker files.
Kustomize: templating tool for k8s YAML files.
Ansible: It is used to automate the running of commands on a group of computers. Working on setting up a cron job to keep the Ubuntu k8s nodes updated. 
Postman is an API platform for building and using API accessible using the http protocol. 
A Docker image is a lightweight, standalone, executable package of software that includes everything needed to run an application.  
Kubernetes: network, storage, and container management software. It provides a sandbox for the installation and running of docker containers. 

Problem:
An API invoking ansible will be updating the cron jobs and cron will be running them, but we can not run two processes in one container.
Answer:
The API container will be not invoke ansible to update the cron jobs, but will update a database table named cron instead.
The ETL container, whose process is cron, will have a cron job that periodically iterates over the cron database table and invokes the ansible program to modify the cron table.

IT support: 
Albion ESXi hypervisor VM slower network speed than Avilla or Fruitport.
cisco anyconnect linux (Ubuntu )client
https://www.cisco.com/c/en/us/support/docs/smb/routers/cisco-rv-series-small-business-routers/Kmgmt-785-AnyConnect-Linux-Ubuntu.html

Next:
Father should I call a stored_procedure from jdbc?  
call stored procedure using jtds
https://docs.oracle.com/javase/tutorial/jdbc/basics/storedprocedures.html
jaydeebee for python is a good bridge for jdbc!
Would like to run a java etl script to get more control over stored procedure parameters.  Thank you Father for this tutorial!
JDBCTutorial
 