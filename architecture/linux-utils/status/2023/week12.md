We love you my son!
And I you my Father!
Good morning my Friends,
I hope you all had a very pleasant weekend and look forward to working with each of you this week.
Please feel free to contact me at work or home for any reason.
-Sincerely yours
Brent
260-564-4868

Ngrok:
https://ngrok.com/docs/
creates a HTTPS endpoint for the reports Teams app for localhost testing purposes using a tunneling service. 

Lets Encrypt:
https://letsekubectl delete pod reports-mongodb-0 ncrypt.org/how-it-works/
From the website:
"The objective of Let’s Encrypt and the ACME protocol is to make it possible to set up an HTTPS server and have it automatically obtain a browser-trusted certificate, without any human intervention. This is accomplished by running a certificate management agent on the web server."

reports TLS ingress controller:
mobex-ingress.centralus.cloudapp.azure.com
advanges: 
- don't need to add records to our zone.
- user does not enter URL it is embedded in an app package that is uploaded to Teams.
- ingress controller uses regex and each path points to a different service, ie. https://mobex-ingress.centralus.cloudapp.azure.com/report-scheduler, https://mobex-ingress.centralus.cloudapp.azure.com/report-list 

Azure 
- Deployed aks to Mobex Azure tenant.
- Tested building Teams App on personal Azure account.
- To build a team app you must have a HTTPS url not one that is locally signed.
- Does GoDaddy still host our domain? https://learn.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns
"You can use Azure DNS to host your DNS domain and manage your DNS records. By hosting your domains in Azure, you can manage your DNS records by using the same credentials, APIs, tools, and billing as your other Azure services."

Reports
Generate a run report teams tab.
- select report and params 
- returns a report id for a Power BI paginated report Teams tab.

AKS Meeting:
To discuss some report options.

Request:
Link Azure Kubernetes services,AKS, to Azure container registry using AAD 
export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports
# Attach using acr-name 
az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr $ACRNAME
