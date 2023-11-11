Thank you Father for teaching me to believe in your love for us all. Remember my son when you are weak I am strong and my love does not depend on your performance.  I love you because you are my son and you spend much time with me not because of what you are able to do!

Good morning dear ones,
I hope you had a good weekend and our enjoying your work today :-) If I can be of any help please don't hesitate to call at work or at home!

-Sincerely yours,
Brent
260-564-4868

Ask Sam for name of Edon Mach2 server:


# Report System Version 1
Going to deploy this to Nutanix K8s cluster and have asked for an IT person interested in administoring a Kubernetes Cluster.
- Only 1 table to hold the result set.
- 1 set of tables to hold intermediate result sets.
- Scripts are in Bash and Python.
- Cron job starts ETL scripts.
- Working on Node.js REST API to run scripts from Curl.
- React.js app to allow custumers to request reports parameters include email address.
- Once customer is identified display a screen with a list of reports they can run much like Plex all reports screen.
- Go program monitors request table and launches main report ETL scripts.
- Result set includes date/time ran field to show in the report.
- An excel file is created from the report result set and emailed to the customer.
- Can view the report from Power BI or React.js which displays the date/time the ETL scripts were ran.  


# Report System Version 2
This is designed to be scalable.
- There are multiple worker databases since any report run blocks other reports from being ran until completions.
- Cron jobs ensure the source tables needed for each report are uptodate as much as possible.
- Go threads are each assigned to each worker database. The number of worker databases is scalable.
- Report runs are archived and can be used for regular reports, diff reports, or emailing excel files of past reports.

# Mobex PKI 
Niagara certificates:
- deployed to frt-kors43.busche-cnc.com 
- thinking about testing a host only alt name field along with the FQDN but don't think Chrome's linter will like this.
- Have processes to add intermediate and root CA certificates for:
    + using Windows cert manager mmc.
    + using cert utility to update Linux NSS databases for Chrome.
    + Chromes own security settings in Windows and Linux
    + Debian/Ubuntu utility to update the certificate store used by utilities such as curl and openssl.

## OAuth compliant web application
How does our reports API and Web App known who is requesting reports?
Ok PKI certificates trusted by our work envirnonment is the way we ensure clients know who they are talking to but how does the servers know who the clients are?  The standard to do that is OAuth.
There are over 180 OAuth servers on every major platform.  There goal is to ensure Web and API servers know for sure who they are talking to.  The work flow that consists of a redirect to a commonly known OAuth server URL with a callback address known to the OAuth server through information given by an Administrator of web app credentials on a platform such as Azure AD. This process uses client ids and secrets in case of more secure apps or public/private keys the same as that used by PKI certificates for more secure communications.
# Reports Authentication Flow
Through the browser
User clicks Login
Gets redirected to the Microsoft OAuth provider and authorizes the application
Callback to the OauthStrategy which
Gets the users profile
Finds or creates the user (entity) for that profile
The AuthenticationService creates an access token for that entity
Redirects back to the origin URL including the generated access token
The frontend (e.g. the Feathers authentication client) uses the returned access token to authenticate

# Research Activities
## OpenID Connect
**[OpenID Connect](https://openid.net/developers/how-connect-works/)**
"
What is OpenID Connect
OpenID Connect is an interoperable authentication protocol based on the OAuth 2.0 framework of specifications (IETF RFC 6749 and 6750). It simplifies the way to verify the identity of users based on the authentication performed by an Authorization Server and to obtain user profile information in an interoperable and REST-like manner.

OpenID Connect enables application and website developers to launch sign-in flows and receive verifiable assertions about users across Web-based, mobile, and JavaScript clients. And the specification suite is extensible to support a range of optional features such as encryption of identity data, discovery of OpenID Providers, and session logout.

For developers, it provides a secure and verifiable answer to the question “What is the identity of the person currently using the browser or mobile app that is connected?” Best of all, it removes the responsibility of setting, storing, and managing passwords which is frequently associated with credential-based data breaches.
"

## JWT
**[JWT](https://jwt.io/introduction)**
"
How do JSON Web Tokens work?
In authentication, when the user successfully logs in using their credentials, a JSON Web Token will be returned.
Whenever the user wants to access a protected route or resource, the user agent should send the JWT
The server's protected routes will check for a valid JWT in the Authorization header, and if it's present, the user will be allowed to access protected resources.
Some servers don't accept more than 8 KB in headers. If you are trying to embed too much information in a JWT token, like by including all the user's permissions, you may need an alternative solution, like Auth0 Fine-Grained Authorization.
How is it used?

1. The application or client requests authorization to the authorization server. This is performed through one of the different authorization flows. For example, a typical OpenID Connect compliant web application will go through the /oauth/authorize endpoint using the authorization code flow.

2. When the authorization is granted, the authorization server returns an access token to the application.
The application uses the access token to access a protected resource (like an API).

"
## Why typescript?
**[Why use typescript](https://www.typescripttutorial.net/typescript-tutorial/why-typescript/)**
"Summary
JavaScript is dynamically typed. It offers flexibility but also creates many problems.
TypeScript adds an optional type system to JavaScript to solve these problems.
"
Will use typescript in the reports API for a test.
If that works out I might change the React.js app to typescript.

## Following Mach2 redirects
# if it is a real redirect status code 302
curl -L http://frt-kors43.busche-cnc.com
# if the srv uses the hsts protocol
https://everything.curl.dev/http/hsts
HTTP Strict Transport Security, HSTS, is a protocol mechanism that helps to protect HTTPS servers against man-in-the-middle attacks such as protocol downgrade attacks and cookie hijacking. It allows an HTTPS server to declare that clients should automatically interact with this host name using only HTTPS connections going forward - and explicitly not use clear text protocols with it.
curl -v --hsts hsts.txt https://frt-kors43.busche-cnc.com
curl -v --hsts hsts.txt http://frt-kors43.busche-cnc.com

## Is Python written in C
"C is a fundamental language because many popular languages like Python, C++, Java are built with the C language as their base. It is a very powerful language that provides many data types and operators and gives a platform for all kinds of operations."

## Memory Segmentation faults
**[segmentation faults](https://en.wikipedia.org/wiki/Segmentation_fault)**
"a segmentation fault (often shortened to segfault) or access violation is a fault, or failure condition, raised by hardware with memory protection, notifying an operating system (OS) the software has attempted to access a restricted area of memory (a memory access violation). On standard x86 computers, this is a form of general protection fault. The operating system kernel will, in response, usually perform some corrective action, generally passing the fault on to the offending process by sending the process a signal. Processes can in some cases install a custom signal handler, allowing them to recover on their own,[1] but otherwise the OS default signal handler is used, generally causing abnormal termination of the process (a program crash), and sometimes a core dump."
**[python segmentation faults](https://stackoverflow.com/questions/10035541/what-causes-a-python-segmentation-fault)**
"I understand you've solved your issue, but for others reading this thread, here is the answer: you have to increase the stack that your operating system allocates for the python process.

The way to do it, is operating system dependant. In linux, you can check with the command ulimit -s your current value and you can increase it with ulimit -s <new_value>

Try doubling the previous value and continue doubling if it does not work, until you find one that does or run out of memory.
Segmentation fault is a generic one, there are many possible reasons for this:

Low memory
Faulty Ram memory
Fetching a huge data set from the db using a query (if the size of fetched data is more than swap mem)
wrong query / buggy code
having long loop (multiple recursion)
"

