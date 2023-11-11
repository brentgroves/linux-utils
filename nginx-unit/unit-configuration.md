https://unit.nginx.org/configuration/

Configuration
The /config section of the control API handles Unit’s general configuration with entities such as listeners, routes, applications, or upstreams.

Listeners
To accept requests, add a listener object in the config/listeners API section; the object’s name can be:

A unique IP socket: 127.0.0.1:80, [::1]:8080
A wildcard that matches any host IPs on the port: *:80
On Linux-based systems, abstract UNIX sockets can be used as well: unix:@abstract_socket.
Note

Also on Linux-based systems, wildcard listeners can’t overlap with other listeners on the same port due to rules imposed by the kernel. For example, *:8080 conflicts with 127.0.0.1:8080; in particular, this means *:8080 can’t be immediately replaced by 127.0.0.1:8080 (or vice versa) without deleting it first.

Unit dispatches the requests it receives to destinations referenced by listeners. You can plug several listeners into one destination or use a single listener and hot-swap it between multiple destinations.

Available listener options:

{
    "listeners": {
        "*:8000": {
            "application": "regextester"
        }
    },

    "applications": {
        "regextester": {
            "type": "php",
            "user": "root",
            "group": "root",
            "root": "/usr/share/nginx/html",
            "index": "index.php"
        }
    }
}

Available listener options:

Option	Description
pass (required)	
Destination to which the listener passes incoming requests. Possible alternatives:

Application: applications/qwk2mart
PHP target or Python target: applications/myapp/section
Route: routes/route66, routes
Upstream: upstreams/rr-lb
The value is variable -interpolated; if it matches no configuration entities after interpolation, a 404 “Not Found” response is returned.

forwarded	Object; configures client IP address and protocol replacement.
tls	Object; defines SSL/TLS settings.

Applications
Each app that Unit runs is defined as an object in the /config/applications section of the control API; it lists the app’s language and settings, its runtime limits, process model, and various language-specific options.

Note

Our official language-specific packages include end-to-end examples of application configuration, available for your reference at /usr/share/doc/<module name>/examples/ after package installation.

Here, Unit runs 20 processes of a PHP app called blogs, stored in the /www/blogs/scripts/ directory:

{
    "blogs": {
        "type": "php",
        "processes": 20,
        "root": "/www/blogs/scripts/"
    }
}
App objects have a number of options shared between all application languages:


