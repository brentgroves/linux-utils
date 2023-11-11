https://github.com/cloudflare/cfssl#starting-the-api-server

Starting the API Server
CFSSL comes with an HTTP-based API server; the endpoints are documented in doc/api/intro.txt. The server is started with the serve command:

cfssl serve [-address address] [-ca cert] [-ca-bundle bundle] \
            [-ca-key key] [-int-bundle bundle] [-int-dir dir] [-port port] \
            [-metadata file] [-remote remote_host] [-config config] \
            [-responder cert] [-responder-key key] [-db-config db-config]
Address and port default to "127.0.0.1:8888". The -ca and -ca-key arguments should be the PEM-encoded certificate and private key to use for signing; by default, they are ca.pem and ca_key.pem. The -ca-bundle and -int-bundle should be the certificate bundles used for the root and intermediate certificate pools, respectively. These default to ca-bundle.crt and int-bundle.crt respectively. If the -remote option is specified, all signature operations will be forwarded to the remote CFSSL.

-int-dir specifies an intermediates directory. -metadata is a file for root certificate presence. The content of the file is a json dictionary (k,v) such that each key k is an SHA-1 digest of a root certificate while value v is a list of key store filenames. -config specifies a path to a configuration file. -responder and -responder-key are the certificate and the private key for the OCSP responder, respectively.

The amount of logging can be controlled with the -loglevel option. This comes after the serve command:

cfssl serve -loglevel 2
The levels are:

0 - DEBUG
1 - INFO (this is the default level)
2 - WARNING
3 - ERROR
4 - CRITICAL
The multirootca
The cfssl program can act as an online certificate authority, but it only uses a single key. If multiple signing keys are needed, the multirootca program can be used. It only provides the sign, authsign and info endpoints. The documentation contains instructions for configuring and running the CA.

