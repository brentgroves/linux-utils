cablint	ERROR	BR certificates must have subject alternative names extension
cablint	ERROR	BR certificates must include certificatePolicies
cablint	ERROR	commonNames in BR certificates must be from SAN entries
cablint	ERROR	Old certificate version (not X.509v3)
cablint	WARNING	BR certificates should be 397 days in validity or less
cablint	WARNING	Certificate does not include authorityInformationAccess. BRs require OCSP stapling for this certificate.
cablint	WARNING	Serial numbers should have at least 20 bits of entropy
cablint	WARNING	TLS Server certificates must include serverAuth key purpose in extended key usage
cablint	INFO	TLS Server certificate identified
x509lint	ERROR	AKID missing
x509lint	ERROR	Certificate not version 3
x509lint	ERROR	no authorityInformationAccess extension
x509lint	ERROR	No OCSP over HTTP
x509lint	ERROR	No policy extension
x509lint	ERROR	No Subject alternative name extension
x509lint	WARNING	No HTTP URL for issuing certificate
x509lint	WARNING	Subscriber certificate without Extended Key Usage
x509lint	INFO	Checking as leaf certificate
x509lint	INFO	Subject has a deprecated CommonName
x509lint	INFO	Unknown validation policy
zlint	ERROR	CAs must include keyIdentifer field of AKI in all non-self-issued certificates
zlint	ERROR	CAs must support key identifiers and include them in all certificates
zlint	ERROR	Certificates MUST be of type X.590 v3
zlint	ERROR	DNSNames must have a valid TLD.
zlint	ERROR	OrganizationalUnitName is prohibited if...the certificate was issued on or after September 1, 2022
zlint	ERROR	Subscriber Certificate: authorityInformationAccess MUST be present.
zlint	ERROR	Subscriber Certificate: authorityInformationAccess MUST contain the HTTP URL of the Issuing CA's OSCP responder.
zlint	ERROR	Subscriber Certificate: certificatePolicies MUST be present and SHOULD NOT be marked critical.
zlint	ERROR	Subscriber certificates must contain at least one policy identifier that indicates adherence to CAB standards
zlint	ERROR	Subscriber certificates MUST contain the Subject Alternate Name extension
zlint	ERROR	Subscriber certificates MUST have the extended key usage extension present
zlint	ERROR	The common name field in subscriber certificates must include only names from the SAN extension
zlint	WARNING	Sub certificates SHOULD include Subject Key Identifier in end entity certs
zlint	WARNING	Subscriber certificates authorityInformationAccess extension should contain the HTTP URL of the issuing CA’s certificate
zlint	WARNING	TLS server certificates issued on or after September 1, 2020 00:00 GMT/UTC should not have a validity period greater than 397 days
zlint	NOTICE	Check if certificate has enough embedded SCTs to meet Apple CT Policy
zlint	NOTICE	Subscriber Certificate: commonName is deprecated.