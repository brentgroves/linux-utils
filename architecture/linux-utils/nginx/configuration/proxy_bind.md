https://nginx.org/en/docs/http/ngx_http_proxy_module.html
Syntax:	proxy_bind address [transparent] | off;
Default:	—
Context:	http, server, location
This directive appeared in version 0.8.22.

Makes outgoing connections to a proxied server originate from the specified local IP address with an optional port (1.11.2). Parameter value can contain variables (1.3.12). The special value off (1.3.12) cancels the effect of the proxy_bind directive inherited from the previous configuration level, which allows the system to auto-assign the local IP address and port.



https://nginx.org/en/docs/http/ngx_http_proxy_module.html
The ngx_http_proxy_module module allows passing requests to another server.

Example Configuration
location / {
    proxy_pass       http://localhost:8000;
    proxy_set_header Host      $host;
    proxy_set_header X-Real-IP $remote_addr;
}
