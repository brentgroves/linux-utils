Thank you Father for teaching the joy of being kind and good to others!
Thank you for the life you have given me!
Thank you Father for the templating engines that is very good at generating HTML!
Thank you Father for letting me live in Wolf Lake!
Thank you Father for helping me make new friends!

Alex's car appointment
Dentist appointment at 2:30

Good morning my dear friends,
I hope you and your family have a wonderful thanksgiving together! It seems like we may have some warm weather for the holiday and I for one will appreciate the reprieve for the bitter cold :-)
If you need my help on this short happy week please feel free to contact me at any time at home or at work.
-Sincerely yours,
Brent 
260-564-4868

We can use curl to run the Trial Balance ETL pipeline and email the excel file to the customer but I wanted to create a simple web page to be more user friendly.

In this effort I found we needed a way for the web page to know when this long running report was finished. Why does Intelliplex/WebFocus have problems with SQL that runs longer than a minute and is there any way to avoid this problem? Maybe there is by using a publish/subscribe message server such as an MQTT broker.
Publish/Subscribe:

In order for a web app to know when its report request is finished we could use a publish/subscribe server.  So if the browser generates a unique report job ID and then listens on a WebSocket it can tell when the report is finished and can open the report pdf or excel file in a new window or tab.

Deployed an MQTT publish/subscribe message server to a k8s node.

Web app progress:
1. User enters the parameters for the report and clicks the run report button.
2. node.js API inserts the report job into the MySql reports queue table and returns the new job id to the web app.
3. the python report runner completes the job, sends an email with attachments containing the report, and informs the web app giving a link to the excel file, pdf, or HTML report.
4. the web app updates its status section and displays the link to the excel file or HTML report.

Why authenticate in web app?
1. manage reporting jobs by person or group.
2. display a tailored set of reporting tabs per person.
3. so the app can know a person's email without asking.


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

START AT DEBUGGING UPDATE_CRONTAB_TEMPLATE.PY
jsreport shows you how to make good looking HTML reports and dashboards by using html templating libraries and component toolkits.

Customer one-time report flow:
Bring up report web page.
Enter parameters and click run.
Node.js app hosting the web page inserts the job into the MySQL report queue.
Python report runner runs ETL, generates report by either using python to generate simple excel file or a Node.js templating engine to create a HTML report or dashboard.
Outputs:
1. sends an email with the excel report.
2. gives the web app a link to the HTML report or dashboard.  

HTML reports and dashboards:
jsreport shows us how to make good looking HTML reports and dashboards by using html templating libraries and component toolkits.

Why does Intelliplex/WebFocus have problems with SQL that runs longer than a minute?
Publish/Subscribe:
In order for a web app to know when it's report request is finished we need a publish/subscribe server.  So if the browser generates a unique report job name and listens on a websocket it can tell when the report is finished and can open the report html file in a new window or tab.

Deploy an mqtt publish/subscribe server to each node.

Using Bash, cron, Python, and Java we can write ETL scripts easily.
Using the Node.js report server we can generate nicely formatted HTML, excel, and pdf reports using templating engines easily.
If we combine the good ETL tools with this report making tool we are good to go!

git clone git@github.com:brentgroves/feathers-basics.git
git clone git@github.com:brentgroves/jsreport-learn.git
Next: Have the report runner call the report server after running the ETL scripts. 


Learnings:
https://jsreport.net/learn/get-started
https://jsreport.net/learn/browser-client
https://docs.feathersjs.com/guides/basics/starting.html#in-the-browser
From Feathers we can generate reports by using the jsreports nodejs client
From a web app we can generate a report using the jsreports browser client.

Next: validate on update_crontab_template.py
call sed-CronTabUpdate.py dev/prod and
do something similiar to all code that is different in a dev build.


Thank you father for this website: https://www.programiz.com/javascript/online-compiler/

Goal: 
Create a Feathers.js API:
1. that accepts params for the Trial Balance report.
2. generate an HTML report using a templating engine such as handlebars.
3. emails the HTML report.
4. displays the report from a separate web app that accepts TB params and invokes the API method.



