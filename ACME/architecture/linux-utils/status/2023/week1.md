You can trust me every moment of your life my son.
Thank you Father for teaching me how to care for my wife better :-)
https://github.com/allyjunio/microk8s-mongodb-demo
https://stackoverflow.com/questions/69086174/how-to-deploy-mongodb-replicaset-on-microk8s-cluster
https://microk8s.io/docs/addon-hostpath-storage

How can we login to mongodb from the node ports IP? We already did a bind ip all when starting the process?
Do we need a setting in the config file also? is the config file in /var/
https://medium.com/@shubhamdhote9717/mongodb-deployment-on-kubernetes-cluster-via-deploymentset-and-statefulset-6ca649894ca7
https://blog.palark.com/running-mongodb-in-kubernetes/
https://medium.com/founding-ithaka/setting-up-and-connecting-to-a-remote-mongodb-database-5df754a4da89#:~:text=Enable%20MongoDB%20Auth,-Once%20your%20admin&text=In%20the%20same%20config%20file,connections%20from%20all%20ip%20addresses.&text=Now%20save%20and%20exit%20the%20config%20file%20and%20restart%20mongodb%20server.
https://stackoverflow.com/questions/37372684/mongodb-3-2-authentication-failed
Then I enable security features in the conf file and restart the server:


Is feathers sending 2 create messages?
https://feathersjs.com/api/client/socketio.html

Study  // https://reactjs.org/docs/hooks-effect.html  

Good morning my friends! 
I hope you all had a terific holiday or at least survived depending on if you enjoy this festive season or not.  First days back to work after a long break are difficult and here's to hoping each one of you adjust to work as easily as possible :-) The database story is included here after the status report.


- Sincerely yours
Brent

Enhanced reporting system:
4 high-available clusters of 3 nodes each: reports0, reports1, report3, and ubu.
12 MySQL deployments: with database persistent storage on each node. Replicated the database over nodes for scalability is difficult.
4 MongoDB replica-sets: 1 replica-set on each k8s cluster. Each set has 3 syncronized databased. Updates to any of the 3 databases are automatically propogated to the other 2. Members can be added to each Replica-set making it great for scalability.  
Report pipelines do the hard work on MySQL and the final report is copied to MongoDB and assigned a report id.
The react app and crontab take costomer requests and inserts them into the MySQL report queue.
The report runner pulls report requests from the report queue and runs the report pipeline upto emailing report files.
The report runner publishes a completion message for the report id.
the react app listens for the report runners completion message and opens a new tab containing the report.
Make reports-react insert a record into the jobs collection from a trial balance tab. Then liston for mqtt message that it is done with a report id of the report collection.
When the report runner runs a report the report is assigned an id and is stored in a mongodb for one week. The customer can have the excel or pdf emailed to her, but she can also view and download the reports from the web app for the next week.

Report react web app components:
App component:
- display Login or Chat component
- subscribe to authenticated event
- get messages and users
- pass messages and users to Chat component.

Login component 
- display 'Login' or 'Login as email'
- display 'signout of account'
- redirect /auth
- call Microsoft login 
- redirect /auth-callback
- redirect /?email=user-email
- login to user account.

Report request component:
- display report tabs
- collect report requests from the customer
- insert report requests in the MySQL report queue and obtains a report id.
- subscribes to report completion messages and waits for report id to complete.
- opens the new report in another tab.

Chat component (for rese)
- display Chat component
- display signout button
- has users and messages state
- subscribe to create message and user events
- concatenates new users and messages to array
- reverses message array and trims to 25 messages
- unsubscribes to create user and message events

Database Story
The purpose of this story is to entertain and try to answer the question of why we need a PCN for different sites. Take this story with a grain of salt because I didn't spend any time on research! 
1. Cobol
In the 70's we used Cobol to create reports. What I remember is that you had to create 5 program divisions, the only one I remember is the procedure division. When I ran these reports some of the IT people would get anxious because they took a considerable amount of the Wang mini's resources.
Characteristics:
Data stored in flat files.
I don't remember how we linked data in different files but I believe we did.
Output reports on green and white paper.
2. Hiarchical databases
Our unisys, I think that was the name, mainframe had this software
Characteristics:
I believe the programmers decided it was a good idea to abstract files into tables and make a hiarchical way to store data.  
I imagine linking data from tables was easier than with Cobol but I never got a chance to create a report on this system since I worked in the Air Force Civil engineering squadran and not in the supply squadron. Colonol Abrams taught was the master of this database and he let us look at it in our database class but we didn't get to touch it.
3. SQL Server
There were some big improvements here.  The programmers decided that abstracting files into tables was still a good idea but this relating the data hiarchically did not fly so it was dropped in favor of a flat object based linking approach.  
Characteristics:
- Is now a full programming language with several popular dialects.
- relates tables using common fields.
- programming language very good at manipulating data sets to produce a final result set.
- A division for different geographical regions, in our case PCN, out of making more money and technical limitations.
4. Replicatable Database
With the advent of cloud computing and databases used by multiple geographical regions it became desirable to have a database the could have its data syncronized between multiple geographic regions. So when Harry updates the data in a table in Chicago Sally will see that update in her database in San Diego.
Characteristics:
- The programmers decided it was good to switch to objects, JSON, instead of storing data in tables linked by fields.
- Easier to add, remove, and update uniquely identified objects stored in multiple databases than replicating field linked tables.
- Some implementations use the JavaScript/ECMA scripting language to handle data set manipulations.
  
