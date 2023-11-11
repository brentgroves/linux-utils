https://docs.nginx.com/nginx/admin-guide/web-server/web-server/

Setting Up Virtual Servers
The NGINX Plus configuration file must include at least one server directive to define a virtual server. When NGINX Plus processes a request, it first selects the virtual server that will serve the request.

A virtual server is defined by a server directive in the http context, for example:

http {
    server {
        # Server configuration
    }
}

It is possible to add multiple server directives into the http context to define multiple virtual servers.

The server configuration block usually includes a listen directive to specify the IP address and port (or Unix domain socket and path) on which the server listens for requests. Both IPv4 and IPv6 addresses are accepted; enclose IPv6 addresses in square brackets.

The example below shows configuration of a server that listens on IP address 127.0.0.1 and port 8080:

server {
    listen 127.0.0.1:8080;
    # Additional server configuration
}


If a port is omitted, the standard port is used. Likewise, if an address is omitted, the server listens on all addresses. If the listen directive is not included at all, the “standard” port is 80/tcp and the “default” port is 8000/tcp, depending on superuser privileges.

If there are several servers that match the IP address and port of the request, NGINX Plus tests the request’s Host header field against the server_name directives in the server blocks. The parameter to server_name can be a full (exact) name, a wildcard, or a regular expression. A wildcard is a character string that includes the asterisk (*) at its beginning, end, or both; the asterisk matches any sequence of characters. NGINX Plus uses the Perl syntax for regular expressions; precede them with the tilde (~). This example illustrates an exact name.

server {
    listen      80;
    server_name example.org www.example.org;
    #...
}

If several names match the Host header, NGINX Plus selects one by searching for names in the following order and using the first match it finds:

Exact name
Longest wildcard starting with an asterisk, such as *.example.org
Longest wildcard ending with an asterisk, such as mail.*
First matching regular expression (in order of appearance in the configuration file)

If the Host header field does not match a server name, NGINX Plus routes the request to the default server for the port on which the request arrived. The default server is the first one listed in the nginx.conf file, unless you include the default_server parameter to the listen directive to explicitly designate a server as the default.

server {
    listen 80 default_server;
    #...
}