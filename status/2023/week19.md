Thank you Father for the plan that you have for our lifes today :-)
Thank you Father for helping us to adjust from relaxing and enjoing the weekend to working and helping each other during the week.
Your good attitudes Are we not very fortunate to have a good job, our health, and good people to work with today. May we continue to encourage one another and build meaningful relationships as we start to do the work in front of us this week.

Start Here:
look at linux-utils/Azure/Teams/Tabs for some notes.
https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/how-to/create-personal-tab?pivots=node-java-script
How do we create a web app that can be accessed from a Microsoft Teams tab?
Is there an advantage of using the Microsoft Teams JavaScript library?
https://ngrok.com/docs/
creates a HTTPS endpoint for the reports Teams app for localhost testing purposes using a tunneling service. 
pushd ~/src/linux-utils/nginx/docker-php/run-docker 
- continue documenting the nginx/conf.d/server.conf 
https://regex101.com/r/uD9ysi/1
Tutorial uses bootstrap
https://www.simplilearn.com/tutorials/php-tutorial/php-crud-operations
https://www.tutorialrepublic.com/php-tutorial/php-mysql-crud-application.php
[tabs for Teams](https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/what-are-tabs)
Tabs are Teams-aware webpages embedded in Microsoft Teams. They're simple HTML <iframe/> tags that point to domains declared in the app manifest and can be added as part of a channel inside a team, group chat, or personal app for an individual user. You can include custom tabs with your app to embed your own web content in Teams or add Teams-specific functionality to your web content.

Study and give an example of an nginx configuration file with virtual servers, location routing, and load balancing.
https://www.php.net/manual/en/mysqli.quickstart.stored-procedures.php
https://www.w3schools.com/php/php_mysql_connect.asp
https://www.php.net/manual/en/function.sqlsrv-connect.php
https://learn.microsoft.com/en-us/sql/connect/php/microsoft-php-drivers-for-sql-server-support-matrix?view=sql-server-ver16#supported-operating-systems

Good morning dear ones,
May we all find the strength to transition from relaxing and enjoying the weekend to working and helping each other in our everyday tasks! Thank each of you for being considerate and kind and patient with me and with one another. I consider myself very fortunate to be working with each one of you and thank you for being a great group to work with :-)
As always please feel free to contact me at work or at home for anything and whenever you please!


# Big Picture:
1. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
2. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.
3. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases.  

# The Details
## Reports UI
It's purpose will be retrieve the report name and parameters such as email address, period range, and output format from the customer and insert a request into the reports queue for the report runner to process them one at a time.
### Testing 
#### Programming Language
For testing and proof of concept I'm using a simple CGI program for the UI.
CGI Programs:
- Very simple HTML intersperced with PHP directives
- Works by processing PHP files and passing query parameters for those PHP files in the URI.
- Nginx parses the URI, matches the PHP file extension and passes the file with parameters using the CGI protocal to the PHP service which processes the file and returns the results back to the Nginx web server which passes the response back to the user agent.
#### CSS library
For testing we can use a straight CSS library to display controls on our web pages.
[Bootstrap](https://getbootstrap.com/docs/3.4/css/)
### Exercises:
Study and give an example of an Nginx configuration file with virtual servers, location routing, load balancing, and PHP scripting.
- php scripting
- URI mappings
- load balancing
- database connections
- ssl/tls termination

### Production
#### Programming Language
[React.JS](https://react.dev/) 
"React is a free and open-source front-end JavaScript library for building user interfaces based on components. It is maintained by Meta and a community of individual developers and companies. React can be used to develop single-page, mobile, or server-rendered applications with frameworks like Next.js"
#### CSS library
[MaterialUI](https://mui.com/material-ui/customization/how-to-customize/)
"Material UI is a library of React UI components that implements Google's Material Design."
#### Rest API Framework
[FeathersJS](https://feathersjs.com/)
"FeathersJS is a JavaScript framework used for highly-responsiveness real-time apps."

## tabs for Teams
teams website tab
https://learn.microsoft.com/en-us/samples/officedev/microsoft-teams-sample-todo/microsoft-teams-todo-list-sample-tab-app/
https://www.oleanschools.org/cms/lib/NY19000263/Centricity/Domain/671/How%20to%20add%20a%20website%20tab%20in%20Microsoft%20Teams.pdf
[tabs for Teams](https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/what-are-tabs)
Tabs are Teams-aware webpages embedded in Microsoft Teams. They're simple HTML <iframe/> tags that point to domains declared in the app manifest and can be added as part of a channel inside a team, group chat, or personal app for an individual user. You can include custom tabs with your app to embed your own web content in Teams or add Teams-specific functionality to your web content.
[use case scenario](https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/what-are-tabs#tabs-user-scenarios)
[Visual Studio Code tool kit](https://learn.microsoft.com/en-us/microsoftteams/platform/toolkit/teams-toolkit-fundamentals?pivots=visual-studio-code) 

## Material Inventory report
Set: 1 line for each part with a raw, wip, or finished part.
raw part number, quantity, wip part numbers with quantity list, and finished goods part numbers with quantities list,
extension: material requirement 2 weeks.
Check it:
1. Find existing Plex inventory reports or web services.
2. Compare a few part quantities from our report to Plex on a Saturday or when CNC isn't running.
Similar Plex Reports:
Inventory tracking with filters like scrap.
MRP tells you how much raw to complete firmed, scheduled, and forecasted requirements, and it does take into consideration how much WIP and finished goods you have.
Exercises:
1. Create a set mapping part numbers to raw.
2. Curl script to call MRP web service.
3. Convert XML to JSON and use jq utility to query the result set.
4. Make mrp-query shell script using jq.
Enhancement: Add material requirements for each part.

## OpenPGP key server
Use this key server to store each customers' RSA public key but do not use the hkp protocol to retrieve them instead directly query the Postgres SQL server and use its ts_vector search capabilites.
## Nginx:
Directs traffic with the help of Perl compatible regular expression.
It can be configured as a load balancer to pass network traffic to several web services.
Before deploying nginx to Azure aks as our ingress controller know how to configure it for load balancing, database connections, ssl/tls terminations, and URI mappings.
I believe the key to successfully working with nginx is to understand how to create a configuration file to route network traffic the way you want it routed.  To help learn how to configure nginx to suite our purposes you can read the very good documentation at the nginx website. You also can use a combination of the following resources: 
- [nginx-regex-tester](https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-regex-tester) 
- [docker file of the nginx-regex-tester](https://github.com/jonlabelle/docker-nginx-regex-tester)
- [another nginx regular expression test site](https://nginx.viraptor.info/) 
- [regex101]](https://regex101.com/).
## PHP CGI compatible programming language:
[what is php](https://www.php.net/manual/en/intro-whatis.php)
To verify that I have configured nginx correctly I needed a way to display the server name or IP on an HTML page or an HTML response if using curl.  After searching the internet it seemed clear that php can do this task and that it is a great language to use for server-side HTML preprocessing and database requests.
I think it would be difficult to find a better language than php to create the simple UI needed to ask for report paramters and insert a report request into the report runner queue.


# The weeds
## How to change a request for a file in the /download/anydir/media/ 
## directory to the /download/anydir/mp3/ directory using PCRE and the nginx rewrite directive.
[nginx regex testing](https://regex101.com/r/85MrzN/1)

server {
    ...
    rewrite ^(/download/.*)/media/(.*)\..*$ $1/mp3/$2.mp3 last;
    rewrite ^(/download/.*)/audio/(.*)\..*$ $1/mp3/$2.ra  last;
    return  403;
    ...
}

request URI: /download/anydir/media/test.mp3
$1 = /download/anydir
$2 = test
$1/mp3/$2.mp3
rewritten URI: /download/anydir/mp3/test.mp3

## How to safely ensure downloaded software is from the legitamate author and has not been changed 
https://askubuntu.com/questions/131397/what-is-a-repository-key-under-ubuntu-and-how-do-they-work
I believe this is generally how the process works. if you got a package in your repository and you want others to be able to download it and also give them the ability to make sure the package comes from you and the content has not been changed then you can add your public key to a public key-server and then do the following.

Hash the package content
Encrypt the hash with your private key. (sign it)
Add the signature to the download package.
Then the user does the following:
downloads the package from your repository.
decrypts the signature with your public key.
hashes the download package minus the signature.
compares the hash to the decrypted signature. If they match then you can be sure that the package has not been changed and is from the repository owner. This process relies on OpenPGP key servers and standard hashing and encryption algorithms.

## How to list all records in a DNS Name Server
- https://tweenpath.net/list-all-dns-records-from-a-nameserver-using-nslookup/
List all DNS records from a Nameserver using nslookup
 MARCH 27, 2017 BY RUMI
Method-1)
How to list all records below some domain name.
Usually it’s done from interactive nslookup mode, not from batch mode
nslookup - alb-ad01.busche-cnc.com 
>set q=any
>ls -d busche-cnc.com
listing may be prohibited by administrator or by firewall settings, in that case you get empty output or ‘not implemented’ errors.
Method-2
nslookup 
server 10.1.2.69
10.1.3.80
- For searching records in DNS you could use 3 tools - nslookup, dig, and Resove-DNSName (newer). Look at A, PTR and SRV records relating to former domain controller.
https://learn.microsoft.com/en-us/answers/questions/65182/how-to-find-all-possible-dns-records-for-a-server


## MSC VM software architecture.
- datbase usage
- reporting software

## list IP addresses only
hostname -I
