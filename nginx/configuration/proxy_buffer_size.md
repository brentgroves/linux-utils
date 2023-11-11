proxy_buffer_size
https://nginx.org/en/docs/http/ngx_http_proxy_module.html

Syntax:	proxy_buffer_size size;
Default:	
proxy_buffer_size 4k|8k;
Context:	http, server, location
Sets the size of the buffer used for reading the first part of the response received from the proxied server. This part usually contains a small response header. By default, the buffer size is equal to one memory page. This is either 4K or 8K, depending on a platform. It can be made smaller, however.

