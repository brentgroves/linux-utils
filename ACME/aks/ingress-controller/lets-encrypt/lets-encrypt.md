https://letsencrypt.org/
Let's Encrypt is a free, automated, and open certificate authority brought to you by the nonprofit Internet Security Research Group (ISRG).



To enable HTTPS on your website, you need to get a certificate (a type of file) from a Certificate Authority (CA). Let’s Encrypt is a CA. In order to get a certificate for your website’s domain from Let’s Encrypt, you have to demonstrate control over the domain. With Let’s Encrypt, you do this using software that uses the ACME protocol which typically runs on your web host.

To figure out what method will work best for you, you will need to know whether you have shell access (also known as SSH access) to your web host. If you manage your website entirely through a control panel like cPanel, Plesk, or WordPress, there’s a good chance you don’t have shell access. You can ask your hosting provider to be sure.

With Shell Access
We recommend that most people with shell access use the Certbot ACME client. It can automate certificate issuance and installation with no downtime. It also has expert modes for people who don’t want autoconfiguration. It’s easy to use, works on many operating systems, and has great documentation. Visit the Certbot site to get customized instructions for your operating system and web server.

If Certbot does not meet your needs, or you’d like to try something else, there are many more ACME clients to choose from. Once you’ve chosen ACME client software, see the documentation for that client to proceed.

If you’re experimenting with different ACME clients, use our staging environment to avoid hitting rate limits.

          Automatic Certificate Management Environment (ACME)

Abstract

   Public Key Infrastructure using X.509 (PKIX) certificates are used
   for a number of purposes, the most significant of which is the
   authentication of domain names.  Thus, certification authorities
   (CAs) in the Web PKI are trusted to verify that an applicant for a
   certificate legitimately represents the domain name(s) in the
   certificate.  As of this writing, this verification is done through a
   collection of ad hoc mechanisms.  This document describes a protocol
   that a CA and an applicant can use to automate the process of
   verification and certificate issuance.  The protocol also provides
   facilities for other certificate management functions, such as
   certificate revocation.

   https://certbot.eff.org/