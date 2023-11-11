https://www.golinuxcloud.com/create-certificate-authority-root-ca-linux/
In this article I will share the steps to create Certificate Authority Certificate and then use this CA certificate to sign a certificate.

hese are the brief list of steps to create Certificate Authority using OpenSSL:

Create private key to be used for the certificate.
Create certificate Authority from the key that you just generated.
Create Certificate Signing Request for your server.
Sign the certificate signing request using the key from your CA certificate.
# Step 1: install OpenSSL
conda activate crypto 
openssl version -a # version 3.1.1
# Step 2: OpenSSL encrypted data with 
When we create private key for Root CA certificate, we have an option to either use encryption for private key or create key without any encryption. As if we choose to create private key with encryption such as 3DES, AES then you will have to provide a passphrase every time you try to access the private key.

I have already written another article with the steps for openssl encd data with salted password to encrypt the password file. So I will not repeat the steps here again.

We will use the same encrypted password file for all our examples in this article to demonstrate openssl create certificate chain examples.

# Step 3: Generate Private Key
pushd ~/src/linux-utils/crypto/certificates/how-to-create-certs
First generate private key ca.key, we will use this private key to create Certificate Authority certificate
openssl genrsa -des3 -passout file:mypass.enc -out ca.key 4096
Generating RSA private key, 4096 bit long modulus (2 primes)


# OpenSSL verify Private Key content
To verify the content of private key we created above use openssl command as shown below:
openssl rsa -noout -text -in ca.key -passin file:mypass.enc

# Step 4: Create Certificate Authority Certificate
Many people miss most important points when they are creating a CSR. If you are not sure about what should be added for individual fields then I would recommend to read this article before you generate CSR:
Things to consider when creating CSR with OpenSSL

Now we will use the private key with openssl to create certificate authority certificate ca.cert.pem. OpenSSL uses the information you specify to compile a X.509 certificate using the information prompted to the user, the public key that is extracted from the specified private key which is also used to generate the signature.


openssl req -config "/etc/ssl/openssl.cnf" -new -x509 -days 365 -key ca.key -out ca.cert.pem -passin file:mypass.enc
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
Common Name (eg, your name or your server's hostname) []:centos8-1 CA
Email Address []:admin@golinuxcloud.com

Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:Michigan
Locality Name (eg, city) []:Fruitport
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Mobex Global
Organizational Unit Name (eg, section) []:Information Systems
Common Name (e.g. server FQDN or YOUR name) []:moto.busche-cnc.com
Email Address []:bgroves@mobexglobal.com

# OpenSSL verify CA certificate
To verify CA certificate content using openssl:

openssl x509 -noout -text -in ca.cert.pem
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            4a:73:47:ce:49:c6:a7:ab:36:ad:b8:56:bc:73:3a:e4:63:f7:93:14
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = IN, ST = Karnataka, L = Bengaluru, O = GoLinuxCloud, OU = R&D, CN = centos8-1 CA, emailAddress = admin@golinuxcloud.com
        Validity
            Not Before: Apr 11 15:45:10 2020 GMT
            Not After : Apr 11 15:45:10 2021 GMT
        Subject: C = IN, ST = Karnataka, L = Bengaluru, O = GoLinuxCloud, OU = R&D, CN = centos8-1 CA, emailAddress = admin@golinuxcloud.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (4096 bit)

             <Output trimmed>

        X509v3 extensions:
            X509v3 Subject Key Identifier:
                04:A6:1C:8B:4B:6C:B9:47:3D:A7:FB:38:CA:91:C0:B5:28:A5:BE:94
            X509v3 Authority Key Identifier:
                keyid:04:A6:1C:8B:4B:6C:B9:47:3D:A7:FB:38:CA:91:C0:B5:28:A5:BE:94

            X509v3 Basic Constraints: critical
                CA:TRUE

            <Output trimmed>

# verify certificate
https://crt.sh/lintcert
cablint	ERROR	CA certificates must include keyUsage extension
cablint	ERROR	CA:TRUE without keyCertSign
cablint	INFO	CA certificate identified
cablint	INFO	Name has deprecated attribute emailAddress
x509lint	ERROR	No key usage
x509lint	INFO	Checking as root CA certificate
zlint	ERROR	Root and Subordinate CA certificate keyUsage extension MUST be present
zlint	ERROR	Root CA certificates MUST have Key Usage Extension Present

cablint	ERROR	CA certificates must include keyUsage extension
cablint	ERROR	CA:TRUE without keyCertSign
cablint	INFO	CA certificate identified
cablint	INFO	Name has deprecated attribute emailAddress
x509lint	ERROR	No key usage
x509lint	INFO	Checking as root CA certificate
zlint	ERROR	Root and Subordinate CA certificate keyUsage extension MUST be present
zlint	ERROR	Root CA certificates MUST have Key Usage Extension Present

# alt 
https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html
Tried this but got the exact same linting errors.

Step 5: Generate a server key and request for signing (CSR)
This step creates a server key, and a request that you want it signed (the .csr file) by a Certificate Authority
goto generate-server-key-and-csr.md
# Dictionary:
Password salting is a technique to protect passwords stored in databases by adding a string of 32 or more characters and then hashing them. Salting prevents hackers who breach an enterprise environment from reverse-engineering passwords and stealing them from the database.
**[Create an encryped password file](https://www.golinuxcloud.com/generate-self-signed-certificate-openssl/#Create_encrypted_password_file_Optional)**
The actual key which is used for encryption is driven from the password and the SALT, if provided. Hence, even if the same password used to encrypt two files, if SALT is used, then the key will be different and the ciphertext of course.
 