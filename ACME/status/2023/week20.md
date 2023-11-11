
I love you my dear ones. May we see the need to care for each other every day as our first priority!
I love you my son and I am always with you and have a plan for everyone today! 
Thank you Father for the plan you have for us all today!
I love all people and creation and would like you to love people and everything in creation like I do my son.


# start here
https://stackoverflow.com/questions/23927561/how-to-debug-laravel-framework
- try to run unit feathers nodejs app from ubuntu and docker
- create a simple reactjs app for testing of http server portion of docker unit.
- try to create docker image with all 3 language units
- create volume and init-volume to copy python, php, feathers nodejs, and reactjs source code to www-react, www-python,www-php, and www-nodejs directories.
- try to run multi-lang unit docker image with mounted source volume from aks k8s.
- try to connect to mysql from php lavarel framework.
- Install ingress with lets encrypt

https://stackify.com/php-debugging-guide/
https://paiza.io/projects/8WFzDA_9grobzvSEM3y27g
run-unit-php.md
how to use --unix-socket and curl to upload a config file
https://www.youtube.com/watch?v=L7uvDF1EruI
work with nginx-unit to support docker.
https://hub.docker.com/_/php
https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/how-to/create-tab-pages/content-page?tabs=teamsjs-v2
Use TeamsJS to interact with Teams
The Teams client JavaScript library provides many more functions that you can find useful while developing your content page.

Good morning dear ones,
Why is a good team so nice to be a part of? Isn't because it helps us to accomplish amazing things that would have been too difficult for us to have accomplished alone! Well maybe that's part of it and maybe the other part is we have good friends to share our struggles and burdens to help us endure our hardships and to somehow make them seem much lighter :-)
I wanted to thank everyone for your patient, humble, and caring attitudes that surely make this a very nice team to be a part of, and I hope each of you had a very pleasant Mother's day weekend!
As always please feel free to contact me at home or work about anything :-)
Sincerely yours,
Brent
260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.   
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# Details
## Nginx Unit our Application Server
### What is a Reverse Proxy? 
"Putting an HTTP server in front of a CGI or a WSGI server is called a “reverse proxy.”  It is needed for scaling and distributing network requests amoung multiple processes so as not to bog down the HTTP server."
### Difficulties containerizing reverse proxies
An HTTP server with Reverse Proxy capabilites such a Nginx not Nginx Unit requires three main processes and several worker processes to be able to handle a large number of network requests efficiently.
Docker and K8s works best when only 1 main process is being managed per container so we have to use something a shell script or a program like ScheduleD to launch and monitor multiple processes instead of dockers API or kubernetes own scheduler to do it. 
### Why should we use Nginx Unit as opposed to the regular version of Nginx as our reverse proxy?
"Configuring Nginx to be a CGI or WSGI application server requires the running of multiple programs. This is not good for containerized applications which recommends the running of just one application so that the container or orchestration system can monitor and scale that one application effectively. To address this issue the Nginx team created Nginx Unit which can be configured using a RESTful API for many languages such as GO, Rust, Python, and PHP. Since our reports UI will be ran from Azure AKS I thought it best to switch from Nginx to Nginx Unit."
### Scaling to run more processes
Here, Unit runs 20 processes of a PHP app called blogs, stored in the /www/blogs/scripts/ directory:

{
    "blogs": {
        "type": "php",
        "processes": 20,
        "root": "/www/blogs/scripts/"
    }
}
### What will Nginx Unit be used for?
It will be the reverse proxy used to scale and direct network traffic to the following web services:
- The [laravel PHP framework](https://laravel.com/) based Reports UI which gathers reports parameters from the customers and inserts a request in the report runner queue.
- A Feathers Node.js based RESTFul API built with the Feather.js framework.
- A Python WSGI based RESTFul API which uses the Flask framework.
### Why is a good framework so important?
I think it's the same reason that a good team is so important because we can accomplish more fantastic things than we ever could have alone by leveraging the time spent by other engineers to develop amazing libraries for us to use :-)
## Nginx our Ingress Controller
This application from the Nginx team was defined to be used in a k8s environment.  K8s comes with its own ingress system but it is difficult to use so I thought the Nginx Ingress Controller would be a better choice to handle TLS/SSL termination and automated certificate management.

## PHP
From the 90s and renders dynamic web content entirely on the server.  It is very easy to use and quick to deploy and still a very popular alternative to SPA for simple applications.
[PHP Frameworks](https://kinsta.com/blog/php-frameworks/)
"According to W3Techs, PHP is used by around 79% of all websites. It’s eight times more popular than ASP.NET, its nearest rival in server-side programming languages."


### composer
Spent some time learning the PHP package management system since I am using PHP as the learning and test platform for Nginx. 
### PHP Unit
Spent time familiarizing myself with this PHP unit testing system since Nginx regualar expression tester uses it instead of using the CGI configuration module to process PHP.

## React.js
This is my choice of frameworks for modern web apps which rely on AJAX to call web services instead of recreating the entire web page every time a user submission to the web server is made.
It is more complicated to work with than CGI programs but makes modern SPA possible.  
[Calling Web Services from HTML5](https://www.geeksforgeeks.org/how-to-call-web-services-in-html5/)
"
Procedure for calling the Web Services: Calling of web services can be done using the in-built web API’s and the browser provides you two different API’s which are:

XMLHttpRequest: XMLHTTPRequest object is an API that is used for fetching data from the server. It is basically used in Ajax programming. It retrieves any type of data such as JSON, XML, text, etc. It requests data in the background and updates the page without reloading the page on the client side.
Fetch API: The Fetch API provides the fetch() method defined on a window object. This is used to perform requests. This method returns a Promise which can be further used to retrieve the response to the request. 
The concept on which web services can be called from HTML is called AJAX (Asynchronous XML and Javascript), which was introduced in the year 2005 by Jesse James Garrett. Using this we can update our HTML structure without any page load. This makes an HTTP request to the web service without blocking the DOM.
"
# Research Activities
# [WSGI vrs CGI](https://stackoverflow.com/questions/4929626/what-are-wsgi-and-cgi-in-plain-english)
##  WSGI
[Flask a WSGI application](https://flask.palletsprojects.com/en/2.3.x/deploying/#:~:text=Flask%20is%20a%20WSGI%20application,WSGI%20responses%20to%20HTTP%20responses.)
"Flask is a WSGI application. A WSGI server is used to run the application, converting incoming HTTP requests to the standard WSGI environ, and converting outgoing WSGI responses to HTTP responses.
WSGI servers have HTTP servers built-in. However, a dedicated HTTP server may be safer, more efficient, or more capable. Putting an HTTP server in front of the WSGI server is called a “reverse proxy.”
## CGI
[CGI Interface](https://en.wikipedia.org/wiki/Common_Gateway_Interface)
"In computing, Common Gateway Interface (CGI) is an interface specification that enables web servers to execute an external program, typically to process user requests.[1]

Such programs are often written in a scripting language and are commonly referred to as CGI scripts, but they may include compiled programs.[2]

A typical use case occurs when a web user submits a web form on a web page that uses CGI. The form's data is sent to the web server within an HTTP request with a URL denoting a CGI script. The web server then launches the CGI script in a new computer process, passing the form data to it. The output of the CGI script, usually in the form of HTML, is returned by the script to the Web server, and the server relays it back to the browser as its response to the browser's request.[3]

Developed in the early 1990s, CGI was the earliest common method available that allowed a web page to be interactive."

# Learning
[What is a database transaction](https://www.tutorialspoint.com/sql/sql-transactions.htm)
"ensures that all operations within the work unit are completed successfully. Otherwise, the transaction is aborted at the point of failure and all the previous operations are rolled back to their former state."
In other words it is a database [symaphore](https://en.wikipedia.org/wiki/Semaphore_(programming))
"In computer science, a semaphore is a variable or abstract data type used to control access to a common resource by multiple threads and avoid critical section problems in a concurrent system such as a multitasking operating system."
[What is an identity column](https://en.wikipedia.org/wiki/Identity_column)
"An identity column is a column (also known as a field) in a database table that is made up of values generated by the database. 
...Because the concept is so important in database science, many RDBMS systems implement some type of generated key, although each has its own terminology. Today a popular technique for generating identity is to generate a random UUID."
