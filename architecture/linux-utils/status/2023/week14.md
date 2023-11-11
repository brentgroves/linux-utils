Good morning dear ones,
Hope you and your family are doing well! Mine are having some health issues but they are all still hanging there.  I also just wanted to say the it is so very nice to be working with a group of guys that are as considerate of one another as this team is :-)  Thank you all for that!
-Sincerely yours,
Brent
260-564-4868

"What is the Ingress?
The Ingress is a Kubernetes resource that lets you configure an HTTP load balancer for applications running on Kubernetes, represented by one or more Services. Such a load balancer is necessary to deliver those applications to clients outside of the Kubernetes cluster."

What protocols does it support?  Usually ingress is just for http, but nginx supports TCP, for MySQL, and UDP making Moxa data collection possible from the cloud.

more nginx details:
https://www.nginx.com/blog/inside-nginx-how-we-designed-for-performance-scale/
https://docs.nginx.com/nginx-ingress-controller/

Why is Kubernetes written in the Go language?
Kubernetes was developed by Google using Go
Chat gpt, bard, openia, bing ai, 

HTTPS needed:
Microsoft teams requires software running in a team tabs to have a secured connection. We can do this by configuring the ingress controller to use TLS certificates. 

What CA should we use?  Is "Let's Encrypt" good enough although it's free? I can't say, but Azure describes its installation in there AKS ingress documentation. 

Let's Encrypt uses the ACME protocol to verify a domain programmatically by proving that the customer has control over it.
How does it do that? It uses one of the ACME agents such as certbot, https://certbot.eff.org/, to add temp links to your site.

Why is ACME a better way to manage certificates? 
- Businesses manage certificates using spreadsheets and they forget to renew them.
- ACME makes choosing a backup CA easy since there are many CA that support this protocol.

NGINX k8s ingress-controller, IC:
Have one of these that maps different services to the reports FQDN using different paths such as:
reports-ingress.centralus.cloudapp.azure.com/tb-scheduler ( customer schedules a TB report by entering the period range )
reports-ingress.centralus.cloudapp.azure.com/tb-list ( lists the report id, dates, and period ranges of all TB reports which have ran )
reports-ingress.centralus.cloudapp.azure.com/tb-viewer ( this is just a Power BI paginated report that takes a report id parameter )
It also uses a k8s certificate manager to support HTTPS connections allowing each of these UI to be ran in a single function Microsoft Teams tab.
Because the of the IC chosen, both UDP and TCP pass-through is supported giving us endpoints for non-http traffic such as:
reports-ingress.centralus.cloudapp.azure.com/mysql (tcp)
reports-ingress.centralus.cloudapp.azure.com/moxa (udp)

IT Question:
It would be possible to freely run tb-scheduler and tb-list on our utanix hosted k8s cluster.
But we would need to create a firewall rule that allows TCP and UDP traffic on ports 80/443 and directs it to the reports host, A record, or the reports.mobexglobal.com zone. 
The TLS certificates would be free and managed by "Let's Encrypt" CA and a backup CA that both use the ACME certificate automation protocol.





