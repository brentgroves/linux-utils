https://www.golinuxcloud.com/openssl-create-client-server-certificate/

I have 3 Virtual Machines in my environment which are installed with CentOS 8 running on Oracle VirtualBox. It is important that you use proper hostname or IP Address in the Common Name section while generate Certificate Signing Request or else the SSL encryption between server and client with fail.

Below are the details of my servers on which I will create client certificate along with other certificates for complete validation.

Node1	Node2	Node3
Hostname	centos8-1	centos8-2	centos8-3
FQDN	centos8-1.example.com	centos8-2.example.com	centos8-3.example.com
IP Address	10.10.10.12	10.10.10.16	10.10.10.17
Purpose	Create CA and server client certificates	Client using which we will connect to Apache server	Server where Apache service will be running

openssl req -new -key server.key.pem -out server.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:IN
State or Province Name (full name) []:Karnataka
Locality Name (eg, city) [Default City]:Bengaluru
Organization Name (eg, company) [Default Company Ltd]:GoLinuxCloud
Organizational Unit Name (eg, section) []:R&D
Common Name (eg, your name or your server's hostname) []:centos8-3
Email Address []:admin@golinuxcloud.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:

Configure openssl x509 extensions for server certificate
It is again important to define openssl x509 extensions to be used to create server certificate. These extensions value will differentiate between your server and client certificate. You can read more about these extensions at the man page of openssl x509.

cat server_cert_ext.cnf
basicConstraints = CA:FALSE
nsCertType = server
nsComment = "OpenSSL Generated Server Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

cat client_cert_ext.cnf
basicConstraints = CA:FALSE
nsCertType = client, email
nsComment = "OpenSSL Generated Client Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, emailProtection

What is nonrepudiation and how does it work?

techtarget.com
https://www.techtarget.com › searchsecurity › definition
Nonrepudiation ensures that no party can deny that it sent or received a message via encryption and/or digital signatures or approved some information.

Create server certificate
We will use similar command as used to create client certificate, openssl x509 to create server certificate and sign it using our server.csr which we created above.
We will use CA certificate (certificate bundle) and CA key from our previous article to issue and sign the certificate
The server certificate will be valid for 365 days and encrypted with sha256 algorithm
Define the absolute path and filename of the configuration file which contains openssl x509 extensions for your server certificate using -extfile. If you are using default openssl.cnf then you can also create an extensions section in your openssl.cnf and use -extensions with the key value from openssl.cnf to define your extensions.
The subject in the output contains our CSR details which we provided with server.csr
This command will create server certificate server.cert.pem

openssl x509 -req -in server.csr -CA /root/tls/intermediate/certs/ca-chain-bundle.cert.pem -CAkey /root/tls/intermediate/private/intermediate.cakey.pem -out server.cert.pem -CAcreateserial -days 365 -sha256 -extfile server_cert_ext.cnf
Signature ok
subject=C = IN, ST = Karnataka, L = Bengaluru, O = GoLinuxCloud, OU = R&D, CN = centos8-3, emailAddress = admin@golinuxcloud.com
Getting CA Private Key

Openssl verify server certificate content
In this section we have created below files:

server.key.pem   ⇒ Server private key
server.csr           ⇒ Server CSR
server.cert.pem  ⇒ Server Certificate
You can use below commands to verify the content of these certificates:

# openssl rsa -noout -text -in server.key.pem
# openssl req -noout -text -in server.csr
# openssl x509 -noout -text -in server.cert.pem
