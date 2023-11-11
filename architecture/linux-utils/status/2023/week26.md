I will help you my son in everything you do because I love you and am always there for you!  My plan is for you to help people and to show them you care about each one.  This is what I want for you to love and care for others.  By growing in love for others you will be helping to make this world a better place.  Do not be anxious for anything but look to me for direction.  Do not worry about the future and do not worry about the past.  Instead look to me because I have a plan for your good and the good of all people.  Trust me my son because I love you and will always take good care of you and everyone!

Thank you Father for helping us to be couragous in uncertain times.  These times our not uncertain my son since I have ordained what is to happen each and everyday. You can be certain there is a purpose to every situation and you can trust me for all of your needs because I love you.
I love you no matter what you do or say.  You don't have to be perfect and you don't have to do anything to earn my love.  Remember the results of whatever work I have given you to do is in my hands not yours!
# Next
Add php, laravel, java, go directories to dev container.
verify vscode debugging works for each language.
Transform all TB python ETL scripts to a single go program.
Good morning my dear ones,
I hope you all had a pleasant weekend and you have renewed strength to start the week. If I can be of any assistance to you please feel free to call me at home or work for whatever reason. I would like to take this oppurtunity to wish each of you and joy filled 4th of July and to let you know that appreciate each one of you and the priviledge to be a part of this group :-)

-Sincerely yours,
Brent
260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.   
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# Dev Container
## Status
Tested the dev container dockerfile which uses the Ubuntu 22.04 LTS base image and installs Plex ODBC drivers, Python, Java, and Go tools.
- created a com.mobex.etl java package and tested building and debugging.
- transfered to the dev container volume the existing python and bash trial balance ETL scripts 
- changed the OpenSSL config file and the connection strings to local SQL Server databases with self-signed certificates so that they work with the new versions of SSL that is the default with Ubuntu 22.04.
## Golang & Postgres
Docker and Kubernetes are made with Go programming language and there is also a go client API that is very useful for interacting with a Kubernetes cluster.  The idea is to keep the bash and Python ETL scripts but to test the idea of using Go ETL modules that can be called by a main function instead of bash scripts.
**[10 features that set it apart](https://itnext.io/10-features-of-go-that-set-it-apart-from-other-languages-89337e5ee551)**
1. Go always includes the binary in builds
2. Go has no centrally hosted service for program dependencies
3. Go is call-by-value
4. The ‘defer’ keyword
5. Go adopts the best features of functional programming
6. Go has implicit interfaces
7. Error handling
8. Concurrency
"Arguably Go’s most famous feature, concurrency allows processing to be run in parallel over the number of available cores on the machine or server.
It is a compiled language and a modern update to C with features such as memory management"
9. The Go Standard Library
Go has a ‘batteries included’ philosophy, and many requirements of a modern programming language are baked into the standard library, which makes programmers’ lives much simpler.
10. Debugging: the Go Playground
11. Decentralized publishing
In Go, you publish your module by tagging its code in your repository to make it available for other developers to use. You don’t need to push your module to a centralized service because Go tools can download your module directly from your repository (located using the module’s path, which is a URL with the scheme omitted) or from a proxy server.

**[Postgres features](https://arctype.com/blog/postgresql-features-list/)**
Our Hockeypuck open-source Public key server use Postgres because of its full-text search capabilities.
1. Inheritance
2. Non-Atomic Columns
3. Window functions
PostgreSQL window functions play an important role in making them a favorite for analytics applications. Window functions help users to execute functions spanning over multiple rows and return the same number of rows. Window functions are different from the aggregate functions in the sense that the latter can only return a single row after aggregation.
4. Support for JSON Data
5. Full-text Search
But PostgreSQL’s full-text search goes one step above what LIKE provides. To do a complete search using the LIKE query for a word, you will need to use elaborate regex expressions. On the other hand, PostgreSQL's full-text feature will even allow searching based on the root words or lexeme. 
6. PostgreSQL has native support for using SSL connections to encrypt client/server communications for increased security.
7. **[Kubernetes kubegres operator](https://www.kubegres.io/)**
Kubegres is an open-source Kubernetes operator allowing to deploy a cluster of PostgreSql instances with data replication enabled out-of-the box. It brings simplicity when using PostgreSql considering how complex managing stateful-set's life-cycle and data replication could be with Kubernetes.



# Research Activities:
## Can we connect to Plex database with a regular Microsoft ODBC driver?

https://learn.microsoft.com/en-us/visualstudio/bridge/bridge-to-kubernetes-vs-code
Bridge to Kubernetes is an iterative development tool for authoring microservice applications that target Kubernetes. The Bridge to Kubernetes extension is available for Visual Studio and Visual Studio Code (VS Code).