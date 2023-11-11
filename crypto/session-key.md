Once the certificate is validated, the TLS protocol begins a step called Key Exchange. The server's public key is used by the client to compute a new "session" key, and data is sent back from the client to the server so the server can also compute the same session key. Only the server holding the correct private key associated with the certificate can compute the same session key. If the next message from the server can't be decrypted using the session key, the client terminates the connection.

So we use RSA public-key assymetrical encryption to keep safe the symetrical AES symetrical session key.

https://www.cloudflare.com/learning/ssl/what-is-a-session-key/
What is a session key?
A session key is any symmetric cryptographic key used to encrypt one communication session only. In other words, it's a temporary key that is only used once, during one stretch of time, for encrypting and decrypting datasent between two parties; future conversations between the two would be encrypted with different session keys. A session key is like a password that someone resets every time they log in.

In TLS (historically known as "SSL"), the two communicating parties (the client and the server) generate session keys at the start of any communication session, during the TLS handshake. The official RFC for TLS does not actually call these keys "session keys", but functionally that's exactly what they are.


https://security.stackexchange.com/questions/265497/man-in-the-middle-attack-possible-even-with-ca-certificate-and-assymetric-encry
8


To answer your second question,

what is the use of the CA certificate if it can't be verified that it was really sent by the non-attacker who would get it from the server in the attack described above and just use it as his own?

But it can be verified. It must be verified, or there would be no trust possible on the internet.

A public key could belong to anybody. But once it's signed by some authority who has validated that it belongs to the entity that presented it, we call it a certificate, and we can trust that the certificate was granted to the rightful owner.

But who are those authorities? How do we know that an authority is really a legitimate trustworthy Certificate Authority (CA)? How do we know they check that certificate requests are legitimate? By a series of agreements, and the CA's adherence to strict standards of behavior and security. The CA/Browser Forum is the group that writes the standards that all registered CAs must follow.

(If a CA is ever caught issuing certificates to untrustworthy parties, the penalties are severe. Their certificates will be revoked and they will literally be kicked out of the CA business. Look up the "DigiNotar" entry in Wikipedia for a spectacular example from about 10 years ago.)

These CAs are different kinds of businesses and government agencies. Digicert is a private company that issues certs, and that's all they do. Microsoft has a CA, as does Apple, Google, and some other tech firms. There are various telecom companies included, and representation from many companies and countries around the world.

So now we have a group of CAs that have pledged to follow the rules, and they have been deemed "trustworthy" by various auditors. The root certificates issued by those CAs are then collected and included by various OS publishers and browser publishers as part of their software installations. Your OS probably has about 200 trusted root certificates in it belonging to these CAs. Some browsers, languages, and other software packages will also often include their own list of CAs. Whatever the source, they're already installed in your computer.

When StackExchange needed a new certificate, they set up an account with their CA, Let's Encrypt. In their registration they said "we want a certificate for stackexchange.com", and they created a Certificate Signing Request (CSR). Let's Encrypt then said "before we sign it, you have to prove it's really you. Here's a secret random number to put on your web site at stackexchange.com, and we're going to check for it." So Stack Exchange hosted a page with that number, and Let's Encrypt made sure that DNS routed their request to right server, and retrieved the correct random number. Only Stack Exchange could have known the right number, so this convinced Let's Encrypt that the request was genuinely from stackexchange.com. Let's Encrypt then signed their CSR, issuing them a certificate. Finally, Stack Exchange installed the certificate and private key on their web servers.

So now we have a CA, Let's Encrypt, that has a root certificate, and we have an end entity, stackexchange.com, that has a certificate signed by Let's Encrypt. Both of these are verifiable by your computer, because your computer has the Let's Encrypt root certificate already present in its "Trusted Root Certificate Store".

When you browse to https://stackexchange.com, your computer looks up the IP address associated with the name "stackexchange.com". But it doesn't know yet if that's really stackexchange or not. The TLS protocol is how both sides of the connection exchange encryption keys and communicate. So you connect to the IP address you were given, and the server at the far end sends you a certificate that says it belongs to stackexchange.com. But is it really them? The next required step of the TLS protocol is for your computer to check the signature on the certificate. Your computer verifies that it was signed by Let's Encrypt. It then looks inside its trusted root store, and if it finds a copy of the Let's Encrypt certificate, it considers the connection valid.

In your example, let's say the MitM hijacked your DNS, and routed your requests to his computer's address. That won't help him, because he doesn't have a legitimate certificate for the DNS name of stackexchange.com. And he can't get one, because Let's Encrypt won't be tricked by his attempts at hijacking their DNS (you can assume that CAs have robust security systems that can detect hijacked DNS server responses.) So when your computer establishes the request to the fake stackexchange.com at the bad address, the bad guys will have no valid certificate to present to your computer. They can send you a self-signed certificate that says the words "stackexchange.com", but your computer won't find the signing certificate in its trusted root certificate store. So TLS will reject the connection, and your browser will warn you of the attempted treachery.

EDIT:

From the comments, it seems that you're assuming that the process between steps 5 and 6 are not protected. But they are protected by TLS certificates.

First, let's look at certificates a bit closer, and that means understanding more of the cryptography used. Creating a digital signature takes a hash value* of a series of bytes (the certificate-to-be-signed, in this case), and uses the private key to compute a signature on the hash. Anyone holding the public key can verify the signature, but they cannot use it to create a signature. It's a one-way operation, the core of security of a digital signature.

* Think of a hash value as a "check sum" of the bytes that is unique to that series of bytes. Computing a hash value of a different set of bytes gives a completely different hash value. Hash values are widely used to detect changes between two sets of bytes; in this case it's being used as a "tamper seal". You can't change a single bit of data on the certificate without making its signature invalid.

A certificate has many data fields on it. One field of course is the public key it contains. Most of the rest of the fields are there to make sure that the certificate shouldn't be trusted for anything else. There's a field that says it's only to be used for validating a server and exchanging session keys. The CN and SAN fields hold the DNS name that it's valid for -- the certificate is not to be trusted unless it came from a connection where that DNS name was used. There's an expiration date, after which the certificate is invalid. And there's an issuer field that says "this certificate was signed by Let's Encrypt, so use the Let's Encrypt certificate to check its signature."

When validating a certificate, you must also find the issuer's certificate, and validate the issuer's certificate as well. If that issuing certificate was also issued by someone else, you keep checking. This is called "walking the chain", and to validate a certificate you must walk the full chain until you reach a self-signed certificate. A trusted CA root certificate has what's called a self-signature. It was used to sign itself, so its issuer field is itself. And that self-signed certificate MUST be in your trusted root certificate store.

The TLS protocol calls for the client to connect to the server and send it a CLIENT HELLO; a message that tells it what TLS version and ciphers it wants to use. The server responds with a SERVER HELLO message that includes its version and list of ciphers, and its certificate containing their public key. The client applies all of the rules above (and more) to ensure the certificate is valid, otherwise it terminates the connection.

Once the certificate is validated, the TLS protocol begins a step called Key Exchange. The server's public key is used by the client to compute a new "session" key, and data is sent back from the client to the server so the server can also compute the same session key. Only the server holding the correct private key associated with the certificate can compute the same session key. If the next message from the server can't be decrypted using the session key, the client terminates the connection.

What all this means is that a client will reject a certificate unless it's met all the rules for having been issued correctly, and will terminate the connection if any part of the exchange fails. It ensures that your steps 5 and 6 are trustworthy.

https://www.keyfactor.com/resources/what-is-pki/

Even with asymmetric encryption, the risk of the “man in the middle” exists. For example, what if someone intercepted Bob’s public key, made his own private key, and then generated a new public key for Alice? In this case, Alice would encrypt messages for Bob, the man in the middle could decrypt them, change them and then re-encrypt them and neither Alice nor Bob would be any wiser. 

