Thank you my son for hanging in there through the trouble that you are having and trusting me to help you through it!
Father please help me and give me courage to enjoy the work you have given me to do! Please help us all to have courage to follow your direction and leading without fear !!
Please help me to stay aware of you all throughout the day and to stop for directions all of the time!
May we thoughtfully work together through each problem taking one step at a time with hope and in humility and carefully consider if what we are doing may accidentally offend someone.
May we be able to enjoy working through the most difficult of issues and find joy in the longest of trials knowing that we are not alone.
May we find the strength to endure our hardships by encouraging and helping each other in any way that we are able!
My dear ones, may we each find a good balance between work and home by spending time wisely enjoying what we do without neglecting those who count on us for support, guidance, and encouragement :-)
Good morning my dear ones,
I hope you are all doing well this week and look forward to working with each of you.  We are very fortunate to have such a wonderful team to be a part of and I feel privilidged to be a part of it! May we enjoy working through the most difficult of issues and find joy in the longest of trials knowing we have are part of a great team and able to help other over each hurdle. May we find great satisfaction and enjoyment this week as we work together to tackle the most difficult of assignments. 

Good luck to each of you as we start out this week doing what we hopefully love doing!
As always please feel free to contact me at work or at home about anything at all :-)
-Sincerely yours
Brent 
260-564-4868
https://www.youtube.com/watch?v=iHad9TH9mOA
https://stackoverflow.com/questions/23927561/how-to-debug-laravel-framework
# laravel sail debug
Thank you for giving us courage when facing hard and long physical problems as well as very difficult problems at work.
The issue is php artisan server can not connect to the host port 9003 that dbgpClient is listening on and even if it can how will it be able to set breakpoints when the host source directories are mounted to volumes mounted to different folders. Should we use the remote debug extension to do this?
https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn
# todo list
- study laravel tutorial.
- deploy to nunit
- test Tinker REPL
- test Sail docker CLI
# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.   
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# Browser or curl user agent report network request flow and software stack
- Curl/Browser => AKS Nginx Ingress Controller => Nginx Unit Application server => Laravel Framework Application => PHP development / React.js production reports UI => Insert report request into queue to be processed by the report runner.

# Why Laravel framework?
- It is number one server side framework on github, 65,000 stars. 
- well documented and good community
- many third party and open source extensions 
- Has it's own:
  - REPL environment - like python
  - Docker CLI development environment (App is created and developed with the same Laravel CLI on Windows WSL2, Mac, or Linux with one curl command)
  - Cron task scheduling system
- Integrates well with React.js
[React.js and PHP](https://laravel.com/docs/10.x/starter-kits#breeze-and-inertia)
"Laravel Breeze also offers React and Vue scaffolding via an Inertia frontend implementation. Inertia allows you to build modern, single-page React and Vue applications using classic server-side routing and controllers. Inertia lets you enjoy the frontend power of React and Vue combined with the incredible backend productivity of Laravel lightning-fast Vite compilation. "

# Setup PHP and the Laravel framework.
I decided to use the Ondrej PPA repository for installing PHP because you can easily install and switch between different versions of PHP and its extension by using apt.
# Debug PHP and Laravel.
Before getting to far building the Report UI I figured it was a good idea spending some time learning how to debug it.  To debug I installed the PHP [xdebug](https://xdebug.org/) extension on Ubuntu, Chrome, and in VSCode. Here is a list of xdebug highlights. 
- [uses the dbgp protocol](https://xdebug.org/docs/dbgp#description)
- xdebug makes a connection to VSCode, then waits for it to initiate commands.
- VSCode negotiates features using the feature_get and feature_set commands, and sets any additional data, such as breakpoints. 
- xdebug to VSCode and VSCode to xdebug communications on ports 9000 and 9003.
- xdebug supports typical [debugging commands](https://xdebug.org/docs/dbgp#core-commands) as defined by the DBGP protocol such as run,step_into,step_over,step_out,stop,and detach.
Sample interaction:
VSCode - run -i transaction_id
xdebug -
<response xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug"
          command="run"
          transaction_id="transaction_id"
          status="break"
          reason="ok">
    <xdebug:message filename="file://bug01312.inc" lineno="26"/>
</response>

# Research Activities
## client vrs server rendering
What happens when a user updates form data and presses the submit button?
### server side rendering
an http request is sent to the web server and the entire web page is rerendered based upon parameters sent on the request's querystring or included in its body.
### client side rendering
an http request is sent to the web server to perform some specific computation such as a database transaction and the response data is returned to the user agent. The user agent then rerenders the page with the response data by calling javascript module functions.

## A background on modules
[ESMS Script modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)
Modern SPAs include hundreds or thousands of modules to run a web app. These modules include one or more related functions to perform a specific set of tasks. The modules are divided into optimally sized bundles when a app is built and delivered to the user agent when requested asyncronously.

## Why use the Vite development server
[Why Vite](https://vitejs.dev/guide/why.html)
"We are starting to hit a performance bottleneck for JavaScript based tooling: it can often take an unreasonably long wait (sometimes up to minutes!) to spin up a dev server, and even with Hot Module Replacement (HMR), file edits can take a couple of seconds to be reflected in the browser. The slow feedback loop can greatly affect developers' productivity and happiness.

Vite aims to address these issues by leveraging new advancements in the ecosystem: the availability of native ES modules in the browser, and the rise of JavaScript tools written in compile-to-native languages."


