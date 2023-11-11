https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16
Configure SQL Server Database Engine for encrypting connections
Article
03/13/2023
6 contributors
You can encrypt all incoming connections to SQL Server or enable encryption for just a specific set of clients. For either of these scenarios, you first have to configure SQL Server to use a certificate that meets Certificate requirements for SQL Server before taking additional steps on the server computer or client computers to encrypt data.

This article describes how to configure SQL Server for certificates (Step 1) and change encryption settings of the SQL Server instance (Step 2). Both steps are required to encrypt all incoming connections to SQL Server when using a certificate from a public commercial authority. For other scenarios, see Special cases for encrypting connections to SQL Server.

Step 1: Configure SQL Server to use certificates
To configure SQL Server to use the certificates described in Certificate requirements for SQL Server, follow these steps:

Install the certificate on the computer that's running SQL Server.
Configure SQL Server to use the installed certificate.
Depending on the version of SQL Server Configuration Manager you have access to on the SQL Server computer, use one of the following procedures to install and configure the SQL Server instance.

Computers that have SQL Server 2019 Configuration Manager
Starting with SQL Server 2019 (15.x), certificate management is integrated into SQL Server Configuration Manager, and can be used with earlier versions of SQL Server. To add a certificate on a single SQL Server instance, in a failover cluster configuration, or in an availability group configuration, see Certificate Management (SQL Server Configuration Manager). The Configuration Manager greatly simplifies certificate management by taking care of installing the certificate and configuring SQL Server for using the installed certificate with just a few steps.

Certificates are stored locally for the users on the computer. To install a certificate for SQL Server to use, you must run SQL Server Configuration Manager with an account that has local administrator privileges.

You can temporarily install an Express edition of SQL Server 2019 (15.x) or a later version to use SQL Server Configuration Manager, which supports integrated certificate management.

Computers that don't have SQL Server 2019 Configuration Manager
If you are using SQL Server 2017 (14.x) or an earlier version, and SQL Server Configuration Manager for SQL Server 2019 (15.x) isn't available, follow these steps to install and configure the certificate on the SQL Server computer:

On the Start menu, select Run, and in the Open box, type MMC and select OK.
In the MMC console, on the File menu, select Add/Remove Snap-in....
In the Add or Remove Snap-ins dialog box, select Certificates, and then select Add.
In the Certificates snap-in dialog box, select Computer account, and then select Next > Finish.
In the Add or Remove Snap-ins dialog box, select OK.
In the MMC console, expand Certificates (Local Computer) > Personal, right-click Certificates, point to All Tasks, and select Import.
Complete the Certificate Import Wizard to add a certificate to the computer.
In the MMC console, right-click the imported certificate, point to All Tasks, and select Manage Private Keys. In the Security dialog box, add read permission for the user account used by the SQL Server service account.
In SQL Server Configuration Manager, expand SQL Server Network Configuration, right-click Protocols for <server instance>, and select Properties.
In the Protocols for <instance name> Properties dialog box, on the Certificate tab, select the desired certificate from the drop-down for the Certificate box, and then select OK.
If you require all the connections to SQL Server to be encrypted, see Step 2: Configure encryption settings in SQL Server. If you only want to enable encryption for specific clients, restart the SQL Server service and see Special cases for encrypting connections to SQL Server.

Step 2: Configure encryption settings in SQL Server
The following steps are only required if you want to force encrypted communications for all the clients:

In SQL Server Configuration Manager, expand SQL Server Network Configuration, right-click Protocols for <server instance>, and then select Properties.
On the Flags tab, in the ForceEncryption box, select Yes, and then select OK to close the dialog box.
Restart the SQL Server service.
 Note

Some certificate scenarios may require you to implement additional steps on the client computer and in your client application to ensure encrypted connections between the client and server. For more information, see Special cases for encrypting connections to SQL Server.

Login packet encryption vs. data packet encryption
At a high level, there are two types of packets in the network traffic between a SQL Server client application and SQL Server: credential packets (login packets) and data packets. When you configure encryption (either server-side or client-side), both these packet types are always encrypted. But, even when you don't configure encryption, the credentials (in the login packet) that are transmitted when a client application connects to SQL Server are always encrypted. SQL Server uses a certificate that meets the certificate requirements from a trusted certification authority if available. This certificate is either manually configured by the system administrator, using one of the procedures previously discussed in the article, or present in the certificate store on the SQL Server computer.

SQL Server-generated self-signed certificates
SQL Server will use a certificate from a trusted certification authority if available for encrypting login packets. If a trusted certificate isn't installed, SQL Server generates a self-signed certificate (fallback certificate) during startup and use that self-signed certificate to encrypt the credentials. This self-signed certificate helps increase security, but it doesn't protect against identity spoofing by the server. If the self-signed certificate is used, and the value of the ForceEncryption option is set to Yes, all data transmitted across a network between SQL Server and the client application is encrypted using the self-signed certificate.

When using a self-signed certificate, SQL Server logs the following message to the error log:

A self-generated certificate was successfully loaded for encryption.

SQL Server 2016 (13.x) and earlier versions use the SHA1 algorithm. However, the SHA1 algorithm and many older algorithms have been deprecated beginning with SQL Server 2016 (13.x). See Deprecated Database Engine features in SQL Server 2016 for more information.

In these environments, if you're using the automatically generated self-signed certificate generated by SQL Server, either just for the prelogin handshake or for encrypting all server-client communications, your vulnerability detection software or security software or company policies may flag this use as a security issue. You have the following options for these scenarios:

Create a new self-signed certificate or a third-party certificate that uses stronger encryption algorithms and configure SQL Server to use this new certificate.
Since you now understand the reason for the flag, you can ignore the message (not recommended).
Upgrade to SQL Server 2017 (14.x) or a later version that uses a stronger hash algorithm (SHA256) for self-signed certificates.

