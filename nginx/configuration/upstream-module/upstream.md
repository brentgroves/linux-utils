http://nginx.org/en/docs/http/ngx_http_upstream_module.html

The ngx_http_upstream_module module is used to define groups of servers that can be referenced by the proxy_pass, fastcgi_pass, uwsgi_pass, scgi_pass, memcached_pass, and grpc_pass directives.

Example Configuration
upstream backend {
    server backend1.example.com       weight=5;
    server backend2.example.com:8080;
    server unix:/tmp/backend3;

    server backup1.example.com:8080   backup;
    server backup2.example.com:8080   backup;
}

server {
    location / {
        proxy_pass http://backend;
    }
}


Syntax:	upstream name { ... }
Default:	—
Context:	http
Defines a group of servers. Servers can listen on different ports. In addition, servers listening on TCP and UNIX-domain sockets can be mixed.

Example:

upstream backend {
    server backend1.example.com weight=5;
    server 127.0.0.1:8080       max_fails=3 fail_timeout=30s;
    server unix:/tmp/backend3;

    server backup1.example.com  backup;
}


By default, requests are distributed between the servers using a weighted round-robin balancing method. In the above example, each 7 requests will be distributed as follows: 5 requests go to backend1.example.com and one request to each of the second and third servers. If an error occurs during communication with a server, the request will be passed to the next server, and so on until all of the functioning servers will be tried. If a successful response could not be obtained from any of the servers, the client will receive the result of the communication with the last server.

Syntax:	server address [parameters];
Default:	—
Context:	upstream
Defines the address and other parameters of a server. The address can be specified as a domain name or IP address, with an optional port, or as a UNIX-domain socket path specified after the “unix:” prefix. If a port is not specified, the port 80 is used. A domain name that resolves to several IP addresses defines multiple servers at once.

The following parameters can be defined:

weight=number
sets the weight of the server, by default, 1.
max_conns=number
limits the maximum number of simultaneous active connections to the proxied server (1.11.5). Default value is zero, meaning there is no limit. If the server group does not reside in the shared memory, the limitation works per each worker process.
If idle keepalive connections, multiple workers, and the shared memory are enabled, the total number of active and idle connections to the proxied server may exceed the max_conns value.
Since version 1.5.9 and prior to version 1.11.5, this parameter was available as part of our commercial subscription.
max_fails=number
sets the number of unsuccessful attempts to communicate with the server that should happen in the duration set by the fail_timeout parameter to consider the server unavailable for a duration also set by the fail_timeout parameter. By default, the number of unsuccessful attempts is set to 1. The zero value disables the accounting of attempts. What is considered an unsuccessful attempt is defined by the proxy_next_upstream, fastcgi_next_upstream, uwsgi_next_upstream, scgi_next_upstream, memcached_next_upstream, and grpc_next_upstream directives.
fail_timeout=time
sets
the time during which the specified number of unsuccessful attempts to communicate with the server should happen to consider the server unavailable;
and the period of time the server will be considered unavailable.
By default, the parameter is set to 10 seconds.
backup
marks the server as a backup server. It will be passed requests when the primary servers are unavailable.
The parameter cannot be used along with the hash, ip_hash, and random load balancing methods.

down
marks the server as permanently unavailable.
