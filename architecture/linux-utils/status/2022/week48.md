Good morning team!
I hope you all had a very pleasant Thanksgiving holiday this year, and I look forward to getting back to work and spending some time with each of you this week. As always please feel free to call me anytime if there is anything that I can help you with :-)
-God bless
Brent
(260)564-4868

Going to try to divide up my day between the next report and k8s deployment that has the the task of running the report pipelines separated from the report request whether its from curl, web app, or cron job.

Reporting tasks:
Mean-time-between-failure: Try to refresh my memory about this statistic and look at the code we wrote a while ago to calculate it. It was something to the effect of summarizing the production hours sandwiched between CNC unplanned downtimes. I remember the code to calculate it even for one work center often timed out the first time it was ran, and that the idea was to transfer the data needed to perform the time-consuming work to the data warehouse. This will enable us to store the results to temporary tables for multiple work center comparisons by month, quarter, and year.

Trial Balance: There was a problem with the server that the old version of this software was running on in Albion.  Check to see if it needs any attention, or better yet deploy the new version of the software and forget about the old stuff. Also, think about replacing the Albion k8s node to move away from that ESXi hypervisor that was not intended for production use in the first place.

Update the old Tooling React.js web application and Node.js API:
This application is able to authenticate customers using the Azure API and can be updated to start and manage reporting jobs so that we can move past invoking report pipelines using a curl script.

Worked on MongoDB deployment.
Why:
A relational database is super for storing data in tables and manipulating those tables, data sets, by using complex joins, filtering, grouping, and summarization procedures and in transforming all that data into a final data set. But when the hard work of transforming the data into a final or close to the final result set is complete the power of a full-blown programming language, SQL, is no longer needed. When the final or nearly final result set has been computed we can use less powerful but faster and less memory-intensive techniques found in a NoSQL database to join, order, filter, group, and summarize that data set and to put it into formats such as HTML lists, PDF, and excel files.
So when exactly can you get away with putting data sets in a NoSQL database so we can take full advantage of its smaller size, speed, and ease of HTML formatting and presentation? The answer is when you no longer need the power of full-blown programming language, SQL, to transform your data, In other words, after the final data set has been generated and all but the simplest of joins can suffice in filtering, grouping, pivoting, or ordering your data set using the procedures found in a typical NoSQL programming language, such as MongoDB, dynamo DB, and HBase.
In conclusion, for our purposes, just before the dataset is ready to be manipulated by the report consumer we can go ahead and move the data set into a NoSQL database. In other words, the final SQL procedure used on the data set will not be to insert it into a relational database table but to insert the records into a NoSQL database.  From there a Nodejs/Python API can be used to pull data from the NoSQL data set, collection, and to transform it into some useful HTML list or PDF or Excel file using less memory and computing power.  

Research:
Can we create a ClusterIP service so that k8s pods have access to the MongoDB pod and then change the node port service to an ingress object so that we can use tls certificates to securely access MongoDB using an ingress path to map to the ClusterIP running on the 30331 port?

Migrate ETL generated for a report's final result set to MongoDB as the final stage of the reporting pipeline. This should result in faster report data retrieval times and is a good practice for scalability in general.
https://hevodata.com/learn/mysql-to-mongodb/

how to convert html to pdf in nodejs? Good there are Node.js modules to do this so it should be straight forward.
https://www.npmjs.com/package/html-pdf-node

Store excel and pdf reports as a file that can be emailed or accessed from a web page. I believe using a k8s ephemeral volume is sufficient although we may want to mount a persistent volume to the reporting pod so we don't lose reports if the pod happens to get restarted before the report is delivered.

How to setup MongoDB on docker? 
https://www.linode.com/docs/guides/set-up-mongodb-on-docker/



