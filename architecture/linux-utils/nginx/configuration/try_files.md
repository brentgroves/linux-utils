http://nginx.org/en/docs/http/ngx_http_core_module.html#try_files

Checks the existence of files in the specified order and uses the first found file for request processing; the processing is performed in the current context. The path to a file is constructed from the file parameter according to the root and alias directives. It is possible to check directory’s existence by specifying a slash at the end of a name, e.g. “$uri/”. If none of the files were found, an internal redirect to the uri specified in the last parameter is made. For example:

location /images/ {
    try_files $uri /images/default.gif;
}

location = /images/default.gif {
    expires 30s;
}
The last parameter can also point to a named location, as shown in examples below. Starting from version 0.7.51, the last parameter can also be a code:

location / {
    try_files $uri $uri/index.html $uri.html =404;
}
