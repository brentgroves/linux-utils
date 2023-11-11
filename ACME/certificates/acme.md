https://www.keyfactor.com/blog/what-is-acme-protocol-and-how-does-it-work/
The Internet Security Research Group (ISRG) initially designed the ACME protocol for its own certificate service, Let’s Encrypt, a free and open certificate authority (CA) that provides domain validated (DV) certificates at no charge. Today, various other CAs, PKI vendors, and browsers support ACME to support different types of certificates.
ACME Versions
The first iteration of the ACME protocol, ACME v1, was released in 2016 and initially only supported the issuance of certificates for only one domain. However, the updated ACME v2, released in 2018, now supports the issuance of wildcard certificates. It also includes security improvements to better verify domain ownership and prevent malicious actors from obtaining ACME-issued certificates.

In 2019, the IETF standardized the ACME protocol in RFC8555, and many clients have since developed support for the protocol. ACME v2 is not backwards compatible with v1, which will be deprecated entirely in June 2021.

How does the protocol work?
By leveraging ACME, organizations can streamline and automate otherwise time-consuming processes, such as CSR generation, domain ownership verification, certificate issuance, and installation.

ACME is primarily used to obtain domain validated (DV) certificates. This is because DV certificates do not require advanced verification. Only the existence of the domain is validated, which requires no human intervention.

The protocol can also be used to obtain higher-value certificates, such as organization validated (OV) and extended validation (EV), but these cases require additional support mechanisms alongside the ACME agent.

The objective of the ACME protocol is to set up an HTTPS server and automate the provisioning of trusted certificates and eliminate any error-prone manual transactions. To use the protocol, an ACME client and ACME server are needed, which communicate with JSON messages over a secure HTTPS connection.

The client runs on any server or device that requires a trusted SSL/TLS certificate. It is used to request certificate management actions, such as issuance or revocation.
The server runs at a Certificate Authority (CA), like Let’s Encrypt, and respond to the requests of authorized clients.
 

There are many different ACME client implementations available for the protocol. It is designed to allow businesses to choose the CA they want, as long as the CA supports ACME.

Let’s Encrypt recommends using the certbot client, because it’s easy to use, it works on many operating systems, and it has helpful documentation. Other popular ACME clients can be found on GitHub, such as ACMESharp, acme-client, GetSSL, and many others.

Revocation: to revoke a certificate, the agent signs the revocation request with the authorized key pair for the domain, and the CA validates the request. The CA then publishes the revocation information through CRLs or OCSP to prevent the acceptance of the revoked certificate.

How is the ACME protocol used?
In the 2021 State of Machine Identity Management Report, 40% of respondents revealed that their organizations still use spreadsheets to manually track certificates. On average, these organizations experienced roughly three unexpected outages caused by expired or misconfigured certificates within two years.

Despite the increasing use of modern, agile computing environments, many businesses continue to deploy and manage certificates using outdated techniques which are not adequate to meet the increased demands of today’s fast-paced environments. The manual management of certificates in spreadsheets or databases introduces inefficiency and risk of outage or non-compliance due to human error.

That’s exactly what the ACME protocol documentation highlights: “Existing Web PKI certification authorities tend to use a set of ad hoc protocols for certificate issuance and identity verification. These ad hoc procedures are accomplished by getting the human user to follow interactive natural-language instructions from the CA rather than by machine-implemented published protocols. In many cases, the instructions are difficult to follow and cause significant frustration and confusion.”

https://certbot.eff.org/