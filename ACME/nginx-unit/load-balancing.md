https://unit.nginx.org/configuration/#load-balancing

Load Balancing
Besides proxying requests to individual servers, Unit can also relay incoming requests to upstreams. An upstream is a group of servers that comprise a single logical entity and may be used as a pass destination for incoming requests in a listener or a route.

Upstreams are defined in the eponymous /config/upstreams section of the API:

{
    "listeners": {
        "*:80": {
            "pass": "upstreams/rr-lb"
        }
    },

    "upstreams": {
        "rr-lb": {
            "servers": {
                "192.168.0.100:8080": {},
                "192.168.0.101:8080": {
                    "weight": 0.5
                }
            }
        }
    }
}
An upstream must define a servers object that lists socket addresses as server object names. Unit dispatches requests between the upstream’s servers in a round-robin fashion, acting as a load balancer. Each server object can set a numeric weight to adjust the share of requests it receives via the upstream. In the above example, 192.168.0.100:8080 receives twice as many requests as 192.168.0.101:8080.

Weights can be specified as integers or fractions in decimal or scientific notation:

{
    "servers": {
        "192.168.0.100:8080": {
            "weight": 1e1
        },

        "192.168.0.101:8080": {
            "weight": 10.0
        },

        "192.168.0.102:8080": {
            "weight": 10
        }
    }
}
The maximum weight is 1000000, the minimum is 0 (such servers receive no requests); the default is 1.

