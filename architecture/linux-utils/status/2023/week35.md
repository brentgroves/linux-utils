Never fear my son because I am always with you and will help you to endure each trial that I allow you to go through.

Good morning dear ones,
I hope you had an excellant weekend and that you and your loved ones are doing fine! As always please feel free to call me at work or at home for whatever you need.
-Sincerely yours
Brent
260-564-4868

# MTBF
- Collect data using GO into PostGres database on reports5 k8s cluster.
- Perform long running query to determine MTBF for Albion PCN workstations.
- Transfer MTBF result set to Azure DW.
- Create PHP-reports and Power BI teams based report.
https://golangdocs.com/golang-postgresql-example
https://blog.logrocket.com/using-sql-database-golang/
https://levelup.gitconnected.com/golang-soap-based-services-ccc4b3e3ee2e

# Busche Reporter
Migration plan:
Upload to Azure and Local data warehouses and duplicate the Busche reporter reports.

# report system
- Finished the stand-alone Apache2 web server installation document including instructions to generate and install our end-entity, intermediate, and root certificates created in our PKI.

- Finished the docker image of Apache2 web server and will add it to our development container.
- Work on the scripts to the MTBF report
- Work on adding the PHP module to the Apache2 web server to run PHP reports.
git@github.com:brentgroves/unit-php8.2.git
- Tested the frt-kors4.busche-cnc.com end entity certificate as well as our intermediate and root certificates on Ubuntu and Windows.
https://php.watch/articles/install-php82-ubuntu-debian
https://www.tutorialspoint.com/php/php_apache_configuration.htm
https://hub.docker.com/_/php
https://hub.docker.com/_/httpd

# Research Activities
- how to make a report using php
**[PHP reports](https://jdorn.github.io/php-reports/)**
https://reintech.io/blog/a-comprehensive-guide-to-php-pdo-library-for-database-access
https://www.koolreport.com/

# Niagara update
We have a valid server certificate that passes all Chromes tests but we need to get Niagara to recongnize it.  To do that we need to use the Niagara certificate manager to generate a certificate and export it's private key and send it to me.
https://support.onesight.solutions/kb/faq.php?id=45
The Niagara certificate manager is very particular with how the full chain of trust is imported. What must happen is as follows:
1. Generate a certificate in Niagara certificate manager
2. Export the private key and keep it safe. This is a .PEM file.
3. Create a signing request based on the newly created certificate.
