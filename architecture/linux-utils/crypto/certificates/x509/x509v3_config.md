https://www.openssl.org/docs/man3.0/man5/x509v3_config.html

Several OpenSSL commands can add extensions to a certificate or certificate request based on the contents of a configuration file and CLI options such as -addext. The syntax of configuration files is described in config(5). The commands typically have an option to specify the name of the configuration file, and a section within that file; see the documentation of the individual command for details.

This page uses extensions as the name of the section, when needed in examples.

Each entry in the extension section takes the form:

name = [critical, ]value(s)
If critical is present then the extension will be marked as critical.

If multiple entries are processed for the same extension name, later entries override earlier ones with the same name.

The format of values depends on the value of name, many have a type-value pairing where the type and value are separated by a colon. There are four main types of extension:

string
multi-valued
raw
arbitrary
Each is described in the following paragraphs.

String extensions simply have a string which contains either the value itself or how it is obtained.

Multi-valued extensions have a short form and a long form. The short form is a comma-separated list of names and values:

basicConstraints = critical, CA:true, pathlen:1
The long form allows the values to be placed in a separate section:

[extensions]
basicConstraints = critical, @basic_constraints

[basic_constraints]
CA = true
pathlen = 1
Both forms are equivalent.

If an extension is multi-value and a field value must contain a comma the long form must be used otherwise the comma would be misinterpreted as a field separator. For example:

subjectAltName = URI:ldap://somehost.com/CN=foo,OU=bar
will produce an error but the equivalent form:

[extensions]
subjectAltName = @subject_alt_section

[subject_alt_section]
subjectAltName = URI:ldap://somehost.com/CN=foo,OU=bar
is valid.

OpenSSL does not support multiple occurrences of the same field within a section. In this example:

[extensions]
subjectAltName = @alt_section

[alt_section]
email = steve@example.com
email = steve@example.org
will only recognize the last value. To specify multiple values append a numeric identifier, as shown here:

[extensions]
subjectAltName = @alt_section

[alt_section]
email.1 = steve@example.com
email.2 = steve@example.org

The syntax of raw extensions is defined by the source code that parses the extension but should be documened. See "Certificate Policies" for an example of a raw extension.

If an extension type is unsupported, then the arbitrary extension syntax must be used, see the "ARBITRARY EXTENSIONS" section for more details.

STANDARD EXTENSIONS
The following sections describe the syntax of each supported extension. They do not define the semantics of the extension.

Basic Constraints
This is a multi-valued extension which indicates whether a certificate is a CA certificate. The first value is CA followed by TRUE or FALSE. If CA is TRUE then an optional pathlen name followed by a nonnegative value can be included.

For example:

basicConstraints = CA:TRUE

basicConstraints = CA:FALSE

basicConstraints = critical, CA:TRUE, pathlen:1
A CA certificate must include the basicConstraints name with the CA parameter set to TRUE. An end-user certificate must either have CA:FALSE or omit the extension entirely. The pathlen parameter specifies the maximum number of CAs that can appear below this one in a chain. A pathlen of zero means the CA cannot sign any sub-CA's, and can only sign end-entity certificates.

Key Usage
Key usage is a multi-valued extension consisting of a list of names of the permitted key usages. The defined values are: digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment, keyAgreement, keyCertSign, cRLSign, encipherOnly, and decipherOnly.

Examples:

keyUsage = digitalSignature, nonRepudiation

keyUsage = critical, keyCertSign

Extended Key Usage
This extension consists of a list of values indicating purposes for which the certificate public key can be used. Each value can be either a short text name or an OID. The following text names, and their intended meaning, are known:

Value                  Meaning according to RFC 5280 etc.
-----                  ----------------------------------
serverAuth             SSL/TLS WWW Server Authentication
clientAuth             SSL/TLS WWW Client Authentication
codeSigning            Code Signing
emailProtection        E-mail Protection (S/MIME)
timeStamping           Trusted Timestamping
OCSPSigning            OCSP Signing
ipsecIKE               ipsec Internet Key Exchange
msCodeInd              Microsoft Individual Code Signing (authenticode)
msCodeCom              Microsoft Commercial Code Signing (authenticode)
msCTLSign              Microsoft Trust List Signing
msEFS                  Microsoft Encrypted File System

While IETF RFC 5280 says that id-kp-serverAuth and id-kp-clientAuth are only for WWW use, in practice they are used for all kinds of TLS clients and servers, and this is what OpenSSL assumes as well.

Examples:
extendedKeyUsage = critical, codeSigning, 1.2.3.4
extendedKeyUsage = serverAuth, clientAuth

Subject Alternative Name
This is a multi-valued extension that supports several types of name identifier, including email (an email address), URI (a uniform resource indicator), DNS (a DNS domain name), RID (a registered ID: OBJECT IDENTIFIER), IP (an IP address), dirName (a distinguished name), and otherName. The syntax of each is described in the following paragraphs.

The email option has two special values. copy will automatically include any email addresses contained in the certificate subject name in the extension. move will automatically move any email addresses from the certificate subject name to the extension.

The IP address used in the IP option can be in either IPv4 or IPv6 format.

The value of dirName is specifies the configuration section containing the distinguished name to use, as a set of name-value pairs. Multi-valued AVAs can be formed by prefacing the name with a + character.

The value of otherName can include arbitrary data associated with an OID; the value should be the OID followed by a semicolon and the content in specified using the syntax in ASN1_generate_nconf(3).

Examples:

subjectAltName = email:copy, email:my@example.com, URI:http://my.example.com/

subjectAltName = IP:192.168.7.1

subjectAltName = IP:13::17

subjectAltName = email:my@example.com, RID:1.2.3.4

subjectAltName = otherName:1.2.3.4;UTF8:some other identifier

[extensions]
subjectAltName = dirName:dir_sect

[dir_sect]
C = UK
O = My Organization
OU = My Unit
CN = My Name
