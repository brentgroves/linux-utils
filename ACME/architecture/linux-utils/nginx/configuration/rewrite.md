Rewriting URIs in Requests
A request URI can be modified multiple times during request processing through the use of the rewrite directive, which has one optional and two required parameters. The first (required) parameter is the regular expression that the request URI must match. The second parameter is the URI to substitute for the matching URI. The optional third parameter is a flag that can halt processing of further rewrite directives or send a redirect (code 301 or 302). For example:

location /users/ {
    rewrite ^/users/(.*)$ /show?user=$1 break;
}


As this example shows, the second parameter users captures though matching of regular expressions.

You can include multiple rewrite directives in both the server and location contexts. NGINX Plus executes the directives one-by-one in the order they occur. The rewrite directives in a server context are executed once when that context is selected.

After NGINX processes a set of rewriting instructions, it selects a location context according to the new URI. If the selected location contains rewrite directives, they are executed in turn. If the URI matches any of those, a search for the new location starts after all defined rewrite directives are processed.

The following example shows rewrite directives in combination with a return directive.

server {
    #...
    rewrite ^(/download/.*)/media/(\w+)\.?.*$ $1/mp3/$2.mp3 last;
    rewrite ^(/download/.*)/audio/(\w+)\.?.*$ $1/mp3/$2.ra  last;
    return  403;
    #...
}

This example configuration distinguishes between two sets of URIs. URIs such as /download/some/media/file are changed to /download/some/mp3/file.mp3. Because of the last flag, the subsequent directives (the second rewrite and the return directive) are skipped but NGINX Plus continues processing the request, which now has a different URI. Similarly, URIs such as /download/some/audio/file are replaced with /download/some/mp3/file.ra. If a URI doesn’t match either rewrite directive, NGINX Plus returns the 403 error code to the client.

There are two parameters that interrupt processing of rewrite directives:

last – Stops execution of the rewrite directives in the current server or location context, but NGINX Plus searches for locations that match the rewritten URI, and any rewrite directives in the new location are applied (meaning the URI can be changed again).
break – Like the break directive, stops processing of rewrite directives in the current context and cancels the search for locations that match the new URI. The rewrite directives in the new location are not executed.