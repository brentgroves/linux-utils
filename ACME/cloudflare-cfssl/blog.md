https://blog.cloudflare.com/introducing-cfssl/

How CFSSL Makes Certificate Bundling Easier
If you are running a website (or perhaps some other TLS-based service) and need to install a certificate, CFSSL can create the certificate bundle for you. Start with the following command:

$ cfssl bundle -cert mycert.crt