http://www.pkiglobe.org/

The basic constraint is an X.509 certificate v3 extension. This extension describes whether the certificate is a CA certificate or an end entity certificate.

In the certificate shown above, basic constraints extension is selected and the Subject Type = CA means it is CA certificate.

In the above certificate, the Subject Type = End Entity shows that it is an end entity certificate.

If the certificate is a v3 certificate and the basic constraint extension is not present then it will be an end entity certificate.

The path length constraint is only applicable to CA certificates. It has nothing to do with the end entity certificates. Path length gives the maximum number of non-self-issued intermediate certificates that may follow this certificate in a valid certification path.

In the above certificate chain, the certificate at (1) specifies a path length constraint 2 that means there could be at max 2 CA certificates down in the hierarchy of this certificate excluding the end entity certificate. This condition evaluates to true because there are two certificates down in the hierarchy of certificate (1) i.e. certificate (2) and (3). Certificate (4) is not included in this constraint because it is an end entity certificate.

