http://nginx.org/en/docs/http/request_processing.html

How to prevent processing requests with undefined server names
Mixed name-based and IP-based virtual servers
A simple PHP site configuration
Name-based virtual servers
nginx first decides which server should process the request. Let’s start with a simple configuration where all three virtual servers listen on port *:80:

server {
    listen      80;
    server_name example.org www.example.org;
    ...
}

server {
    listen      80;
    server_name example.net www.example.net;
    ...
}

server {
    listen      80;
    server_name example.com www.example.com;
    ...
}
In this configuration nginx tests only the request’s header field “Host” to determine which server the request should be routed to. If its value does not match any server name, or the request does not contain this header field at all, then nginx will route the request to the default server for this port. In the configuration above, the default server is the first one — which is nginx’s standard default behaviour. It can also be set explicitly which server should be default, with the default_server parameter in the listen directive:

server {
    listen      80 default_server;
    server_name example.net www.example.net;
    ...
}
The default_server parameter has been available since version 0.8.21. In earlier versions the default parameter should be used instead.
Note that the default server is a property of the listen port and not of the server name. More about this later.

How to prevent processing requests with undefined server names
If requests without the “Host” header field should not be allowed, a server that just drops the requests can be defined:

server {
    listen      80;
    server_name "";
    return      444;
}
Here, the server name is set to an empty string that will match requests without the “Host” header field, and a special nginx’s non-standard code 444 is returned that closes the connection.

Since version 0.8.48, this is the default setting for the server name, so the server_name "" can be omitted. In earlier versions, the machine’s hostname was used as a default server name.
Mixed name-based and IP-based virtual servers
Let’s look at a more complex configuration where some virtual servers listen on different addresses:

server {
    listen      192.168.1.1:80;
    server_name example.org www.example.org;
    ...
}

server {
    listen      192.168.1.1:80;
    server_name example.net www.example.net;
    ...
}

server {
    listen      192.168.1.2:80;
    server_name example.com www.example.com;
    ...
}
In this configuration, nginx first tests the IP address and port of the request against the listen directives of the server blocks. It then tests the “Host” header field of the request against the server_name entries of the server blocks that matched the IP address and port. If the server name is not found, the request will be processed by the default server. For example, a request for www.example.com received on the 192.168.1.1:80 port will be handled by the default server of the 192.168.1.1:80 port, i.e., by the first server, since there is no www.example.com defined for this port.

As already stated, a default server is a property of the listen port, and different default servers may be defined for different ports:

server {
    listen      192.168.1.1:80;
    server_name example.org www.example.org;
    ...
}

server {
    listen      192.168.1.1:80 default_server;
    server_name example.net www.example.net;
    ...
}

server {
    listen      192.168.1.2:80 default_server;
    server_name example.com www.example.com;
    ...
}