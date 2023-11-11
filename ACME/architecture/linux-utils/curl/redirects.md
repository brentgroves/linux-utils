# if it is a real redirect status code 302
curl -L http://moto.busche-cnc.com
# if the srv uses the hsts protocol
https://everything.curl.dev/http/hsts
HTTP Strict Transport Security, HSTS, is a protocol mechanism that helps to protect HTTPS servers against man-in-the-middle attacks such as protocol downgrade attacks and cookie hijacking. It allows an HTTPS server to declare that clients should automatically interact with this host name using only HTTPS connections going forward - and explicitly not use clear text protocols with it.

curl -v --hsts hsts.txt https://frt-kors43.busche-cnc.com
curl -v --hsts hsts.txt http://frt-kors43.busche-cnc.com
