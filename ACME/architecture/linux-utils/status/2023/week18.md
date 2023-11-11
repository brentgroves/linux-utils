Good morning dear ones,
I hope you are doing well and have peace and joy in abundance to endure any hardships that come our way this week. I would also like you to know that I feel very fortunate to know and work with each one of you and consider this to be a great group to be a part of!  As always feel free to contact me at any time at work or at home :-)
- Sincerely yours
Brent
260-564-4868

Big Picture:
1. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
2. Give the option to our report customers to encrypt reports containing sensitive data. This requires key pairs for cipher algorithms such as RSA or ECDSA. In our case we have a nonsycronizing private hockeypuck OpenPGP key server to manage these keys.
3. Answer business questions using our databases.  

The details:
Name: Material Inventory report
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

Nginx
Nginx is used for our k8s ingress controller and a web server for a simple UI to interact with our Hockeypuck key server.  Seems important enough to study it some and learn how to configure it better.
[Nginx configuration files](https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/)
Features of Nginx
1. It uses Perl regular expressions syntax to route network traffic to web services.  
2. It can be configured to listen to HTTP traffic on ports and IP addresses.
3. It supports multiple FQDN on one instance if you have multiple host entries for the same IP.
4. Supports directing TCP and UDP traffic as well as HTTP which makes it great for a K8s ingress controller.


Curl and HTTP:
Learning to configure Nginx led me to the IETF documentation for the HTTP protocol so I could better understand how the Nginx configuration files can be made to manipulate network traffic. It also seemed good to me to examine how the curl network utility can be used to test if my configuration file works.  

Curl and Plex SOAP requests:
There are several GUI programs to make testing SOAP and REST API easier but to more fully understand HTTP it seemed better to use a simple command line utility to work with the Plex API.
Curl syntax to make a Plex web service call:
curl --insecure --location --request POST 'https://api.plexonline.com/DataSource/Service.asmx' \
--header 'SOAPAction: http://www.plexus-online.com/DataSource/ExecuteDataSource' \
--header "Authorization: Ask me for this line" \
--header 'Content-Type: text/xml; charset=utf-8' \
--data-raw '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:dat="http://www.plexus-online.com/DataSource">  <soapenv:Header/>
   <soapenv:Body>
      <dat:ExecuteDataSource>
         <!--Optional:-->
         <dat:ExecuteDataSourceRequest>
            <!--Optional:-->
            <dat:DataSourceKey>2912</dat:DataSourceKey>
            <!--Optional:-->
            <dat:InputParameters>
               <!--Zero or more repetitions:-->
             </dat:InputParameters>
            <!--Optional:-->
            <dat:DataSourceName>?</dat:DataSourceName>
            <!--Optional:-->
            <dat:DataBase>?</dat:DataBase>
         </dat:ExecuteDataSourceRequest>
      </dat:ExecuteDataSource>
   </soapenv:Body>
</soapenv:Envelope>' | xmllint --format - > result.xml
Notes:
1. xmllint just puts the output in a nice format so everything from the pipe onward can be omitted.
2. the authorization line is 'Authorization: Basic ' plus the base64 encoded version of our username: password including the colon.

Below are a few links that were helpful in learning:
[HTTP message exchange](https://www.rfc-editor.org/rfc/rfc9110.html#name-example-message-exchange)
[curl cookbook](https://catonmat.net/cookbooks/curl)
[Nginx proxy_pass](https://dev.to/danielkun/nginx-everything-about-proxypass-2ona)
[debugging HTTP requests with curl](https://catonmat.net/cookbooks/curl/debug-curl-requests)

The weeds:
Regular Expressions:
A PCRE regular expression library is used by Nginx to match URI so network traffic can be manipulated and routed as needed. In order to understand the regular expression protocol better I thought it was a good idea to take some time to study its usage.
[Perl Compatible Regular Expressions](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions#:~:text=Perl%20Compatible%20Regular%20Expressions%20(PCRE,writing%20PCRE%20in%20summer%201997.):
'''
Perl Compatible Regular Expressions (PCRE) is a library written in C, which implements a regular expression engine, inspired by the capabilities of the Perl programming language. Philip Hazel started writing PCRE in the summer of 1997.[3] PCRE's syntax is much more powerful and flexible than either of the POSIX regular expression flavors (BRE, ERE)[4] and than that of many other regular-expression libraries.

While PCRE originally aimed at feature equivalence with Perl, the two implementations are not fully equivalent. During the PCRE 7.x and Perl 5.9.x phase, the two projects coordinated development, with features being ported between them in both directions.[5]
'''
[Creates nginx configuration files from a given URI](https://www.nginx.com/blog/regular-expression-tester-nginx/)
[docker image for nginx regular expression testor](https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-regex-tester)
[nginx location testor](https://nginx.viraptor.info/)
[another regex site](https://regex101.com/)
[generic tester for specific use cases](https://www.regextester.com/94055)
[Regular expression syntax summary](http://www.greenend.org.uk/rjk/tech/regexp.html)
[Comparison of regular expression engines](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines)
[Online tool to evaluate a regular expression by language](https://www.regexplanet.com/)
- Nginx uses PCRE.
