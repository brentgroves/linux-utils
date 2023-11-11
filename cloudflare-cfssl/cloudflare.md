https://github.com/cloudflare/cfssl

CloudFlare's PKI/TLS toolkit
CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates. It requires Go 1.16+ to build.

Note that certain linux distributions have certain algorithms removed (RHEL-based distributions in particular), so the golang from the official repositories will not work. Users of these distributions should install go manually to install CFSSL.

