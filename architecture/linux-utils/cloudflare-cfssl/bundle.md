https://www.ekervhen.xyz/posts/private-ca-with-cfssl/#secure-the-root-ca-private-key
Looks like bundling just concatenates the root, itermediate, and tbs certificates together
Test the certificate on a web server
To see the newly issued certificate in action a quick nginx web server deployment can be performed.

For HTTPS to work you want the server to provide the full chain of trust up to the root CA. Which means that the certificate needs to be bundled with all intermediate certificates.

Make a full chain certificate with cfssl:
cfssl bundle -ca-bundle root/root-ca.pem \
  -int-bundle intermediate/intermediate-ca.pem \
  -cert certificates/my-webserver.pem \
| cfssljson -bare my-webserver-fullchain

NOTE: I had mixed results when running above command. On Debian 10 it would execute successfully but no fullchain certificate would be created.

Another way to generate a fullchain certificate is to run:

cat certificates/my-webserver.pem intermediate/intermediate-ca.pem \
certificates/my-webserver-fullchain.pem