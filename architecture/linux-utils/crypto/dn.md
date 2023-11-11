https://knowledge.digicert.com/generalinformation/INFO1745.html
What is a Distinguished Name (DN)?
Description
The Distinguished Name is a set of values entered during enrollment and the creation of a Certificate Signing Request (CSR).
The following values compose the Distinguished Name information:
SSL Certificates:
Country (2 character country code such as US)
Locality/City
State (must be spelled out completely such as New York or California)
Organization (legal company name)
Common Name (the fully qualified domain name such as www.digicert.com)

Code Signing ID's:
Organization (legal company name)
Organizational Unit (division or department of company but this is an optional field)
Locality/City
State (must be spelled out completely such as New York or California)
Country (2 character country code such as US)
Note: Enter your Distinguished Name information accurately to reflect your registered organization name. Be sure to use capitalization, abbreviations and punctuation exactly as you would like it to appear to Web site visitors.


 

https://www.ibm.com/docs/en/i/7.1?topic=concepts-distinguished-name
Distinguished name (DN) is a term that describes the identifying information in a certificate and is part of the certificate itself. A certificate contains DN information for both the owner or requestor of the certificate (called the Subject DN) and the CA that issues the certificate (called the Issuer DN).


Each CA has a policy to determine what identifying information the CA requires to issue a certificate. Some public Internet Certificate Authorities may require little information, such as a name and e-mail address. Other public CAs may require more information and require stricter proof of that identifying information before issuing a certificate. For example, CAs that support Public Key Infrastructure Exchange (PKIX) standards, may require that the requester verify identity information through a Registration Authority (RA) before issuing the certificate. Consequently, if you plan to accept and use certificates as credentials, you need to review the identification requirements for a CA to determine whether their requirements fit your security needs.


You can use Digital Certificate Manager (DCM) to operate a private Certificate Authority and issue private certificates. Also, you can use DCM to generate the DN information and key pair for certificates that a public Internet CA issues for your organization. The DN information that you can provide for either type of certificate includes:
Certificate owner's common name
Organization
Organizational unit
Locality or city
State or province
Country or region
When you use DCM to issue private certificates, you can use certificate extensions to provide additional DN information for the certificate, including:
Version 4 or 6 IP address
Fully qualified domain name
E-mail address

https://www.cryptosys.net/pki/manpki/pki_distnames.html
A distinguished name for an X.509 certificate consists of a sequence of relative distinguished names (RDN) where each RDN is expressed as an attribute type/value pair.

In this Toolkit, an RDN is specified as an attribute type/value pair in the form <type>=<value>. Multi-valued RDNs are not supported. A distinguished name is specified as a string consisting of a sequence of attribute type/value pairs separated by a semicolon (';' U+003B). The general format is

<type>=<value>(;<type>=<value>)*[;]
At least one attribute must be specified. The RDNs are written to the certificate name in the order they are listed. Attribute pairs may be repeated. Note that the Windows Certificate Manager displays the attributes in LDAP order, which is the reverse order to which they are written.

<type> is either a supported short name in the following table or a dotted-decimal encoding of an ASN.1 object identifier (see Specifying an arbitrary RDN below).

type	description	OID
CN	commonName	2.5.4.3
SN	surname	2.5.4.4
SERIALNUMBER	serialNumber	2.5.4.5
C	countryName	2.5.4.6
L	localityName	2.5.4.7
ST or S	stateOrProvinceName	2.5.4.8
STREET	streetAddress	2.5.4.9
O	organizationName	2.5.4.10
OU	organizationalUnit	2.5.4.11
T or TITLE	title	2.5.4.12
G or GN	givenName	2.5.4.42
E	emailAddress (deprecated)	1.2.840.113549.1.9.1
UID	userID	0.9.2342.19200300.100.1.1
DC	domainComponent	0.9.2342.19200300.100.1.25
initials	initials	2.5.4.43
generationQualifier	generation qualifier (eg "Jr.")	2.5.4.44
dnQualifier	distinguished name qualifier	2.5.4.46
pseudonym	pseudonym	2.5.4.65
