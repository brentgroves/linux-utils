Agenda:
Hi Sam and Matthew,
I would like to have a short meeting to discuss the error messages I am seeing when I try to connect to frt-kors43 from various browsers.

Error message:
Edge: Have not checked.
Chrome: This server could not prove that it is frt-kors43.busche-cnc.com; its security certificate does not specify Subject Alternative Names. This may be caused by a misconfiguration or an attacker intercepting your connection.
FireFox: Error code: SSL_ERROR_BAD_CERT_DOMAIN

What is RVB 8?
**[certificate linter](https://crt.sh/lintcert)**
**[New requirements for certificates](https://stackoverflow.com/questions/75034737/what-are-the-new-requirements-for-certificates-in-chrome)**

# Notes
**[SAN SSL](https://geekflare.com/san-ssl-certificate/)**
Browsers that require HTTPS with SAN
•Chrome from version 58. It also requires that the certificate must have the Subject Alternative Name field (SAN).
•Edge
**[How to generate a certificate with SANs](https://help.bizagi.com/bpm-suite/en/index.html?subjectaltname_support.htm)**
Certificate for Development and Test environments
For the development or test environment, you can either used purchased certificates (if you already have), signed certificates by a CA, or you can use self-signed certificates. If you use self-signed certificates it is important that the certificate has the Subject Alternative Name field (SAN).


