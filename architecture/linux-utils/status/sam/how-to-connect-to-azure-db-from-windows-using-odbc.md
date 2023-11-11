Meeting notes:
Good morning Sam and Jared,
If you have time I would like to have a meeting concerning updating HRT-KORS43 in order to connect to our Azure SQL managed instance using ODBC.
- System requirements
  - **[ODBC Driver 18 for SQL](https://go.microsoft.com/fwlink/?linkid=2223270)**
  - TLS ver 1.2 according to https://learn.microsoft.com/en-us/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-
  TLS ver 1.2 should already be enabled by default unless we are on a really old server but if it is not enabled maybe because it has not recently been update then we could enable it via the registry or a **[TLS group policy](https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-via-group-policy/)**
- connection strings in bitwarden under Mobex Global group as Azure 
- Will alb-utl, 10.1.1.150, be online again by the beginning of June? If not that is ok I can switch to alb-utl4 without too much difficulty.
# TLS Questions
## How to know which versions of TLS are enabled?
**[Which TLS versions are enabled](https://learn.microsoft.com/en-us/answers/questions/1006253/how-to-know-which-versions-of-tls-is-are-enabled-o)
mgdtc-srv-is01

## How to enable TLS 1.2 or 1.3 using a group policy?
Follow the instructions at **[TLS 1.2 and 1.3 group policy](https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-via-group-policy/)**
## Does TLS ver 1.2 or 1.3 need to be installed on our servers?
**[TLS 1.2 and 1.3 notes](https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-on-windows-server/#)**
A Short Note About TLS 1.2 and TLS 1.3: 
TLS is a cryptographic protocol that is used to secure communications over computer networks. TLS 1.2 and TLS 1.3 are the two latest versions of the Transport Layer Security (TLS) protocol. TLS 1.2 was finalized in 2008, and TLS 1.3 was finalized in 2018.

TLS 1.2 improves upon TLS 1.1 by adding support for Elliptic Curve Cryptography (ECC) and introducing new cryptographic suites that offer better security than the suites used in TLS 1.1. TLS 1.3 improves upon TLS 1.2 by simplifying the handshake process and making it more resistant to man-in-the-middle attacks. In addition, TLS 1.3 introduces new cryptographic suites that offer better security than the suites used in TLS 1.2.

TLS 1.2 and TLS 1.3 are both backward compatible with TLS 1.1 and earlier versions of the protocol. This means that a client that supports TLS 1.2 can communicate with a server that supports TLS 1.1 and vice versa. However, TLS 1.2 and TLS 1.3 are not compatible with each other. A client that supports TLS 1.2 cannot communicate with a server that supports TLS 1.3, and vice versa.

TLS 1.2 is the most widely used version of the TLS protocol, but TLS 1.3 is gaining in popularity. Many major web browsers, including Google Chrome, Mozilla Firefox, and Microsoft Edge, now support TLS 1.3. In addition, major Internet service providers, such as Cloudflare and Akamai, have started to support TLS 1.3 on their servers. Please visit this page if you want to deeply review the comparison of TLS implementations across different supported servers and clients.


Microsoft Windows Server 2016 standard
Configure SQL Server Database Engine for encrypting connections
Article
03/13/2023
6 contributors
You can encrypt all incoming connections to SQL Server or enable encryption for just a specific set of clients. For either of these scenarios, you first have to configure SQL Server to use a certificate that meets Certificate requirements for SQL Server before taking additional steps on the server computer or client computers to encrypt data.

This article describes how to configure SQL Server for certificates (Step 1) and change encryption settings of the SQL Server instance (Step 2). Both steps are required to encrypt all incoming connections to SQL Server when using a certificate from a public commercial authority. For other scenarios, see Special cases for encrypting connections to SQL

https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16