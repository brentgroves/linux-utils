I love you and have a wonderful plan for your life my son. Please do not give up as difficult circumstances arise day by day. You can look to me all of the time for your source of strength and direction. Remember you are here to learn how to get along with people and to care for them and serve using all of the abilities and talents I have blessed you with.  In fact, if you do your best to give away what I have given you or use everything to help and encourage people then you will have a life filled with peace and joy and you will be helping to make this world a better place!

Good morning dear ones,
I hope this email finds each of you in good spirits and that you and your loved ones had a pleasant weekend!  With that said it is with a sad heart that I hear about Jeff's departure :-( and would like to say I have enjoyed working together and getting to know you these past few years my friend!  Good luck in your next endeavor and may God bless you and your family in the years to come.
As always please feel free to contact me at work or home at anytime.
- Sincerely yours
Brent
260-564-4868

# Report system
This system can be used by programmers who know Python, Java, or Go by simply pulling a docker image onto there Windows, Mac, or Linux system.  It uses ETL scripts to pull from all company data sources into a central data warehouse and is independant of a companies choice of ERP and any other databases.
# Go
One of the outstanding features of Go is its concurrency support. From the **[Go Authors Talk](https://go.dev/blog/io2010)** we learned how simple it is to build a load balancer and communicate between processes with Go channels so how can we put this feature to use in our reporting system? 
## The problem
We want to use a REST API to run a report's ETL script set that can take as much time as needed to collect and transform data from Plex or other data sources. In that time period we do not want to run any other reports requested from other customers that depends on the tables we are updating. One solution is to only allow access to the REST API by one main program which would run each reports ETL script set until completion before starting another.  Is there a better way of doing this which would allow multiple programs to run ETL script sets simultaneously?

# concurrency vs parallelism
**[Achieving concurrency](https://medium.com/rungo/achieving-concurrency-in-go-3f84cbf870ca)**
Go recommends to use goroutines on one core only but we can modify the Go program to run goroutines on different processor cores. For now, think goroutines as Go functions, because they are, but there is more to it.
There are several differences between concurrency and parallelism. "While concurrency is dealing with multiple things at once, parallelism is doing multiple things at once." 

## Can we use Go's concurrency instead of a report runner to better scale the report system?
No. This is an issue we need to solve by parallelism instead of concurrency. The problem of running a second or third ETL set before the first ETL script completes does not seem to be solvable by concurrency it is more of a "race condition" problem or an issue requiring a Mutex or allowing only one process update table sets at a time so as to not modify table data before completing a serialized report set.
## Could having multiple data warehouses and GoRoutines allow the report system to scale?
Yes. The data warehouse itself is implemented as a database so each Postgres server could have as many data warehouses as we like and since the database is only used to produce serially identified report sets this should work. For example, the REST API could be made to rotate the insertion of report requests between each data warehouse's report request table. Then a Go concurrency function, GoRoutine, could be assigned to each data warehouse to monitor its own report request queue and running report ETL sets using its own database.

# Research Activities
## Add a TLS certificate to Mach2 web app.
Each Niagara installation automatically creates a default certificate, which allows the connection to be encrypted immediately. However, these certificates generate warnings in the browser and Workbench and are generally not suitable for end users. Creating and signing custom digital certificates allows a seamless use of TLS in the browser, and provides both encryption as well as server authentication.
Next Steps:
- Download the default Niagara certificate.
https://www.esri.com/arcgis-blog/products/bus-analyst/field-mobility/learn-how-to-download-a-ssl-certificate-for-a-secured-portal/
- There’s a bash one-liner magic that can extract certificates in their own files:

$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

- Ask Mathew to follow this process to add the Niagara default certificate to every computer using a group policy. https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/distribute-certificates-to-client-computers-by-using-group-policy 


#### What is Jace
direct connection to simple sensor and device inputs and outputs remotely located up to 4,000 feet (1,200 metres) away. Just imagining the uses for a Jace such as maybe for a PLC or any kind of sensor or circuit board that you wanted connected to Niagra at a lower level than updating tags on a PLC.

## What is a race condition?
The data warehouse is a database but it is not used like Plex, M2M, or any regular database. In a data warehouse we run ETL scripts to prior to creating a report set.  Each reports ETL scripts update a set of tables from data contained in other databases and then do calculations on that set to produce a serially identified unique report generated in an table and this final serialized report does not change and can be retrieved with its identifying serial number.
The issue in generating a report from a set of intermidiate tables is that if another set of report ETL scripts starts before the previous serialized report is completed the intermidiate data collected to generate the previous report is no longer valid and the previous report is not valid.
The solution to scaling the data warehouse involves using the same techniques used to resolve any race condition and that is to make sure only one report ETL script set be run at a time.
## How do we scale a data warehouse so that more than one report can be run at a time?
We can use the outstanding concurrency support in Go and multiple databases to achieve this.  The language abstracts OS threads so that they can be used easily and with less computing cost.  With PostgreSQL it is possible to create upto 4 GB of databases on a single server.  The idea is to create a several databases for each report so the Trial Balance would have its own set of database with its own table set apart from any other report.  The number of databases is scalable depending on the number of request initially it would be just one.  The report runner would start a concurrency function called a GoRoutine for each report database and its thread would monitor its queue and run reports scheduled to it and reduce a variable indicating how many reports it has to run.  The report requester would look at the number of reports running on each report database and insert the request into the one with the least number of reports to run.
## How does the customer know when their report is done?
As soon as report is requested the customer is given a unique serial number with which they can monitor on the reports status page. The report itself will be distributed via email or a Teams chat channel.  Since the report itself is retained indefinitely the report serial number can also be used to retrieve another copy of the same report at a later date if desired.
## What is a computer process?
**[Achieving concurrency](https://medium.com/rungo/achieving-concurrency-in-go-3f84cbf870ca)**
"When a compiled program is sent to OS to handle, OS allocates different things like memory address space (where process’s heap and stacks will be located), a program counter, a PID (process id) and other very crucial things. A process has at least one thread known as primary thread, while primary thread can create multiple other threads. When the primary thread is done with its execution, process exits."
## What is a thread?
"A thread is a light-weight process inside a process. A thread is the actual executor of a piece of code. A thread has access to memory provided by the process, OS resources, and other things."
## What is a stack/heap?
"While the stack of a thread can be used by only that thread and will not be shared with other thread. A heap is a property of a process and it is available to use by any thread. Heap is a shared memory space where data from one thread can be access by other threads as well."
## How does a web browser use threads?
"When you start a web browser, there must be some code which instructs OS to do something. This means we are creating a process. That process may ask OS to create another process for a new tab. When a browser tab opens and you are doing your normal everyday things, that tab process will start creating different threads for different activities (like page scroll, downloading, listening to music, etc.)"
## Thread scheduling
"When multiple threads are running in series or in parallel, as multiple threads might share some data, threads need to work in coordination so that only one thread can access a particular data at one time. Execution of multiple threads in some order is called scheduling. Os threads are scheduled by the kernel and some threads are managed by runtime environment of the programming language, like JRE. When multiple threads trying to access the same data at the same time which cause data to be changed or results into unexpected outcome, then race condition occurs."
## Go concurrency
"When we run a Go program, Go runtime will create few threads on a core on which all the goroutines are multiplexed (spawned). At any point in time, one thread will be executing one goroutine and if that goroutine is blocked, then it will be swapped out for another goroutine that will execute on that thread instead. This is like thread scheduling but handled by Go runtime and this is much faster."


