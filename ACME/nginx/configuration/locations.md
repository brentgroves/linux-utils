https://docs.nginx.com/nginx/admin-guide/web-server/web-server/

Configuring Locations
NGINX Plus can send traffic to different proxies or serve different files based on the request URIs. These blocks are defined using the location directive placed within a server directive.

For example, you can define three location blocks to instruct the virtual server to send some requests to one proxied server, send other requests to a different proxied server, and serve the rest of the requests by delivering files from the local file system.

NGINX Plus tests request URIs against the parameters of all location directives and applies the directives defined in the matching location. Inside each location block, it is usually possible (with a few exceptions) to place even more location directives to further refine the processing for specific groups of requests.

Note: In this guide, the word location refers to a single location context.

There are two types of parameter to the location directive: prefix strings (pathnames) and regular expressions. For a request URI to match a prefix string, it must start with the prefix string.

The following sample location with a pathname parameter matches request URIs that begin with /some/path/, such as /some/path/document.html. (It does not match /my-site/some/path because /some/path does not occur at the start of that URI.)

location /some/path/ {
    #...
}
A regular expression is preceded with the tilde (~) for case-sensitive matching, or the tilde-asterisk (~*) for case-insensitive matching. The following example matches URIs that include the string .html or .htm in any position.

location ~ \.htm? {
    #...
}

NGINX Location Priority
To find the location that best matches a URI, NGINX Plus first compares the URI to the locations with a prefix string. It then searches the locations with a regular expression.

Higher priority is given to regular expressions, unless the ^~ modifier is used. Among the prefix strings NGINX Plus selects the most specific one (that is, the longest and most complete string). The exact logic for selecting a location to process a request is given below:

Test the URI against all prefix strings.
The = (equals sign) modifier defines an exact match of the URI and a prefix string. If the exact match is found, the search stops.
If the ^~ (caret-tilde) modifier prepends the longest matching prefix string, the regular expressions are not checked.
Store the longest matching prefix string.
Test the URI against regular expressions.
Stop processing when the first matching regular expression is found and use the corresponding location.
If no regular expression matches, use the location corresponding to the stored prefix string.

A typical use case for the = modifier is requests for / (forward slash). If requests for / are frequent, specifying = / as the parameter to the location directive speeds up processing, because the search for matches stops after the first comparison.

location = / {
    #...
}

A location context can contain directives that define how to resolve a request – either serve a static file or pass the request to a proxied server. In the following example, requests that match the first location context are served files from the /data directory and the requests that match the second are passed to the proxied server that hosts content for the www.example.com domain.

server {
    location /images/ {
        root /data;
    }

    location / {
        proxy_pass http://www.example.com;
    }
}

The root directive specifies the file system path in which to search for the static files to serve. The request URI associated with the location is appended to the path to obtain the full name of the static file to serve. In the example above, in response to a request for /images/example.png, NGINX Plus delivers the file /data/images/example.png.

The proxy_pass directive passes the request to the proxied server accessed with the configured URL. The response from the proxied server is then passed back to the client. In the example above, all requests with URIs that do not start with /images/ are be passed to the proxied server.


