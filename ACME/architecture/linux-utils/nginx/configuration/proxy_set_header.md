proxy_set_header
https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_set_header

Syntax:	proxy_set_header field value;
Default:	
proxy_set_header Host $proxy_host;
proxy_set_header Connection close;
Context:	http, server, location
Allows redefining or appending fields to the request header passed to the proxied server. The value can contain text, variables, and their combinations. These directives are inherited from the previous configuration level if and only if there are no proxy_set_header directives defined on the current level. By default, only two fields are redefined:

proxy_set_header Host       $proxy_host;
proxy_set_header Connection close;
An unchanged “Host” request header field can be passed like this:

proxy_set_header Host       $http_host;
However, if this field is not present in a client request header then nothing will be passed. In such a case it is better to use the $host variable - its value equals the server name in the “Host” request header field or the primary server name if this field is not present:

proxy_set_header Host       $host;
In addition, the server name can be passed together with the port of the proxied server:

proxy_set_header Host       $host:$proxy_port;
If the value of a header field is an empty string then this field will not be passed to a proxied server:

proxy_set_header Accept-Encoding "";