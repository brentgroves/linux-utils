https://chromium.googlesource.com/chromium/src/+/main/net/data/ssl/chrome_root_store/faq.md
172.20.0.41
ERR_CERT_COMMON_NAME_INVALID
https://kinsta.com/knowledgebase/net-err_cert_common_name_invalid/

What Is the NET::ERR_CERT_COMMON_NAME_INVALID Error?
The NET::ERR_CERT_COMMON_NAME_INVALID error happens when the browser fails to verify a website’s SSL certificate and is therefore unable to establish a secure connection. This issue usually occurs due to misconfiguration of the certificate on a server.

Before we dive into what causes the NET::ERR_CERT_COMMON_NAME_INVALID error, let’s break down the relevant terms. The ‘common name’ this error references is the domain on which an SSL certificate is installed.

For example, if you have a website at mydomain.com, the common name on your SSL certificate would be mydomain.com. So as the error message states, the root problem behind NET::ERR_CERT_COMMON_NAME_INVALID is that the common name on your SSL certificate is not valid for some reason.

Often, this means that the name on your certificate does not match the domain it’s installed on. However, there are other scenarios that could lead to this message appearing in your browser, including:

Your SSL certificate does not account for www versus non-www variations of your domain.
You tried to switch your website to HTTPS without first installing an SSL certificate.
Your site has a self-signed SSL certificate installed and your browser does not recognize it as valid or secure.
Your antivirus software is blocking your SSL connection.
A browser extension is interfering with your site’s SSL connection.
Your proxy settings are misconfigured.
Your browser cache or SSL state has become corrupted.
As you can see, many different factors can contribute to the NET::ERR_CERT_COMMON_NAME_INVALID error. This can make it hard to pin down the correct solution, but a little patience will go a long way towards helping you fix the problem.

This server could not prove that it is frt-kors43.busche-cnc.com; its security certificate does not specify Subject Alternative Names. This may be caused by a misconfiguration or an attacker intercepting your connection.

https://stackoverflow.com/questions/75034737/what-are-the-new-requirements-for-certificates-in-chrome

Chrome now rejects TLS certificates containing a variable known as pathLenConstraint or sometimes displayed as Path Length Constraint.

I was using certificates issued by Microsoft Active Directory Certificate Services. The Basic Constraints extension was enabled, and the AD CS incorrectly injects the Path length Constraint=0 for end entity, non-CA certificates in this configuration.

The solution is to issue certificates without Basic Constraints. Chrome is equally happy with Basic Constraints on or off, so long as the path length variable is not present.

One of the better resources for troubleshooting was this Certificate Linter:

https://crt.sh/lintcert

It found several errors in the server certificate, including the path length set to zero.

I also found a thread discussing a variety of Certificate Authorities that would issue certificates the same way, so it is a fairly common issue.

https://github.com/pyca/cryptography/issues/3856

Another good resource was the smallstep open source project that I installed as an alternative CA. After generating a generic certificate, the invalid cert error went away and I realized there was something going on between the Microsoft and Google programs.



