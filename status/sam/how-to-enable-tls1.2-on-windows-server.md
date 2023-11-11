https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-on-windows-server/#
How to Enable TLS 1.2 and TLS 1.3 on Windows Server?
Growing trends in cyber attacks made system administrators implement more secured communication protocols to protect their assets and network from attacks. TLS plays a vital role in the implementation stack. TLS is a critical security protocol that is used to encrypt communications between clients and servers. TLS 1.2 and TLS 1.3 are the two latest versions of the Transport Layer Security (TLS) protocol and offer many advantages over their previous versions. TLS 1.2 is the most widely used version of the TLS protocol, but TLS 1.3 is gaining popularity. As a system administrator, you should enable TLS 1.2 and TLS 1.3 on your Windows Server to enhance the security of your infrastructure.

Before learning how to enable TLS 1.2 and TLS 1.3 on your Windows Server, let’s understand TLS 1.2 and TLS 1.3 and what these TLS protocols offer more than their predecessors.
A Short Note About TLS 1.2 and TLS 1.3: 
TLS is a cryptographic protocol that is used to secure communications over computer networks. TLS 1.2 and TLS 1.3 are the two latest versions of the Transport Layer Security (TLS) protocol. TLS 1.2 was finalized in 2008, and TLS 1.3 was finalized in 2018.

TLS 1.2 improves upon TLS 1.1 by adding support for Elliptic Curve Cryptography (ECC) and introducing new cryptographic suites that offer better security than the suites used in TLS 1.1. TLS 1.3 improves upon TLS 1.2 by simplifying the handshake process and making it more resistant to man-in-the-middle attacks. In addition, TLS 1.3 introduces new cryptographic suites that offer better security than the suites used in TLS 1.2.

TLS 1.2 and TLS 1.3 are both backward compatible with TLS 1.1 and earlier versions of the protocol. This means that a client that supports TLS 1.2 can communicate with a server that supports TLS 1.1 and vice versa. However, TLS 1.2 and TLS 1.3 are not compatible with each other. A client that supports TLS 1.2 cannot communicate with a server that supports TLS 1.3, and vice versa.

TLS 1.2 is the most widely used version of the TLS protocol, but TLS 1.3 is gaining in popularity. Many major web browsers, including Google Chrome, Mozilla Firefox, and Microsoft Edge, now support TLS 1.3. In addition, major Internet service providers, such as Cloudflare and Akamai, have started to support TLS 1.3 on their servers. Please visit this page if you want to deeply review the comparison of TLS implementations across different supported servers and clients.

https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-on-windows-server/#Method_1_Enable_TLS_12_and_TLS_13_manually_using_Registry