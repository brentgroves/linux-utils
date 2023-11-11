https://jite.eu/2019/2/6/ca-with-cfssl/

CertificatesPermalink
Now when we intend to create certificates, we aught to use the correct intermediate for the different certificates that we want.
We will in this part focus on the cluster certificates and we will set up a few certificates that our cluster should be able to use when communicating through TLS. Just as with other certificates, our new certificate will require a signing request and a configuration file. This time though, we will specify profiles for three different type of services: server, peer and client. The server certificate should be able to sign, encrypt, decrypt and authenticate the other certificates, the server certificate is used by the server services that expect connections over TLS. The peer certificates are used for the services (that uses the server certificate) to communicate with eachother, while the client certificate is used by any service that needs to be able to communicate with the servers.

We could, if we where really lazy just create a certificate that could do all of this, but that would make security a bit worse, so we should not!

The configuration will look something like this:

{
    "signing": {
        "default": {
            "expiry": "43800h"
        },
        "profiles": {
            "server": {
                "usages": [
                    "signing",
                    "digital signing",
                    "key encipherment",
                    "server auth"
                ]
            },
            "peer": {
                "usages": [
                    "signing",
                    "digital signature",
                    "key encipherment", 
                    "client auth",
                    "server auth"
                ]
            },
            "client": {
                "usages": [
                    "signing",
                    "digital signature",
                    "key encipherment", 
                    "client auth"
                ]
            }
        }
    }
}
In the above configuration, the peer certificate will be the one with the most authority, but that is expected, as the peers will need to authenticate in both directions. The server certificate will be able to authenticate as server, while client only as client.

When we generate certificates, we will have to create singing requests for each of the profiles, they are a bit different from the earlier certificates and should look something like this:

server.json

{
    "CN": "Server",
    "hosts": [
        "127.0.0.1",
        "server.domain",
        "sub.domain.tld"
    ]
}
As you see in the server certificate, it contains a list of hosts , the hosts should be the IP or FQDN that the servers uses. The peer certificate should basically use the same, as the servers and peers will be used by the same machines.

peer.json

{
    "CN": "Peer",
    "hosts": [
        "127.0.0.1",
        "server.domain",
        "sub.domain.tld"
    ]
}
When it comes to the client certificate, we don’t set any hosts, as we want to be able to connect to the services without having to care about the clients current host. It’s okay to do though, if you want to!

client.json

{
    "CN": "Client",
    "hosts": [""]
}
It’s possible to create wildcard certificates by using the * character, but it’s seen as a security risk.