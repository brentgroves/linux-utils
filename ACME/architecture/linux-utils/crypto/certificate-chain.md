https://knowledge.digicert.com/solution/SO16297.html
certificate chain

What is a Certificate Chain?

A certificate chain is an ordered list of certificates, containing an SSL/TLS Certificate and Certificate Authority (CA) Certificates, that enable the receiver to verify that the sender and all CA's are trustworthy. 
The chain or path begins with the SSL/TLS certificate, and each certificate in the chain is signed by the entity identified by the next certificate in the chain.

What is an Intermediate Certificate?
Any certificate that sits between the SSL/TLS Certificate and the Root Certificate is called a chain or Intermediate Certificate. 
The Intermediate Certificate is the signer/issuer of the SSL/TLS Certificate. 
The Root CA Certificate is the signer/issuer of the Intermediate Certificate. 
If the Intermediate Certificate is not installed on the server (where the SSL/TLS certificate is installed) it may prevent some browsers, mobile devices, applications, etc. from trusting the SSL/TLS certificate. 
In order to make the SSL/TLS certificate compatible with all clients, it is necessary that the Intermediate Certificate be installed.
 

What is the Root CA Certificate?

The chain terminates with a Root CA Certificate. The Root CA Certificate is always signed by the CA itself. The signatures of all certificates in the chain must be verified up to the Root CA Certificate.

DN - A name given to a person, company or element within a computer system or network that uniquely identifies it from everything else.


(ca chain)[https://knowledge.digicert.com/content/dam/digicertknowledgebase/library/VERISIGN/ALL_OTHER/Eduardo/Figure_Chain.jpg])

The chain of trust is below. You can search the web on that topic, but the typical order in the master PEM file to be imported into Niagara is- 
 https://www.niagara-community.com/s/article/Importing-a-PEM-file-using-Workbench
Private Key
You export the private key from the certificate you created using the Workbench Certificate Manager tool. Make sure to export the key in an unencrypted format.
The private key is the first entry of the master PEM file you are creating.
The private key is optional when importing a certificate created by the Niagara Certificate Manager and signed using Workbench Certificate Signer Tool.
Primary Certificate
This is the signed certificate that was signed using Workbench Signer Tool or received back from the signing authority. You have either signed your certificate with a CA created using Workbench Certificate Manager, or you have a signed certificate that was signed by a signing authority using the signing request sent to them.
Intermediate Certificate
If using intermediate certificates.
If using a signing authority that has intermediate certificates, they would send them with the primary certificate that they signed.
Root Certificate
This was used to sign the Primary Certificate
Note that you may need to export the Signing Authority CA from the Workbench Trust Store and include that CA as the last certificate in the master PEM. This can be the case if you are using a customer’s certificate and nothing was generated using Niagara and all is being supplied from an external source.
If you sent a signing request to a signing authority the resulting PEM they returned usually contains everything needed except your private key. You would receive back a PEM that contained the signed certificate, any intermediate certificates and the Signing Authority’s root CA. Add your private key at the top of this file and import into Niagara User Key Store.  
