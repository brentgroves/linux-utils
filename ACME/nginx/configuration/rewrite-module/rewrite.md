Syntax:	rewrite regex replacement [flag];
Default:	—
Context:	server, location, if
If the specified regular expression matches a request URI, URI is changed as specified in the replacement string. The rewrite directives are executed sequentially in order of their appearance in the configuration file. It is possible to terminate further processing of the directives using flags. If a replacement string starts with “http://”, “https://”, or “$scheme”, the processing stops and the redirect is returned to a client.

An optional flag parameter can be one of:

last
stops processing the current set of ngx_http_rewrite_module directives and starts a search for a new location matching the changed URI;
break
stops processing the current set of ngx_http_rewrite_module directives as with the break directive;
redirect
returns a temporary redirect with the 302 code; used if a replacement string does not start with “http://”, “https://”, or “$scheme”;
permanent
returns a permanent redirect with the 301 code.
The full redirect URL is formed according to the request scheme ($scheme) and the server_name_in_redirect and port_in_redirect directives.

Example:

server {
    ...
    rewrite ^(/download/.*)/media/(.*)\..*$ $1/mp3/$2.mp3 last;
    rewrite ^(/download/.*)/audio/(.*)\..*$ $1/mp3/$2.ra  last;
    return  403;
    ...
}

/download/dir/media/test.mp3
$1 = /download/dir
$2 = test
$1/mp3/$2.mp3
/download/dir/mp3/test.mp3