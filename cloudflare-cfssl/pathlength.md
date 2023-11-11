http://www.pkiglobe.org/

The path length constraint is only applicable to CA certificates. It has nothing to do with the end entity certificates. Path length gives the maximum number of non-self-issued intermediate certificates that may follow this certificate in a valid certification path.

In the above certificate chain, the certificate at (1) specifies a path length constraint 2 that means there could be at max 2 CA certificates down in the hierarchy of this certificate excluding the end entity certificate. This condition evaluates to true because there are two certificates down in the hierarchy of certificate (1) i.e. certificate (2) and (3). Certificate (4) is not included in this constraint because it is an end entity certificate.

Now start from certificate (2) which specifies the path length constraint 1. This condition also evaluates to true because there is only one CA certificate down in the hierarchy of this certificate i.e. (3) and entity certificate (4) do not come under this restriction.

At certificate (3), the path length constraint is 0 that means there must not be any CA certificate under this CA certificate. This condition also evaluates to true.

At certificate (4), the path length constraint restriction is not applicable as it is an end entity certificate.
https://security.stackexchange.com/questions/119577/should-openssl-verify-recognise-an-exceeded-path-length-constraint-on-a-root