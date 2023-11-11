https://curl.se/docs/manpage.html

Help with options:
curl --help | grep -- "-f"

Some Examples:
-- Install vim plugin manager 
-o to specify the file name and location
-L follow redirects
-f fail silently

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 

# check primary ingress
-k means that curl wont verify TLS certificate with the host that 
issued it.

curl -k https://microk8s.local/hotel
curl -k https://microk8s.local/myhello/
curl -k -X POST https://microk8s.local/hotel -H 'Content-Type: application/json' -d '{"id":"4","name":"name4","state":"state4","rooms":"4"}'

-k, --insecure

(TLS SFTP SCP) By default, every secure connection curl makes is verified to be secure before the transfer takes place. This option makes curl skip the verification step and proceed without checking.

When this option is not used for protocols using TLS, curl verifies the server's TLS certificate before it continues: that the certificate contains the right name which matches the host name used in the URL and that the certificate has been signed by a CA certificate present in the cert store. See this online resource for further details:

 https://curl.se/docs/sslcerts.html
For SFTP and SCP, this option makes curl skip the known_hosts verification. known_hosts is a file normally stored in the user's home directory in the .ssh subdirectory, which contains host names and their public keys.

WARNING: using this option makes the transfer insecure.

Example:

 curl --insecure https://example.com

https://curl.se/docs/manpage.html
Protocols
curl supports numerous protocols, or put in URL terms: schemes. Your particular build may not support them all.

DICT

Lets you lookup words using online dictionaries.

FILE

Read or write local files. curl does not support accessing file:// URL remotely, but when running on Microsoft Windows using the native UNC approach will work.

FTP(S)

curl supports the File Transfer Protocol with a lot of tweaks and levers. With or without using TLS.

GOPHER(S)

Retrieve files.

HTTP(S)

curl supports HTTP with numerous options and variations. It can speak HTTP version 0.9, 1.0, 1.1, 2 and 3 depending on build options and the correct command line options.

IMAP(S)

Using the mail reading protocol, curl can "download" emails for you. With or without using TLS.

LDAP(S)

curl can do directory lookups for you, with or without TLS.

MQTT

curl supports MQTT version 3. Downloading over MQTT equals "subscribe" to a topic while uploading/posting equals "publish" on a topic. MQTT over TLS is not supported (yet).

POP3(S)

Downloading from a pop3 server means getting a mail. With or without using TLS.

RTMP(S)

The Realtime Messaging Protocol is primarily used to server streaming media and curl can download it.

RTSP

curl supports RTSP 1.0 downloads.

SCP

curl supports SSH version 2 scp transfers.

SFTP

curl supports SFTP (draft 5) done over SSH version 2.

SMB(S)

curl supports SMB version 1 for upload and download.

SMTP(S)

Uploading contents to an SMTP server means sending an email. With or without TLS.

TELNET

Telling curl to fetch a telnet URL starts an interactive session where it sends what it reads on stdin and outputs what the server sends it.

TFTP

curl can do TFTP downloads and uploads.

