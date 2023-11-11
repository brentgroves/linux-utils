https://codeahoy.com/general/curl-display-request-response-headers#:~:text=In%20default%20mode%2C%20curl%20doesn,beginning%20with%20%3E%20indicate%20request%20headers.

In default mode, curl doesn’t display request or response headers, only displaying the HTML contents.

To display both request and response headers, we can use the verbose mode curl -v or curl -verbose. In the resulting output:

The lines beginning with > indicate request headers.
The lines beginning with < indicate response headers.
(The lines beginning with * indicate additional information.)
Let’s try curl -v http://codeahoy.com to print request and response headers. In the image below, the request and response headers are highlighted.

curl -v http://codeahoy.com

*   Trying 2606:4700:3032::ac43:d1bc...
* TCP_NODELAY set
* Connected to codeahoy.com (2606:4700:3032::ac43:d1bc) port 80 (#0)
> GET / HTTP/1.1
> Host: codeahoy.com
> User-Agent: curl/7.64.1
> Accept: */*
> 
< HTTP/1.1 301 Moved Permanently
< Date: Sun, 22 Aug 2021 18:57:16 GMT
< Transfer-Encoding: chunked
< Connection: keep-alive
< Cache-Control: max-age=3600
< Expires: Sun, 22 Aug 2021 19:57:16 GMT
< Location: https://codeahoy.com/
< Report-To: {"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v3?s=s7X0EJLhIVF8i%2Bkkxxzl1URcpPF65SmKK%2BRthSOgOcbA9xnyChBwSpVYL3eIjk369OlW52rawLwH9DR268EanSOrK9QAMTc7aQ35%2Bntje3X7QSFjeiXLmI2P3JkiRZMl1XqA%2Bm%2BYEaSySFM%3D"}],"group":"cf-nel","max_age":604800}
< NEL: {"success_fraction":0,"report_to":"cf-nel","max_age":604800}
< Server: cloudflare
< CF-RAY: 682e536f49440d44-LAX
< alt-svc: h3-27=":443"; ma=86400, h3-28=":443"; ma=86400, h3-29=":443"; ma=86400, h3=":443"; ma=86400
< 
* Connection #0 to host codeahoy.com left intact
* Closing connection 0

Display only Response Headers in curl
If you want to display only the response headers, you can use the --head flag.

curl --head http://codeahoy.com       

HTTP/1.1 301 Moved Permanently
Date: Sun, 22 Aug 2021 19:14:41 GMT
Connection: keep-alive
Cache-Control: max-age=3600
Expires: Sun, 22 Aug 2021 20:14:41 GMT
Location: https://codeahoy.com/
Report-To: {"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v3?s=FJzR6TegRQYBvzipX6RglYE4NgeOvqiNS0%2Faf0Z7pLe0YDku7Gk7xvKgB8RRpvF9vAO81saiqA5PDCoY2Fzz%2BqSY9yQsbOdKjmFVVdYK4ccyYFpoKOoErreL9cqnXFo36%2FYaZcDFDheb%2FU4%3D"}],"group":"cf-nel","max_age":604800}
NEL: {"success_fraction":0,"report_to":"cf-nel","max_age":604800}
Server: cloudflare
CF-RAY: 682e6cf26fe7094c-SEA
alt-svc: h3-27=":443"; ma=86400, h3-28=":443"; ma=86400, h3-29=":443"; ma=86400, h3=":443"; ma=86400
Here’s an alternate way to --head for displaying response headers:

curl -s -D - -o /dev/null http://codeahoy.com
Note:

-s hides the progress bar
-D - dump headers to stdout indicated by -
-o /dev/null send output (HTML) to /dev/null essentially ignoring it
Example:
curl -s -D - http://moto
curl -v http://moto.busche-cnc.com

curl -s -D - -o /dev/null http://codeahoy.com
HTTP/1.1 301 Moved Permanently
Date: Sun, 22 Aug 2021 19:10:49 GMT
Transfer-Encoding: chunked
Connection: keep-alive
Cache-Control: max-age=3600
Expires: Sun, 22 Aug 2021 20:10:49 GMT
Location: https://codeahoy.com/
Report-To: {"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v3?s=7QSrtkFxzkNpCbvMNNqdiuS%2B8II41I%2F7AJRdHwqV49DiyuAyYgTSiV0ceaXx2Es0SJ1XcLmdz9xd6lkQqgl0oe7npIE3QokSgpf86ueyosfjFWHVJcCg5OpIngOkdb12NKz5hOTDbxNTsKg%3D"}],"group":"cf-nel","max_age":604800}
NEL: {"success_fraction":0,"report_to":"cf-nel","max_age":604800}
Server: cloudflare
CF-RAY: 682e67499a52088d-SEA
alt-svc: h3-27=":443"; ma=86400, h3-28=":443"; ma=86400, h3-29=":443"; ma=86400, h3=":443"; ma=86400

