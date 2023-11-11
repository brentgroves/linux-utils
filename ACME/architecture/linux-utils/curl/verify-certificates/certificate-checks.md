pushd /home/brent/src/linux-utils/crypto/certificates/sam_v1
curl --verbose https://frt-kors43.busche-cnc.com
# notice
There is a pem file containing all of the trusted CA certificates.
CAfile: /home/brent/anaconda3/ssl/cacert.pem
curl (27) out of memory


curl --verbose --cacert ./CA_certificate.crt https://frt-kors43:443
*   Trying 172.20.0.41:443...
* Connected to frt-kors43 (172.20.0.41) port 443 (#0)
* ALPN: offers h2
* ALPN: offers http/1.1
*  CAfile: ./CA_certificate.crt
*  CApath: none
* [CONN-0-0][CF-SSL] TLSv1.3 (OUT), TLS handshake, Client hello (1):
* [CONN-0-0][CF-SSL] TLSv1.3 (IN), TLS handshake, Server hello (2):
* [CONN-0-0][CF-SSL] TLSv1.2 (IN), TLS handshake, Certificate (11):
* [CONN-0-0][CF-SSL] TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* [CONN-0-0][CF-SSL] TLSv1.2 (IN), TLS handshake, Server finished (14):
* [CONN-0-0][CF-SSL] TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* [CONN-0-0][CF-SSL] TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* [CONN-0-0][CF-SSL] TLSv1.2 (OUT), TLS handshake, Finished (20):
* [CONN-0-0][CF-SSL] TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* ALPN: server did not agree on a protocol. Uses default.
* Server certificate:
*  subject: C=US; ST=Michigan; L=Fruitport; O=Mobex GLobal; OU=IS; CN=FRT-KORS43
*  start date: Jul 25 19:24:50 2023 GMT
*  expire date: Aug 25 19:24:50 2024 GMT
*  common name: FRT-KORS43 (matched)
*  issuer: C=US; ST=Indiana; L=Albion; O=Mobex Global; OU=Information Systems; CN=devcon2; emailAddress=bgroves@mobexglobal.com
*  SSL certificate verify ok.
> GET / HTTP/1.1
> Host: frt-kors43
> User-Agent: curl/7.87.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 302 Found
< Strict-Transport-Security: max-age=15552000
< Location: https://frt-kors43/ord
< Content-Length: 0
< 
* Connection #0 to host frt-kors43 left intact
