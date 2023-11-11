https://www.niagara-community.com/s/article/Importing-a-PEM-file-using-Workbench
https://www.youtube.com/watch?v=jk0F_ZDZg1U

bgroves@mobexglobal.com/regular-pass
/home/brent/src/linux-utils/crypto/certificates/workflow/csr
# openssl x509 -in pk-server-ca-chain.pem -noout -issuer
issuer=C = US, ST = Indiana, L = Albion, O = Mobex Global, OU = SCADA Software, CN = devcon2, emailAddress = bgroves@mobexglobal.com
# openssl x509 -in pk-server-ca-chain.pem -noout -subject
subject=C = US, ST = Indiana, L = Albion, O = Mobex Global, OU = SCADA Software, CN = devcon2, emailAddress = bgroves@mobexglobal.com
# Obtain Issuer’s public key and expire date
openssl x509 -in pk-server-ca-chain.pem -noout -pubkey 
openssl x509 -in pk-server-ca-chain.pem -noout -pubkey > issuer-pub.pem
openssl x509 -in pk-server-ca-chain.pem -noout -enddate
openssl x509 -in pk-server-ca-chain.pem -noout -serial
https://lapo.it/asn1js/

MASTER PEM FILE-
In a nut shell, you just copy the Private Key, Primary certificate, any intermediate certificates and the root certificate into the same text file. This master file would have a ‘.PEM’ extension. Import this file into the Niagara User Key Store.

Example PEM file
Below is a text editor view of a master '.pem' files. You must include the BEGIN and END statements when you copy the text to build up a master PEM file. You could also copy in the key as well. Note that this PEM contains the private key at the top, next the signed certificate and finally the Root CA. This example only contains the text received back from the signing authority and the private key that was exported using Workbench Certificate Manager. There were no intermediate certificates.

-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA0RnGr8nSCBDoX/v5OB6VMWmp+uokLlu0Jz41ro9ryUcY6QCZ
YsdzzKWsZZfwYlON/9VlGV4t93xXkn26Nq7t+5yZeJ3BowwI4iE3XMspHnqiIY2+
6yS6bQ/56/7Wq9lnxRZC8IrEc/IJ+wQaM+jVNMsOChd5twXhlwTeojj3roc6rv+h
jhaB7M3qflJA0bjs+etDvYtUo1yh4wI6+eW/BQrtnYdkbWcJi9ahIdnxrT2ibgYP
nwYcG9yP2CwQR9i94NMulESp6VqSHq4U+NlLb4zTtnwnx4IIpaRjNH8KlRe572U7
oh/hF1rjgQHzhhnU/jFNSGLfg51MS6nPsP6kQQIDAQABAoIBADVp1TQwZMOEtidW
sVnhjhDaQf6DcwyYhlOD86iMoGcBD17ttUDjXDRJmdk1z8T+PQa+Fx48zZcrnx8f
mMLBOq+MWDPUcJNazqYdAAxnJTDQ+LuDfuKINksHyrq7FVE+ruBMiHrzp61Khbwm
Vx8tedELkaGIT6IuEWtHZiugS7y7/koA2OTtSobE4dGKbra2AOWtCsYk5NBeivzz
xF1IMjWN2gWKixSH943G3t2Bv90F61CgtO/K+l2auNroXlpDzArfcSjIJY7llNpm
1ewQ5Us/nzr3cb2acdEo8E8rn/9F6UMwnm1/wOd+joFX5gaN1m3xm8DXV6b936Si
Qq2AQCUCgYEA7D0AuNMVXnDrB/qPAut4FdoeKpc/zvf0bzHMrAtRB8M2zAWLynav
VNGy9eL43f4INZBhID0FtQSdAJ2IE5cfJgKXUKnbg8gb8c4+ONN6R0CF0KqWN4K6
rNQCoTFQMcvbAnyVVrwcqbj7tzqTMlhMRkbCquFvGxS/9JdIOT5uhdsCgYEA4peg
dAblEjveWXaP32ysKgalp2Ax4OGQq4FRrNOg0cblncHQAqKNAo0NeIBs/b6A+hPC
+Y88a6tg606ATqzegMB/yuOlp0S4Lz81NgCJN1kM8BNdlgfx9Idg7cK2uih9vpKq
rgOw8LOSFFB9C/q+6H9+gwwOadL06bAKMLb+rxMCgYBcHfFxIIYdnGRZaR9o4Q6j
XrkSnIW6G7/JuB56G7OOFlYAukznNt5pcZeZ/9ZRIeRrlo/49TKLgnACNGtCUFRK
Cwqb3pAFU/tpj6V9nSD6NbO4STxoCubly4n29vaxZC9TSecluhZnLAWjTgjlwb6E
TMVNwrgDVFUBeBgmkiygrwKBgHHUkDOZfxxQ3Rt+Vzp7YmXeXvuddJEvX7j4xyoW
SnT4AUPmKHQaatI8P+coRRiXyj1XDhzGmyjPuGmdTxG3ADQYAFrRT9eeyxRZIYcW
b9hRMRGt+Na0+RTJqaTnq1oLm1fQYFP44LuayijQYnFRLvSnj8uPk/IPmx+GYygj
1f/nAoGAFjDIGSApiGtg8NOr7nM1fiRMZMnmZkeSHshWoJABBRLrVaVuALv2RCSf
XgI+cA9b732Tx0PiC8aZnIe8cS9RjGj44cu8q4pksCy6fgzBgQSCu5ud0v4Hv6N8
KKdOFB6YM3ji/nt9KsH8CjN9q2867aAo5WQztAf7nEGISEqiAJY=
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
MIID9jCCAt6gAwIBAgIMSVQFjgsqLXywMzESMA0GCSqGSIb3DQEBCwUAMGkxFjAU
BgNVBAMMDTE3Mi4xNi4xMC4yNDExEDAOBgNVBAsMB1N1cHBvcnQxEDAOBgNVBAoM
B1RyaWRpdW0xETAPBgNVBAcMCFJpY2htb25kMQswCQYDVQQIDAJWQTELMAkGA1UE
BhMCVVMwHhcNMTkxMTEyMTkxNTUxWhcNMjAxMTExMTkxNTUxWjBpMRYwFAYDVQQD
DA0xNzIuMTYuMTAuMjQxMRAwDgYDVQQLDAdTdXBwb3J0MRAwDgYDVQQKDAdUcmlk
aXVtMREwDwYDVQQHDAhSaWNobW9uZDELMAkGA1UECAwCVkExCzAJBgNVBAYTAlVT
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0RnGr8nSCBDoX/v5OB6V
MWmp+uokLlu0Jz41ro9ryUcY6QCZYsdzzKWsZZfwYlON/9VlGV4t93xXkn26Nq7t
+5yZeJ3BowwI4iE3XMspHnqiIY2+6yS6bQ/56/7Wq9lnxRZC8IrEc/IJ+wQaM+jV
NMsOChd5twXhlwTeojj3roc6rv+hjhaB7M3qflJA0bjs+etDvYtUo1yh4wI6+eW/
BQrtnYdkbWcJi9ahIdnxrT2ibgYPnwYcG9yP2CwQR9i94NMulESp6VqSHq4U+NlL
b4zTtnwnx4IIpaRjNH8KlRe572U7oh/hF1rjgQHzhhnU/jFNSGLfg51MS6nPsP6k
QQIDAQABo4GdMIGaMB0GA1UdDgQWBBTPVQ5tHS2up0rQfNbG6CYO2SWkcTAOBgNV
HQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMBoGA1Ud
EQQTMBGCDTE3Mi4xNi4xMC4yNDGBADAuBgNVHRIEJzAloCMGCCsGAQQBoCMCDBdR
bngtTlBNNi0wMDAwLTE0QTItOUE3ODANBgkqhkiG9w0BAQsFAAOCAQEAMF9D4wI6
KyQLm+ccLzX4GElQhjUA1PEradONF3YG93MrCEOeUUAyyF7yBr/9faduPW2mHHay
zKLFOLLlv2Pnha/zPWqy+cWtP2J5pPfHctkE6VUlBgqd8Hkvl/+LeWdQj3ZDnAc5
fMXmXH9lWRqNpReIxuWI3ACexYwJnO3f0DOWFXyqJus0GA+O2vidRStVDZDu+UGx
t8JZk40+a28G3AgwmtRetvsR4EUGD5qOYMZ5YuDrsQjpdz/48yWrzwMmZJxm15/V
C31PvxBHkI1LWAaFTTxi2Vy+v34VtaOB/0vwrLItTuzKrFJiICPsj6uhQVLW6esY
0uDHOQxlw/ybwQ==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDgTCCAmmgAwIBAgIMSFgFm9NKiIW5uwtWMA0GCSqGSIb3DQEBCwUAMDIxETAP
BgNVBAMMCE5pYWdhcmE0MRAwDgYDVQQKDAdUcmlkaXVtMQswCQYDVQQGEwJVUzAe
Fw0xOTA5MDUxMzAxMDNaFw0yMDA5MDUxMzAxMDNaMDIxETAPBgNVBAMMCE5pYWdh
cmE0MRAwDgYDVQQKDAdUcmlkaXVtMQswCQYDVQQGEwJVUzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAIP43bvoZ/f8NDV2bAW36CVup0P/i0QcVyL5vxr8
Af6J1RieMeQjpl3P0Iy9EPDIf7950Dutjd9Zc/5Ez4/iW3UCuE2Uyhifey/Fo4T0
HZRB0Gy55vhNIAlysPLYH6Afo42CuTJkYHIRt2PiiamdDBYKhKE5veu/eNw+8W2A
Ci9eUHyZ9/tTWSrUf5PSx4sAhzl8KwO2bc+ZlbENzs0Ge3jbL80oR8DZXC9Giun7
7HFcOrqthfBbiT+vRyz9yrS988V8kEWZ19q+et7dgnXon4C3515vdgV5nhLO1rJq
JKs4PUXLaQaZQy3ouwayB3vzcQr/OTBTxWb23zsOcRJbmr8CAwEAAaOBljCBkzAd
BgNVHQ4EFgQU83fA8BGg6zDsgtt6JNQHWg5n1zEwHQYDVR0lBBYwFAYIKwYBBQUH
AwEGCCsGAQUFBwMCMA4GA1UdDwEB/wQEAwIFoDATBgNVHREEDDAKgghOaWFnYXJh
NDAuBgNVHRIEJzAloCMGCCsGAQQBoCMCDBdXaW4tRTFCRC05MERDLTBBMEEtNDdG
OTANBgkqhkiG9w0BAQsFAAOCAQEAIaKTt8To5tfB1CVV+5AWBoDHovrjRCP2yiz/
z+U8qYSj+LmFFKwv0qMUATGwtPIPlLZBWm95CtDJzRSZQ0DadQtbCy4Wq6NCRqs0
T35ECqVZMJgX/Zgfgg0K+GR1iuN6bdD7FEfUD2L9MfkV9xcW9c+DQwovs9XInqwc
AR4iMLLHNlLWAOvn1XxY6s3loDvYbDDUGW/VEVJS1tPCX/3mNVd50TaYKWkV9Qih
0C41ZQVEvLCz/zYuqbsYkhwUTgK6/qjy3gt+VddLrCY+1UD/4pFYwY8nJ7nGkioM
5jnnwCKnyzMURiT9hvUNt6eYCiPFTUrQ9mGWhKFh0p0DsQXBDg==
-----END CERTIFICATE-----


Private Key
You export the private key from the certificate you created using the Workbench Certificate Manager tool. Make sure to export the key in an unencrypted format.
The private key is the first entry of the master PEM file you are creating.
The private key is optional when importing a certificate created by the Niagara Certificate Manager and signed using Workbench Certificate Signer Tool.
Primary Certificate
This is the signed certificate that was signed using Workbench Signer Tool or received back from the signing authority. You have either signed your certificate with a CA created using Workbench Certificate Manager, or you have a signed certificate that was signed by a signing authority using the signing request sent to them.
Intermediate Certificate
If using intermediate certificates.
If using a signing authority that has intermediate certificates, they would send them with the primary certificate that they signed.
Root Certificate
This was used to sign the Primary Certificate
Note that you may need to export the Signing Authority CA from the Workbench Trust Store and include that CA as the last certificate in the master PEM. This can be the case if you are using a customer’s certificate and nothing was generated using Niagara and all is being supplied from an external source.
If you sent a signing request to a signing authority the resulting PEM they returned usually contains everything needed except your private key. You would receive back a PEM that contained the signed certificate, any intermediate certificates and the Signing Authority’s root CA. Add your private key at the top of this file and import into Niagara User Key Store.  

Editing and viewing PEM and CERTs
Remember that you can use Workbench to view certs and pem files. Just go to 'My host' and locate the files, then right click and use the 'Pem file' view to see the contents of the file. But if they are building up the pem file, then view the files using the text editor view.

The root certificate (CA) is imported into the 'System Trust store'.

The '.pem' you construct is imported into the 'User Key Store'.