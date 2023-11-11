Please guide and direct me on which one to do Father.
Good morning dear ones,

Please guide and direct me on which one to do Father.


# NEXT
https://thomas-leister.de/en/how-to-import-ca-root-certificate/
Finish ssl configuration https://hub.docker.com/_/httpd?tab=description
create certificates for home.
The conf/extra/httpd-ssl.conf configuration file will use the certificate files previously added and tell the daemon to also listen on port 443. Be sure to also add something like -p 443:443 to your docker run to forward the https port.
docker run --rm -ti -p80:80 --name 'httpd-test' brentgroves/httpd:1.0 /bin/bash
AH00526: Syntax error on line 144 of /usr/local/apache2/conf/extra/httpd-ssl.conf:
SSLCertificateFile: file '/usr/local/apache2/conf/server.crt' does not exist or is empty

Good morning dear ones,
I hope everyone is doing well and staying healthy. Thank you for all that you do to make this group pretty great to work with :-) As always please feel free to ask me anything at home or work.  Enjoy your week friends!

-Sincerely yours,
Brent
260-564-4868

# Busche Reporter
Migration plan:
Upload to Azure and Local data warehouses and duplicate the Busche reporter reports.

# Git submodules
Our development container has or is going to have several submodules such as one for our PKI, ETL scripts, Go code, etc.  So I addded a Git folder containing instructions for working with submodules in Git.

# Reports to work on
Name: Mean Time between Failures
Contact: Jake Kunkle
Plex references:
Goal: 15 business days.
Notes: This report requires long running queries so am working on mean_time_between_failures_dw SPROC to transfer the needed data sets to the DW.

Name: Mean Time to Repair
Contact: Jake Kunkle
Plex references:
Goal: 15 business days.

Name: critical supply items before minimum
Contact: pat baxter:
Plex references:
Item Ordering Screen
Goal: 10 business days.

Name: 
Contact: 
Plex references:
Goal: 

## Chrome more secure
**[MkCert](https://github.com/FiloSottile/mkcert)**
MkCert simple certificate creation tool no longer supports adding certificates to Chrome trust store database.
## NSS security database
- The SQL-lite based database is used now to manage certificates in a secure and standard across operating systems.
**[NSS database](https://manpages.ubuntu.com/manpages/xenial/en/man1/certutil.1.html#nss%20database%20types)**

## CertUtil
**[CertUtil](https://manpages.ubuntu.com/manpages/xenial/en/man1/certutil.1.html)**
The Public key database Tool, certutil, is a command-line utility that can create and modify certificate and key databases. This tool is becoming common place on Windows and Linux based systems.  There is separate NSS databases for both Firefox and Chrome on Linux systems. You can manage certificates either from Chrome:settings or using the cert util CLI. 

## Apache Web Server
**[Apache and SSL](https://httpd.apache.org/docs/2.4/ssl/)**
"The Apache HTTP Server module mod_ssl provides an interface to the OpenSSL library, which provides Strong Encryption using the Secure Sockets Layer and Transport Layer Security protocols."
- setup the Apache Web Server to use our PKI based x509v3 certificates.

# Jetty Niagara Web Server 
Does our OpenSSL generated x509v3 certificates in our new public key infrastructure and verified with Google's linter work?
- Create a docker image for the Jetty Web Server.
- Add the Jetty image to our development containers docker compose configuration file.
- Create a git submodule and add it to our development containers git repo.
- Create a Jetty configuration directory in our development containers volume directory.
- Mount the htdocs, Jetty configuration, and certs directory to the Jetty service in the docker compose configuration file. 
- Build, Run, and test this by using Chrome and browse to the Jetty server's URL using https.

# Research Activities
- how to make a report using php
**[PHP reports](https://jdorn.github.io/php-reports/)**