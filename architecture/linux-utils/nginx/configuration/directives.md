https://nginx.org/en/docs/http/ngx_http_proxy_module.html
https://nginx.org/en/docs/http/ngx_http_sub_module.html#sub_filter

The ngx_http_proxy_module module allows passing requests to another server.

Example Configuration
location / {
    proxy_pass       http://localhost:8000;
    proxy_set_header Host      $host;
    proxy_set_header X-Real-IP $remote_addr;
}
