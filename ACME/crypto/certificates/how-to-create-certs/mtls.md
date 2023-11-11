https://corsha.com/blog/what-is-mtls-and-how-does-it-work

While TLS gracefully replaced its predecessor, SSL, both protocols have shown to be vulnerable to attacks. TLS has been the target of several attacks such as Renegotiation attacks, RC4 and POODLE attacks. The exploitable vulnerabilities within TLS has left many security professionals to realize it’s simply not enough. From this, MTLS or mutual Transport Layer Security has both parties authenticate via certificates to provide an additional security measure to cross network communication.

What is mTLS?
In short, Mutual TLS (mTLS) is a mutual authentication mechanism. It assures that the parties at every end of a network connection are who they claim to be. This assurance is established by validating their private keys with additional verification being done by the information contained in their separate TLS certificates. mTLS is frequently used in a Zero Trust security framework to validate people, connections, and servers within an enterprise. It is also a common tactic used to shore up the security posture of an organization’s APIs to provide Zero Trust guarantees that no person, equipment, or network activity is presumed to be trusted. This helps to eliminate many unwanted and unnecessary security risks.

How do TLS and mTLS work?
TLS (Transport Layer Security) is a widely used encryption protocol on the Internet. TLS, formerly known as SSL, authenticates its server in a client-server interaction and encrypts transactions between the client and the server so that third parties are unable to read them.

There are a few critical components of TLS in order to understand how it works: 

Public key and private key
TLS employs a technique known as public-key encryption that entails the use of two keys: a public and a private key. Only the private key can decrypt anything encrypted using the public key, and vice versa.

TLS certificate
The TLS certificate is a data file that includes the public key, a declaration of who issued the certificate, and the expiration date of the certificate for the purpose of authenticating a server or device.

TLS handshake
The TLS handshake is the procedure for confirming the TLS certificate, in addition to the private key ownership of the server. Additionally, the TLS handshake specifies how encryption will be carried out when the handshake is complete.

Usually, the server has a TLS certificate and a public/private key pair, whereas the client does not. The typical TLS procedure is as follows:

The client interacts with the server
The server shows its TLS certificate
The client validates the certificate of the server
The client and server transfer information over an encrypted TLS connection

Meanwhile, mTLS provides both the client and the server a certificate, enabling both sides to use their public/private key pair to authenticate. In comparison to conventional TLS, mTLS includes the following additional steps in order to validate both parties:

The client interacts with the server
The server shows its TLS certificate
The client validates the certificate of the server
The client provides the TLS certificate
The client's certificate is verified by the server
The server provides access
The client and server transfer information over an encrypted TLS connection
