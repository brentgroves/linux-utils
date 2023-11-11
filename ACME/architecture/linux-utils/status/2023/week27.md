Good morning my dear ones,
I hope you all had a pleasant weekend and have renewed strength to start the week. If I can be of any assistance to you please feel free to call me at home or work for whatever reason. I would like to take this opportunity to wish each of you and joy-filled 4th of July and to let you know that I appreciate each one of you and the privilege to be a part of this group :-)

-Sincerely yours,
Brent
260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.  
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-synchronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# Dev Container
## Status
Tested the dev container dockerfile which uses the Ubuntu 22.04 LTS base image and installs Plex ODBC drivers, Python, Java, and Go tools.
- created a com.mobex.etl java package and tested building and debugging.
- setup Apache Maven to build com.mobex.etl Java package
  What Is Apache Maven?
  Apache Maven is a free and open-source project management tool based on the Project Object Model (POM). Maven contains XML files or pom.xml, which include configuration details and project dependencies. Maven automates building, publishing, and deploying stages. It lets you work and manage several projects simultaneously.
- transferred to the dev container volume the existing python and bash trial balance ETL scripts
- changed the OpenSSL config file and the connection strings to local SQL Server databases with self-signed certificates so that they work with the new versions of SSL that is the default with Ubuntu 22.04.
## Golang & Postgres
Docker and Kubernetes are made with the Go programming language and there is also a Go client API that is very useful for interacting with a Kubernetes cluster.  The idea is to keep the bash and Python ETL scripts but to test the idea of using Go ETL modules that can be called by a main function instead of bash scripts.
**[10 features that set it apart](https://itnext.io/10-features-of-go-that-set-it-apart-from-other-languages-89337e5ee551)**
1. Go always includes the binary in builds
2. Go has no centrally hosted service for program dependencies like Java Maven repo, Node.js npm registry, or Python package index,Pip, or Conda package management.
3. Go is call-by-value to prevent common errors associated with pass-by-reference mutable parameters. 
4. The ‘defer’ keyword **[](https://www.digitalocean.com/community/tutorials/understanding-defer-in-go)**
"One of the primary uses of a defer statement is for cleaning up resources, such as open files, network connections, and database handles. When your program is finished with these resources, it’s important to close them to avoid exhausting the program’s limits and to allow other programs access to those resources. defer makes our code cleaner and less error prone by keeping the calls to close the file/resource in proximity to the open call."
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
PostgreSQL window functions are important in making them a favorite for analytics applications. Window functions help users to execute functions spanning over multiple rows and return the same number of rows. Window functions are different from aggregate functions in the sense that the latter can only return a single row after aggregation.
4. Support for JSON Data
5. Full-text Search
But PostgreSQL’s full-text search goes one step above what LIKE provides. To do a complete search using the LIKE query for a word, you will need to use elaborate regex expressions. On the other hand, PostgreSQL's full-text feature will even allow searching based on the root words or lexeme.
6. PostgreSQL has native support for using SSL connections to encrypt client/server communications for increased security.
7. **[Kubernetes kubegres operator](https://www.kubegres.io/)**
Kubegres is an open-source Kubernetes operator allowing to deployment a cluster of PostgreSQL instances with data replication enabled out-of-the-box. It brings simplicity when using PostgreSQL considering how complex managing a stateful set's life cycle and data replication could be with Kubernetes.

# research activities
## What do we use XML for
**[explaining xml](https://hbr.org/2000/07/explaining-xml)**
"markup language and file format for storing, transmitting, and reconstructing arbitrary data."
XML defines many sets of XML tags for different uses two such uses are for web services and the project object model.  
- Accessing Plex web services with SOAP which is an XML-based protocol for accessing web services over HTTP.
**[SOAP XML](https://www.w3schools.com/xml/xml_soap.asp)**
"Why SOAP?
It is important for web applications to be able to communicate over the Internet.
The best way to communicate between applications is over HTTP, because HTTP is supported by all Internet browsers and servers. SOAP was created to accomplish this.
SOAP provides a way to communicate between applications running on different operating systems, with different technologies and programming languages."
- Managing our Java reports project. 
**[Maven POM](https://www.javatpoint.com/maven-pom-xml)**
"POM is an acronym for Project Object Model. The pom.xml file contains information of project and configuration information for the maven to build the project such as dependencies, build directory, source directory, test source directory, plugin, goals etc."

Maven reads the pom.xml file, then executes the goal.
## Maven
**[Maven](https://maven.apache.org/)**
"Apache Maven is a software project management and comprehension tool. Based on the concept of a project object model (POM), Maven can manage a project's build, reporting and documentation from a central piece of information.

The following are the key features of Maven in a nutshell:

Simple project setup that follows best practices - get a new project or module started in seconds
Consistent usage across all projects - means no ramp up time for new developers coming onto a project
Superior dependency management including automatic updating, dependency closures (also known as transitive dependencies)
Able to easily work with multiple projects at the same time
A large and growing repository of libraries and metadata to use out of the box, and arrangements in place with the largest Open Source projects for real-time availability of their latest releases
Extensible, with the ability to easily write plugins in Java or scripting languages
Instant access to new features with little or no extra configuration
Ant tasks for dependency management and deployment outside of Maven
Model based builds: Maven is able to build any number of projects into predefined output types such as a JAR, WAR, or distribution based on metadata about the project, without the need to do any scripting in most cases.
Coherent site of project information: Using the same metadata as for the build process, Maven is able to generate a web site or PDF including any documentation you care to add, and adds to that standard reports about the state of development of the project. Examples of this information can be seen at the bottom of the left-hand navigation of this site under the "Project Information" and "Project Reports" submenus.
Release management and distribution publication: Without much additional configuration, Maven will integrate with your source control system (such as Subversion or Git) and manage the release of a project based on a certain tag. It can also publish this to a distribution location for use by other projects. Maven is able to publish individual outputs such as a JAR, an archive including other dependencies and documentation, or as a source distribution.
Dependency management: Maven encourages the use of a central repository of JARs and other dependencies. Maven comes with a mechanism that your project's clients can use to download any JARs required for building your project from a central JAR repository much like Perl's CPAN. This allows users of Maven to reuse JARs across projects and encourages communication between projects to ensure that backward compatibility issues are dealt with."

**[How to install JAR to local maven repo](https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html)**
"Occasionally, you will have 3rd party JARs that you need to put in your local repository for use in your builds, since they don't exist in any public repository like Maven Central. The JARs must be placed in the local repository in the correct place in order for it to be correctly picked up by Apache Maven.
To make this easier, and less error prone, we have provided an install-file goal in the maven-install-plugin which should make this relatively painless.
To install a JAR in the local repository use the following command:
mvn install:install-file -Dfile=<path-to-file> -DgroupId=<group-id> -DartifactId=<artifact-id> -Dversion=<version> -Dpackaging=<packaging>
If there's a pom-file as well, you can install it with the following command:
mvn install:install-file -Dfile=<path-to-file> -DpomFile=<path-to-pomfile>
With version 2.5 of the maven-install-plugin, it can get even simpler: if the JAR was built by Apache Maven, it'll contain a pom.xml in a subdirectory of the META-INF/ directory, which will be read by default. In that case, all you need to do is:
mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=<path-to-file>"
## POM
**[The POM](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html)**
"A Project Object Model or POM is the fundamental unit of work in Maven. It is an XML file that contains information about the project and configuration details used by Maven to build the project. It contains default values for most projects. Examples for this is the build directory, which is target; the source directory, which is src/main/java; the test source directory, which is src/test/java; and so on. When executing a task or goal, Maven looks for the POM in the current directory. It reads the POM, gets the needed configuration information, then executes the goal.

Some of the configuration that can be specified in the POM are the project dependencies, the plugins or goals that can be executed, the build profiles, and so on. Other information such as the project version, description, developers, mailing lists and such can also be specified."

## Window functions compared to aggregate functions
**[Window vs aggregate functions](https://learnsql.com/blog/window-functions-vs-aggregate-functions/)**
Aggregate functions operate on a set of values to return a single scalar value. 
In SQL, window functions operate on a set of rows called a window frame. They return a single value for each row from the underlying query.
Unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities.
