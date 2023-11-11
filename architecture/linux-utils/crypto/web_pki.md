Web PKI
https://datatracker.ietf.org/wg/wpkops/about/#:~:text=The%20Web%20Public%20Key%20Infrastructure,browsers%20and%20Web%20content%20servers.

The Web Public Key Infrastructure (PKI) is the set of systems,
policies, and procedures used to protect the confidentiality,
integrity, and authenticity of communications between Web
browsers and Web content servers. The Web PKI is used in
conjunction with security protocols such as TLS/SSL and OCSP.

More specifically, the Web PKI (as considered here) consists of
the fields included in the certificates issued to Web content
and application providers by Certification Authorities (CAs),
the certificate status services provided by the Authorities to
Web browsers and their users, and the TLS/SSL protocol stacks
embedded in web servers and browsers.
- Many certificate holders are unsure which browser versions
will reject their certificate if certain certificate profiles
are not met, such as a subject public key that does not
satisfy a minimum key size, or a certificate policies
extension that does not contain a particular standard policy
identifier.

- Certificate issuers (i.e., CAs) find it difficult to predict
whether a certificate chain with certain characteristics will
be accepted. For instance, some browsers include a nonce in
their OCSP requests and expect one in the corresponding
responses, not all servers include a nonce in their replies,
and this means some certificate chains will validate while
others won't.

