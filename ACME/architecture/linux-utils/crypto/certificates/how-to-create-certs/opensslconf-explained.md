https://www.phildev.net/ssl/opensslconf.html

The man page for openssl.conf covers syntax, and in some cases specifics. But most options are documented in in the man pages of the subcommands they relate to, and its hard to get a full picture of how the config file works. This page aims to provide that.

Let's start with how the file is structured. For starters, it's an INI-type file, which means sections begin with [section_name] and run until the next section begins. Anything within a section is a simple key=value pair.

There is one additional caveat. Sometimes a key's value is expected to be a section name. This means there is no finite list of possible sections that the parser understands.

So let's get started...

[ ca ]
default_ca      = CA_default
The "ca" section defines the way the CA acts when using the ca command to sign certificates. However, the only thing that should be in the CA section is the name of the default CA's section. This "default" section to use can be overridden by passing -name to ca.

[ CA_default ]
dir             = /var/ca
Here we start our CA_default section and defined a variable to hold our base directory. "dir" is not a key that openssl recognizes, so it's just a varible.

certs		= $dir/certsdb
new_certs_dir	= $certs
database	= $dir/index.txt
certificate	= $dir/cacert.pem
private_key	= $dir/private/cakey.pem
serial		= $dir/serial
crldir		= $dir/crl
crlnumber	= $dir/crlnumber
crl		= $crldir/crl.pem
RANDFILE	= $dir/private/.rand

certs / new_certs_dir
Depending on version, one or the other of these may be used, so we assign one a value and assign it to the other. This is, as you might expect, where certs go after we sign them.
database
This is the database of signed certificates. Openssl uses this internally to keep track of things.
certificate
CA certificate
private_key
CA private key
serial
The serial number which the CA is currently at. You should not initialize this with a number! instead, use the -create_serial option, as mentioned in our Creating a CA page.
crldir
This isn't a config option to openssl, so it's just defining a variable like $dir
crlnumber
This is the serial number, but for CRLs
crl
The current CRL
RANDFILE
This is a random file to read/write random data to/from.
x509_extensions = usr_cert
This defines the section in the file to find the x509v3 extensions to be added to signed certificates.

copy_extensions	= copy
When acting as a CA, we want to honor the extensions that are requested. Note that you do not want copyall here as it's a security risk and should only be used if you really know what you're doing.

name_opt        = ca_default
cert_opt        = ca_default
These simply define the way that the name and certificate information are displayed to you for "confirmation" before signing a certificate and should be left as-is.

default_days    = 365
default_crl_days= 30
The default life for a certificate and a CRL.

default_md      = sha1
preserve        = no
The default digest algorithm - this can be left alone unless you know what you're doing - and whether or not to preserve the DN. Preserving the DN is a site-specific thing: if you want all your certs to have the same DN order, than so "no" here and openssl will re-order the attributes in the DNs of CSRs to make them consistent. However, if you want to let people determind the order of their DN, set this to "yes."

policy          = policy_match
This is the default policy section to use if none is specified.

[ policy_match ]
countryName             = match
stateOrProvinceName     = match
localityName            = supplied
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ v3_ca ]
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always,issuer:always
basicConstraints = CA:true
This section is used to define what extensions to use when signing a CA, and you would use this sectin (instead of the usr_cert, the previously defined default), by specifying -extensions v3_ca on the ca command line.

Here, we define the same extensions as we did in usr_cert, but with some different values. First, we specifically require our AKI settings (if we can't get access to the required information, we'll fail) and our basicConstraints sets CA to true instead of false.


