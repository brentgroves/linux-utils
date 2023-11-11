I will help you my son in everything you do because I love you and am always there for you!  My plan is for you to help people and to show them you care about each one.  This is what I want for you to love and care for others.  By growing in love for others you will be helping to make this world a better place.  Do not be anxious for anything but look to me for direction.  Do not worry about the future and do not worry about the past.  Instead look to me because I have a plan for your good and the good of all people.  Trust me my son because I love you and will always take good care of you and everyone!

Thank you Father for helping us to be couragous in uncertain times.  These times our not uncertain my son since I have ordained what is to happen each and everyday. You can be certain there is a purpose to every situation and you can trust me for all of your needs because I love you.
I love you no matter what you do or say.  You don't have to be perfect and you don't have to do anything to earn my love.  Remember the results of whatever work I have given you to do is in my hands not yours!

# Next
Doug Father's day card.
Install vscode-server, php, laravel, and extensions for each language.
https://code.visualstudio.com/docs/remote/tunnels#_using-the-code-cli
https://code.visualstudio.com/docs/remote/linux
https://pkg.go.dev/github.com/denisenkom/go-mssqldb
https://hevodata.com/learn/golang-mssql/
https://linux.how2shout.com/install-code-server-for-vs-code-on-ubuntu-22-04-or-20-04-lts/
https://code.visualstudio.com/blogs/2022/07/07/vscode-server
https://code.visualstudio.com/docs/remote/vscode-server#_quick-start
https://github.com/microsoft/vscode-remote-release
https://code.visualstudio.com/docs/remote/vscode-server
https://code.visualstudio.com/docs/remote/wsl
Create the reporting dev container from the Ubuntu Jammy Base dev container image and adding all the software from the reporting dockerfile. 

Good morning dear ones,
I hope you all had a very pleasant Father's day weekend my friends and I look forward to working with each of you this week!  May we all have the courage to face every challenge as it comes our way and the hope to carry on through every rough and difficult patch we face.
As always please feel free to contact me at work or home for any reason :-)

Sincerely yours,
Brent
260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.   
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.
# Microsoft SQL Server
## Does JDBC support SSL connections?
**[JDBC and SSL](https://www.google.com/search?q=does+jdbc+use+ssl&oq=does+jdbc+use+ssl&aqs=chrome..69i57.6655j0j9&sourceid=chrome&ie=UTF-8)**
"Support for SSL/TLS is not mandated in the JDBC specification. So you cannot expect it in every driver."
## Does Microsoft SQL Server JDBC driver support SSL connections?
**[Microsoft SQL Server driver and SSL](https://learn.microsoft.com/en-us/sql/connect/jdbc/understanding-ssl-support?view=sql-server-ver16)**
yes. Here are the connection string properties for it:
encrypt = false or blank
trustServerCertificate = any
hostNameInCertificate = any
trustStore = any
trustStorePassword = any

## How do we get the newer versions of the Microsoft SQL Server ODBC driver to work with our local databases?
The newer releases of OpenSSL defaults to using a more secure connection which means you must change some parameters in the openssl.cnf file and in the connection string. 
From a StackOverflow question:
"When SQL Server gets installed it is configured with a self-signed X.509 certificate. If you want to use encrypted connections (with Encrypt=yes; in the connection string, which is the default now) you'll either need to 1) get the X.509 certificate's public key from the server and add it to your trusted certificate store on the client or 2) use the TrustServerCertificate=yes; setting in your connection string."
In addition to adding TrustServerCertificate=yes; to the connection string I had to lower the default security level from 2 to 0.
```
sudo nvim /etc/ssl/openssl.cnf
[system_default_sect]
# CipherString = DEFAULT:@SECLEVEL=2
CipherString = DEFAULT:@SECLEVEL=0
```
# Reports dev container
Still working on creating a reports dev container with the following build and debug tools included.
## Python
The Python runner relies on shell scripts to launch each Python ETL script of the TB report. It uses the standard Linux mail utility and our Mobex SMTP server to send mail. It updates both our cloud-based Azure and local MySQL data warehouses.
## GoLang
The golang runner is an update to the Python runner with a different way of doing the same task.  Instead of calling individual golang ETL scripts of the TB report from bash scripts they are called from a main golang function as individual functions. In addition to updating our cloud-based Azure data warehouse, it also updates a Postgres database. Postgres has its roots in Berkeley University and has both clustering support and **[vector search](https://www.postgresql.org/docs/current/datatype-textsearch.html)** capabilities.  It is the database chosen by the implementor of the **[Hockeypuck GPG key server](https://hockeypuck.io/)** and the one I intend to use for customer report encryption. The public GPG key servers throughout the world are meant to store everyone's public encryption key so the speedy tsvector search data type of the Postgres database is ideal for this task.
## Java
I started using Java for our ETL scripts to compare ODBC to JDBC after a breaking change to connections to local databases using the Microsoft SQL Server ODBC driver involving new versions of SSL.  Since then the solution to accessing local Microsoft SQL servers with the default self-signed SSL certificate has presented itself and is actually a good thing.  
There are many Java build tools such as Apache Maven, Gradle, Apache Ant with ivy, and Scala SBT, but I wanted to keep the Java build process simple, so we are just using the tools that are included with the compiler, javac, and jar, to build our ETL scripts.
## Compile a simple query for each database
```
javac -d . JdbcCribmaster.java -cp ~/src/linux-utils/java/mobex/jdbc
javac -d . JdbcToolBoss.java -cp ~/src/linux-utils/java/mobex/jdbc
javac -d . JdbcMySqlDW.java -cp ~/src/linux-utils/java/mobex/jdbc
javac -d . JdbcAzureDW.java -cp ~/src/linux-utils/java/mobex/jdbc
javac -d . JdbcToolListJtds.java -cp ~/src/linux-utils/java/mobex/jdbc
## compile ETL test
javac -d . JdbcRestrictionsToDW.java -cp ~/src/linux-utils/java/mobex/jdbc
## compile Main class to call each test method  
javac -d . JdbcMain.java -cp ~/src/linux-utils/java/mobex/jdbc
# we can just run it
java -cp ./mssql-jdbc-11.2.0.jre11.jar:./jtds-1.3.1.jar:./mysql-connector-j-8.0.31.jar:. mobex.jdbc/JdbcMain
# or we can create a jar file to run
jar cvfm JdbcMain.jar server-connection-manifest.txt mobex/jdbc/*.class
# run app from jar file
java -jar JdbcMain.jar
```
## PHP debug
Working on this next.  I'm going to first attempt to get the customer reporting request to work with PHP and if necessary switch to using Request.js with Laravel.
## Laravel debug
After PHP work on adding this to the debug container.  Laravel is a PHP framework that is very popular and comes with many useful production-quality utility functions for writing a web application.  It also comes with a CLI and modern dev container features.  It can also be used with libraries such as Vue.js and React.js if you want to take advantage of features common to SPA such as:
**[PHP vs SPA](https://logic1.co.nz/spa-vs-php-based-websites/)**
- There is no reloading of the page once it has one, which creates a more streamlined User Experience (UX). This is because no extra pages need to load (browser and server communicating back and forth), which can create greater wait times.
- It’s great for community-focused sites where preferences can alter which content appears first—this tends to be User Generated Content (UGC).
- It tends to have much faster loading speeds.
- SPA’s work well with pages that incorporate many filters or a large number of products, such as large e-commerce stores.
The page only populates when a user loads the page, which again is beneficial to the site's speed as all the information needed has already been downloaded.


# How has development changed with dev containers?
In the past I have ran the TB reporting pipeline on my local development system and then containerized and deployed it to Kubernetes.  Thanks to the vscode remote development extension we are now we are able to develop and debug the reporting software in docker instead of just relying on logging to detect issues.

## More advantages
- Once we have created a dev container for the reporting software the entire team benefits and can pull the dev contonainer just as easily as they would pull the source code. So everyone can start programming without having to go through the consuming task of building a development system with all of the drivers, compilers, and tools needed.  

- The source code you check into GitHub or Azure DevOPs not only has your source code but also has docker files with enough information to allow VS Code to set up a complete development environment including cache, database, and web server containers for your application to interact with.

- In addition Microsoft has created a reference specification for a devcontainer and CI CLI. These tools use the docker API to containerize the development environment as well as perform CI tasks of any kind such as building, testing, and publishing a web app.  It works by allowing you to start a Microsoft or open-source code server service in the main docker dev container and using its protocal to perform coding, testing, or any other CI task from the dev container CLI, VIM, or a web-based IDE. 

# How can we automate CI tasks such as building and testing with development containers?
## Run build
devcontainer up --id-label ${id_label} --workspace-folder ../workspace
devcontainer exec --id-label ${id_label} --workspace-folder ../workspace scripts/execute-app-build.sh
build_exit_code=$?
## Clean up. 
echo "\nCleaning up..."
docker rm -f $(docker ps -aq --filter label=${id_label})
exit ${build_exit_code}

# Is development containers limited to CI tasks?
No its not in fact the devcontainer CLI is not needed because it just calls the docker CLI. With the dev container CLI, whatever cron job you want run can be containerized without installing anything on the server except for docker. 
# Can other IDE use dev containers?
Yes there is an implimentation of the dev container CLI for Vim and **[gitpod is running a forked version](https://github.com/gitpod-io/openvscode-server)**.  


# Research Activity
## How to run a dev container app from the command line?
devcontainer up --workspace-folder .  # creates the docker images from the config files in the .devcontainer project folder.
devcontainer exec --workspace-folder . cargo run  # this builds and runs the launch.json cargo configuration.
So we can start with a bare development system or VM and install git, docker, and the dev container CLI, pull our dev container, and then with just 2 commands we can run our program from docker containers. We can also use the dev container CLI to automate building code, running tests (CI), and deploying a new version of the application (CD) # **[CI/CD](https://code.visualstudio.com/docs/devcontainers/devcontainer-cli#_automation)** 
 

# Test a more complex development container running a database server.
So far the development containers I modified only ran only one container.  I thought it best to test a more complex scenario before jumping into the reports UI development container. The dev container I chose runs a Postgres database server in addition to the main development containers.  The goal is to create a simple golang program to insert data into postgres database from this dev container.

I chose to study the GoLang and Postgres dev container template because it is a good example of a complex development system requiring multiple docker images controlled by docker compose.  To this image I will attempt to access the docker and kubernetes config files running on the local host.