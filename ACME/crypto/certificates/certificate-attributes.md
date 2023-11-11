https://learn.microsoft.com/en-us/windows/win32/secgloss/p-gly
public/private key pair

A set of cryptographic keys used for public key cryptography. For each user, a CSP usually maintains two public/private key pairs: an exchange key pair and a digital signature key pair. Both key pairs are maintained from session to session.

See exchange key pair and signature key pair.

public key

A cryptographic key typically used when decrypting a session key or a digital signature. The public key can also be used to encrypt a message, guaranteeing that only the person with the corresponding private key can decrypt the message.

See also private key.

public key algorithm

An asymmetric cipher that uses two keys, one for encryption, the public key, and the other for decryption, the private key. As implied by the key names, the public key used to encode plaintext can be made available to anyone. However, the private key must remain secret. Only the private key can decrypt the ciphertext. The public key algorithm used in this process is slow (on the order of 1,000 times slower than symmetric algorithms), and is typically used to encrypt session keys or digitally sign a message.


https://learn.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensionsubjectkeyidentifier
IX509ExtensionSubjectKeyIdentifier interface (certenroll.h)
Article
08/22/2022
In this article
Inheritance
Methods
Requirements
See also
The IX509ExtensionSubjectKeyIdentifier interface enables you to specify a SubjectKeyIdentifier extension. When a subject has multiple signing certificates, this extension can be used to help identify which certificate matches a specific certification authority (CA) signing certificate. The extension is placed in all certificates. The following syntax shows the Abstract Syntax Notation One (ASN.1) structure of the extension. The extension value is encoded by using Distinguished Encoding Rules (DER) and included in the certificate request.

syntax

Copy

----------------------------------------------------------------------
-- SubjectKeyIdentifier
-- XCN_OID_SUBJECT_KEY_IDENTIFIER (2.5.29.14)
----------------------------------------------------------------------

SubjectKeyIdentifier ::= KeyIdentifier

KeyIdentifier ::= OCTETSTRING

Typically the value is a 20-byte SHA-1 hash of the public key contained in the CA signing certificate. When the CA issues a certificate, it copies the hash value into the SubjectKeyIdentifier extension. To find the end-entity certificate signed by a particular CA certificate, chain building software searches until it matches the keyIdentifier field in the AuthorityKeyIdentifier extension on the CA signing certificate with a SubjectKeyIdentifier extension value on an issued certificate. For more information, see IX509ExtensionAuthorityKeyIdentifier.

To add this extension object to a PKCS #10 request or a CMC request, you must first add it to an IX509Extensions collection and use the collection to initialize an IX509AttributeExtensions object. For more information, see the PKCS #10 Extensions and the CMC Extensions topics.


https://learn.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509extensionauthoritykeyidentifier

The IX509ExtensionAuthorityKeyIdentifier interface enables you to specify an AuthorityKeyIdentifier extension. When a certification authority (CA) has multiple signing certificates, this extension can be used to help identify which certification authority certificate was used to sign an issued certificate. The extension is placed in all certificates other than that of the root. It has the following Abstract Syntax Notation One (ASN.1) syntax. The extension value is encoded by using Distinguished Encoding Rules (DER) and included in the certificate request.

syntax

Copy

----------------------------------------------------------------------
-- AuthorityKeyIdentifier 
-- XCN_OID_AUTHORITY_KEY_IDENTIFIER2 (2.5.29.35)
----------------------------------------------------------------------

AuthorityKeyId2 ::= SEQUENCE 
{
   keyIdentifier             [0] IMPLICIT KeyIdentifier OPTIONAL,
   authorityCertIssuer       [1] IMPLICIT GeneralNames OPTIONAL,
   authorityCertSerialNumber [2] IMPLICIT CertificateSerialNumber OPTIONAL
} 

KeyIdentifier ::= OCTETSTRING

The default certificate request behavior is to populate only the keyIdentifier field. Typically this value is a 20-byte SHA-1 hash of the public key contained in the CA signing certificate. When the CA issues a certificate, it copies the hash value into the SubjectKeyIdentifier extension of the issued certificate. Chain building software searches the available CA certificates until it matches the SubjectKeyIdentifier extension value on the issued certificate with the keyIdentifier field in the AuthorityKeyIdentifier extension on the CA certificate. For more information about the SubjectKeyIdentifier extension, see IX509ExtensionSubjectKeyIdentifier.

To add this extension object to a PKCS #10 request or a CMC request, you must first add it to an IX509Extensions collection and use the collection to initialize an IX509AttributeExtensions object. For more information, see the PKCS #10 Extensions and the CMC Extensions topics.




https://learn.microsoft.com/en-us/windows/win32/seccertenroll/about-bit-string
BIT STRING
Article
01/07/2021
3 contributors
The BIT STRING data type is encoded into a TLV triplet that begins with a Tag byte of 0x03. The Value field of the TLV triplet contains a leading byte that specifies the number of bits left unused in the final byte of content. In the following example, the Length field is set to 0x03 because three content bytes follow, and the leading byte of the Value field is set to 0x04 because there are four unused bits in the last content byte. Each unused bit is denoted by the letter x.

The subject field of a PKCS #10 certificate request contains the distinguished name of the entity requesting the certificate.

syntax

Copy
CertificationRequestInfo ::= SEQUENCE 
{
   version                 CertificationRequestInfoVersion,
   subject                 Name,
   subjectPublicKeyInfo    SubjectPublicKeyInfo,
   attributes              [0] IMPLICIT Attributes
}

https://learn.microsoft.com/en-us/windows/win32/seccertenroll/supported-attributes

ClientId
The IX509AttributeClientId interface can be used to define an attribute that contains information about the client computer that sent the certificate request. The information can be used for diagnostics.

Applies To: PKCS #10 or CMC request.

OID: XCN_OID_REQUEST_CLIENT_INFO (1.3.6.1.4.1.311.21.20)

Extensions
The IX509AttributeExtensions interface can be used to define a set of X.509 version 3 certificate extensions. The following extensions are supported. For more information, see the Extension Interfaces topic.

Extension	Description
AlternativeNames	Contains one or more alternative name forms of the issuer associated with the certificate.
AuthorityKeyIdentifier	Contains a unique key identifier to differentiate between multiple certificate signing keys of the certification authority (CA).
BasicConstraints	Indicates whether the subject can act as a CA.
CertificatePolicies	Identifies the policies and optional qualifier information associated with the certificate.
MSApplicationPolicies	Identifies one or more uses for the certificate. This extension is similar to the EnhancedKeyUsage extension but is Microsoft-defined.
EnhancedKeyUsage	Identifies one or more uses of the public key contained in the certificate. The enhanced key usage extension can be used in addition to or in place of the key usage extension.
KeyUsage	Identifies restrictions on the operations that can be performed by the public key contained in the certificate.
SmimeCapabilities	Reports the decryption capabilities of an email recipient to the email sender to enable the sender to choose the most secure symmetric algorithm supported by both parties.
SubjectKeyIdentifier	Contains a unique key identifier that can be used to differentiate between multiple signing keys associated with the certificate owner.
Template	Identifies the template to use when issuing or renewing a certificate. The extension contains the object identifier (OID) of the template.
TemplateName	Identifies the template to use when issuing or renewing a certificate. The extension contains the name of the template.

https://learn.microsoft.com/en-us/windows/win32/api/certenroll/nn-certenroll-ix509attributeextensions

You can create one or more version 3 extensions and include them in a certificate request in the following manner:

Initialize any of the following IX509Extension objects:
IX509ExtensionAlternativeNames
IX509ExtensionAuthorityKeyIdentifier
IX509ExtensionBasicConstraints
IX509ExtensionCertificatePolicies
IX509ExtensionMSApplicationPolicies
IX509ExtensionEnhancedKeyUsage
IX509ExtensionKeyUsage
IX509ExtensionSmimeCapabilities
IX509ExtensionSubjectKeyIdentifier
IX509ExtensionTemplate
IX509ExtensionTemplateName
