https://security.stackexchange.com/questions/49229/root-certificate-key-usage-non-self-signed-end-entity

https://docs.apigee.com/how-to-guides/validating-certificate-purpose

Recommended key usage and extended key usages for certificates used in Apigee Edge
Purpose	Key usage
(mandatory)

Extended key usage
(optional)
If you like this tool, you may be interested in checking out my new site https://pkiaas.io. 

Server entity certificate used in Apigee Edge keystore of virtual host	
Digital signature
Key encipherment or key agreement
TLS Web server authentication
Client entity certificate used in Apigee Edge truststore of virtual host	
Digital signature or key agreement
TLS Web client authentication
Server entity certificate used in Apigee Edge truststore of target server	
Digital signature
Key encipherment or key agreement
TLS Web server authentication
Client entity certificate used in Apigee Edge keystore of target server	
Digital signature or key agreement
TLS Web client authentication
Intermediate and root certificates	
Certificate sign
Certificate revocation list (CRL) sign
