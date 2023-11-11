Request header
A request header is an HTTP header that can be used in an HTTP request to provide information about the request context, so that the server can tailor the response. For example, the Accept-* headers indicate the allowed and preferred formats of the response. Other headers can be used to supply authentication credentials (e.g. Authorization), to control caching, or to get information about the user agent or referrer, etc.

Host
The Host request header specifies the host and port number of the server to which the request is being sent.

If no port is included, the default port for the service requested is implied (e.g., 443 for an HTTPS URL, and 80 for an HTTP URL).

A Host header field must be sent in all HTTP/1.1 request messages. A 400 (Bad Request) status code may be sent to any HTTP/1.1 request message that lacks or contains more than one Host header field.


Not all headers that can appear in a request are referred to as request headers by the specification. For example, the Content-Type header is referred to as a representation header.

In addition, CORS defines a subset of request headers as simple headers, request headers that are always considered authorized and are not explicitly listed in responses to preflight requests.

The HTTP message below shows a few request headers after a GET request:

GET /home.html HTTP/1.1
Host: developer.mozilla.org
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:50.0) Gecko/20100101 Firefox/50.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Referer: https://developer.mozilla.org/testpage.html
Connection: keep-alive
Upgrade-Insecure-Requests: 1
If-Modified-Since: Mon, 18 Jul 2016 02:36:04 GMT
If-None-Match: "c561c68d0ba92bbeb8b0fff2a9199f722e3a621a"
Cache-Control: max-age=0