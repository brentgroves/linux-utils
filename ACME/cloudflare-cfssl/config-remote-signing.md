https://www.mikenewswanger.com/posts/2018/kubernetes-pki/
Configure Remote Signing
# use cfssl serve instead. multirootca is only needed if you have multiple ca keys.

Before starting up a signing server, we’ll need a certificate pair to secure TLS communication from clients. In addition to the cfssl and cfssljson binaries, we’ll need multirootca on the signing server to handle remote requests.

To do that, we’ll use the CA we just created. We can also reuse the CSR generated above.

We’ll need to specify some configuration data, which will be reffered to below as config.json:

{
  "signing": {
    "default": {
      "auth_key": "default",
      "expiry": "43800h",
      "usages": [
         "signing",
         "key encipherment",
         "client auth",
         "server auth"
       ]
     }
  },
  "auth_keys": {
    "default": {
      "key": "<signing-auth-key>",
      "type": "standard"
    }
  }
}

Next, we need to specify the CAs that can be used to sign remote requests. This is done in an ini file (referred to as multiroot-profile.ini below):

[default]
private = file://<ca-key>.pem
certificate = <ca>.pem
config = <config.json>

With the server profile created, we can invoke the server:

/usr/local/bin/multirootca \
            -a <ip>:<port> \
            -l default \
            -roots <multiroot-profile.ini> \
            -tls-cert <server.pem> \
            -tls-key <server-key.pem>
Using an IP address of 0.0.0.0 will listen on all IPv4. -l default uses the default signing profile defined in multiroot-profile.ini for requests that have no signing profile assigned to them.

If you’re running this in a server running systemd, the following can be used as the service file:

[Unit]
Description=CFSSL PKI Certificate Authority
After=network.target

[Service]
User=ca
ExecStart=/usr/local/bin/multirootca \
            -a <ip>:<port> \
            -l default \
            -roots <multiroot-profile.ini> \
            -tls-cert <server.pem> \
            -tls-key <server-key.pem>
Restart=on-failure
Type=simple
WorkingDirectory=<cfssl-path>

[Install]
WantedBy=multi-user.target
With the process running, we can now securely sign requests remotely.

https://www.mikenewswanger.com/posts/2018/kubernetes-pki/

Next, a request profile needs to be created (referred to as request-profile.json):

{
  "signing": {
    "default": {
      "auth_remote": {
        "remote": "ca_server",
        "auth_key": "default"
      }
    }
  },
  "auth_keys": {
    "default": {
      "key": "<signing-auth-key>",
      "type": "standard"
    }
  },
  "remotes": {
    "ca_server": "<signing_server:port>"
  }
}

Note: The signing auth key here must match the signing auth key above.

Once those are created, we can request the certificate:

cfssl gencert -config=<request-profile.json> -hostname=<san-entries> -tls-remote-ca <ca.pem> -profile=default <csr.json> | cfssljson -bare <cert-name>
san-entries are a comma separated list of either DNS or IP SAN entries, and both prefixes should be omitted; CFSSL automatically adds the appropriate prefix. Example: -hostname=my-server.fqdn,127.0.0.1.

tls-remote-ca can be omitted if the CA is trusted by the system trust.

After running the command, you will have a certificate and key pair signed by the established CA. After signing, the request-profile.json file can be removed so no secrets are stored on the requesting machine.