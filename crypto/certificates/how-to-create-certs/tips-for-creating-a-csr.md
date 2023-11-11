https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html

Many people miss most important points when they are creating a CSR. If you are not sure about what should be added for individual fields then I would recommend to read this article before you generate CSR:
https://www.golinuxcloud.com/things-to-consider-when-creating-csr-openssl/

I have now covered multiple tutorials on working with openssl certificates. But there is one question where I get a lot of questions where certificate doesn't work due to incorrect entries in Certificate Signing Request.

So I have decided to create a dedicated tutorial to explain why CSR is important, and things to consider when writing a CSR.

# Problems which you can face with incorrect CSR
Writing a CSR is the most crucial part of generating a certificate. If your CSR is not proper then:
RootCA may fail to sign the certificate
Your MTLS authentication will not work with TCP handshake error
- Mutual authentication or two-way authentication refers to two parties authenticating each other at the same time in an authentication protocol.
You will end up creating multiple certificates for each host if you are not familiar with SAN
Your X.509 extensions will not be properly added
and many more ..

Important points to consider when creating CSR
The openssl command will by default consider /etc/ssl/openssl.cnf as the configuration file unless you specify your own configuration file using -config.
nvim /etc/ssl/openssl.cnf 

The req_distinguished_name field is used to get the details which will be asked while generating the CSR. You can alter this section inside the openssl.cnf and add the default values, modify the conditions such as min and max allowed characters etc

There are different policy sections available in the openssl.cnf. The policy_anything is normally used for self-signed certificates where all the fields except commonName are optional.

[ policy_anything ]
  countryName             = optional  
  stateOrProvinceName     = optional
  localityName            = optional
  organizationName        = optional
  organizationalUnitName  = optional
  commonName              = supplied
  emailAddress            = optional

The policy_match section is used to generate RootCA certificates. If you are planning to use this RootCA certificate to sign any server or client certificate, then the respective sections marked as match must be same between RootCA and server or client certificate. In case you provide your stateOrProvinceName as Karnataka in RootCA and KARNATAKA in server certificate then the signing will fail as both will be considered as different values.

commonName is used for MTLS communications. The commonName must match the HOSTNAME or FQDN of the server on the server certificate and client on the client certificate. So if we have apache-client.example.com sending request to apache-server.example.com with MTLS authentication then the server certificate should have commonName as apache-server.example.com and client certificate should have apache-client.example.com

To consider High Availability and Load balancing, in IT organizations we use single FQDN mapped to multiple IP Addresses so in such case we prefer to use SAN certificates. So an -extfile param can be used with openssl command to provide the list of IP Address which would be validated for respective certificate. In such case you can provide the server's domain name as commonName while generating the CSR.

Modify default values for CSR (using custom configuration)
Now let us define our own configuration file which will have all the set of default values to be used to generate the CSR. Here is my sample configuration file:

cat custom_openssl.cnf

Next let us try to generate CSR using this custom configuration file:
openssl req -new -key server.key -out server.csr -config custom_openssl.cnf
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [IN]:
State or Province Name (full name) [KARNATAKA]:
Locality Name (eg, city) [BANGALORE]:
Organization Name (eg, company) [GoLinuxCloud]:
Organizational Unit Name (eg, section) [Admin]:
Common Name (eg, your name or your server's hostname) []:server.example.com ## provide hostname of your localhost
Email Address []: ## can be skipped or provide any email address

As expected, all the default values have been updated based on our custom configuration. So I can just press ENTER and default values will be considered for the CSR.
Although we need to provide Common Name which should have the server's hostname or FQDN

https://www.snel.com/support/what-should-i-enter-as-hostname/#:~:text=you%20should%20configure.-,What%20is%20a%20hostname%3F,to%20find%20the%20right%20server.
While a hostname may technically be a short name (i.e. without the domain) we recommend you to use a fully qualified domain name as your hostname since almost all of our OS templates which are used for installation will setup various parts of your OS according to what’s entered here.

Self-Signed Certificate CSR Example
Let us start with the self-signed certificates first. This is the fastest way to achieve a TLS communication with minimal security as it is better than plain text based communication.

Here is a sample output to generate the CSR for self-signed certificate. Since we have not defined any configuration file, by default openssl will consider nvim /etc/ssl/openssl.cnf:

openssl req -new -key server.key -out server.csr

-----
Country Name (2 letter code) [XX]:IN    ## By default maximum 2 char allowed
State or Province Name (full name) []:ANYTHING  ## can be anything
Locality Name (eg, city) [Default City]:ANYTHING  ## can be anything
Organization Name (eg, company) [Default Company Ltd]:ANYTHING  ## can be anything
Organizational Unit Name (eg, section) []:ANYTHING  ## can be anything
Common Name (eg, your name or your server hostname) []:server.example.com  ## provide the hostname/fqdn of the localhost server node
Email Address []:ANYTHING ## can be anything

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []: ## can be anything or leave empty
An optional company name []: ## can be anything or leave empty

RootCA Certificate CSR Example
We also need to write a CSR when creating our own RootCA certificate. If you are not providing your own openssl.cnf then by default /etc/ssl/openssl.cnf will be considered.

Now by default RootCA certificate follows below below guidelines from /etc/ssl/openssl.cnf:


policy          = policy_match

# For the CA policy
[ policy_match ]
countryName             = match
stateOrProvinceName     = match
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

# For the 'anything' policy
# At this point in time, you must list all acceptable 'object'
# types.
[ policy_anything ]
countryName		= optional
stateOrProvinceName	= optional
localityName		= optional
organizationName	= optional
organizationalUnitName	= optional
commonName		= supplied
emailAddress		= optional

This would mean that both RootCA and server/client certificate must have same countryName, stateOrProvinceName and organizationName or else the signing will fail.
Let us take a look at this with a practical example:
Let me generate my RootCA certificate:

openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out cacert.pem
-----
Country Name (2 letter code) [XX]:IN
State or Province Name (full name) []:KARNATAKA
Locality Name (eg, city) [Defaultt City]:BENGALORE
Organization Name (eg, company) [Default Company Ltd]:GoLinuxCloud
Organizational Unit Name (eg, section) []:Admin
Common Name (eg, your name or your server's hostname) []:RootCA
Email Address []:

ls -l cacert.pem
-rw-r--r-- 1 root root 2049 Aug 28 00:16 cacert.pem

Now we will generate one server certificate:
genrsa  -out server.key 4096
openssl req -new -key server.key -out server.csr
-----
Country Name (2 letter code) [XX]:IN
State or Province Name (full name) []:Karnataka
Locality Name (eg, city) [Defaultt City]:Bengaluru
Organization Name (eg, company) [Default Company Ltd]:Golinuxcloud
Organizational Unit Name (eg, section) []:Dev
Common Name (eg, your name or your server's hostname) []:server.example.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
As you may have noticed, I have provided the different values for countryName, stateOrProvinceName and organizationName for both rootCA and server certificate CSR.

Let us try to now create server certificate by signing this using CSR and rootCA certificate:

openssl ca  -days 2650 -notext -batch -create_serial -cert cacert.pem -keyfile ca.key -in server.csr -out cacert.pem
Using configuration from /etc/ssl/openssl.cnf
Check that the request matches the signature
Signature ok
The stateOrProvinceName field is different between
CA certificate (KARNATAKA) and the request (Karnataka)

As expected, the first check itself has failed since the stateOrProvinceName has different CASE even though the content is same hence they are considered different.

But you can still use openssl x509 command to generate server certificate, the difference is that you will not be able to keep a track of different certificates signed by your RootCA:

openssl x509 -req -days 3650 -in server.csr -CA cacert.pem -CAkey ca.key -CAcreateserial -out server.crt
Signature ok
subject=C = IN, ST = Karnataka, L = Bengaluru, O = Golinuxcloud, OU = Dev, CN = server.example.com
Getting CA Private Key

Verify the certificate content:
openssl x509 -noout -text -in server.crt | grep -E 'Subject:|Issuer:'
        Issuer: C = IN, ST = KARNATAKA, L = BENGALORE, O = GoLinuxCloud, OU = Admin, CN = RootCA
        Subject: C = IN, ST = Karnataka, L = Bengaluru, O = Golinuxcloud, OU = Dev, CN = server.example.com

As you can see, the CSR content for both Issuer and Certificate is different and yet you were able to generate the certificate.

Generate CSR for SAN certificate
We can create a custom configuration file with the list of SAN details which needs to be added to the CSR:

cat custom_openssl.cnf
[req]
req_extensions = req_ext
distinguished_name = req_distinguished_name

[req_distinguished_name]
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name (full name)
localityName                    = Locality Name (eg, city)
0.organizationName              = Organization Name (eg, company)
organizationalUnitName          = Organizational Unit Name (eg, section)
commonName                      = Common Name (eg, your name or your server\'s hostname)
emailAddress                    = Email Address

[req_ext]
subjectAltName = @alt_names

[alt_names]
https://security.stackexchange.com/questions/91368/ip-range-in-ssl-subject-alternative-name
IP.1 = 10.10.10.13
IP.2 = 10.10.10.14
IP.3 = 10.10.10.17
DNS.1 = centos8-2.example.com
DNS.2 = centos8-3.example.com

https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html
 subjectAltName=email:copy,email:my@other.address,URI:http://my.url.here/
 subjectAltName=IP:192.168.7.1
 subjectAltName=IP:13::17
 subjectAltName=email:my@other.address,RID:1.2.3.4
 subjectAltName=otherName:1.2.3.4;UTF8:some other identifier

 Under alt_names section you can provide the list of your IP or hostname or FQDN which will be used for the authentication. Now if your certificate will act as a server certificate then you should all the IP details from your server node and if your certificate will act as a client then you should client details.

The TCP handshake will check the SAN field from both server and client certificate when trying to perform an MTLS connection.

Let us generate our CSR using this configuration file:

openssl req -new -newkey rsa:4096 -nodes  -out server.csr -config custom_openssl.cnf
Generating a RSA private key
.......++++
.........................
......................................................++++
writing new private key to stdout
-----BEGIN PRIVATE KEY-----
MIIJRAIBADANBgkqhkiG9w0BAQEFAASCCS4wggkqAgEAAoICAQC9oU7pOjTF60sd
60EwhsLCaYyUg7dExVDfBt1GwbSRYvk/LphTXck7K8rlmeJv7ECOk/2ju9Ad5wXl

...

Country Name (2 letter code) []:IN
State or Province Name (full name) []:Karnataka
Locality Name (eg, city) []:Bengaluru
Organization Name (eg, company) []:GoLinuxCloud
Organizational Unit Name (eg, section) []:Admin
Common Name (eg, your name or your server's hostname) []:example.com
Email Address []:

Next verify the Subject Alternative Field in your CSR:
openssl req -noout -text -in server.csr | grep -A 1 "Subject Alternative Name"
            X509v3 Subject Alternative Name:
                IP Address:10.10.10.13, IP Address:10.10.10.14, IP Address:10.10.10.17, DNS:centos8-2.example.com, DNS:centos8-3.example.com
Let me also cover some further modifications which can be done to a certificate

Add custom X.509 extensions to Certificate
There are multiple x509 extensions which you can assign to your certificate.

This can be done by updating your openssl.cnf file or you can create a custom configuration file and use that to generate certificate. You may have noticed multiple extension fields in your openssl.cnf such as

v3_ca
v3_req
crl_ext
proxy_cert_ext
..
where each field contains separate set of x509 extensions. You can define the default extension under [req] section as shown below:

[ req ]
default_bits            = 2048
default_md              = sha256
default_keyfile         = privkey.pem
distinguished_name      = req_distinguished_name
attributes              = req_attributes
x509_extensions         = v3_ca

Alternatively you can use -extensions <extension_name> to use a specific extension while signing your certificate.

For example, here I have created an external configuration file with the list of x509 extensions I want to add to my certificate:

cat custom_openssl.cnf
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth

Now let me generate my certificate using this configuration file:
openssl x509 -req -days 3650 -in server.csr -CA cacert.pem -CAkey ca.key -CAcreateserial -out server.crt -extfile custom_openssl.cnf
Signature ok
subject=C = IN, ST = KARNATAKA, L = BANGALORE, O = GoLinuxCloud, OU = Admin, CN = example
Getting CA Private Key

Verify the X.509 extensions inside the certificate:
openssl x509 -noout -text -in server.crt | grep -A 10 "X509v3 extensions"
        X509v3 extensions:
            X509v3 Authority Key Identifier:
                keyid:AC:42:BE:30:0E:43:34:22:EC:1E:AA:5A:D1:9E:C6:C4:BA:72:0F:E0

            X509v3 Basic Constraints:
                CA:FALSE
            X509v3 Key Usage:
                Digital Signature, Non Repudiation, Key Encipherment, Data Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication, TLS Web Client Authentication
    Signature Algorithm: sha256WithRSAEncryption
We have covered different areas related to generating CSR required to sign a certificate. Now you can use a CSR to sign either a RootCA certificate, server or client certificate. I have also explained the important points which one should consider when trying to create a CSR or else they may face TCP handshake failures or certificate signing related failures.

The Common Name is considered as the most important field of any Certificate and must be filled cautiously, especially when generating server or client certificate.

Let me know if you have any questions or feedbacks using the comments section.

 



