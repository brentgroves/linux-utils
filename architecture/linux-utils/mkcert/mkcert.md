Mkcert Installation 
Mkcert is a simple tool for making locally trusted development certificates. It requires no configuration. It can be installed on Windows, MacOS, or Linux. 

I followed the process outlined here: https://github.com/FiloSottile/mkcert 
Windows 
choco install mkcert 

Ubuntu 
sudo apt install libnss3-tools 
Then you can install using Homebrew on Linux 
brew install mkcert 
mkcert -install 
The following root CA files were generated: 
/home/brent/.local/share/mkcert/rootCA.pem 
/home/brent/.local/share/mkcert/rootCA-key.pem 
The local CA is now installed in the system trust store! ⚡️
The local CA is now installed in the Firefox and/or Chrome/Chromium trust store (requires browser restart)! 🦊
ls -al /home/brent/.local/share/mkcert

How to use Mkcert to create certificates. 
This was made on reports01 at 10.1.0.116
and the certificates are store in: git@github.com:brentgroves/linux-utils.git /certificates
and that includes the root certificates rootCA.
mkcert reports01
mkcert reports02
mkcert reports03
mkcert reports11
mkcert reports12
mkcert reports13
mkcert moto
mkcert avi-ubu
mkcert frt-ubu

kubectl create -n default secret tls tls-credential --key=reports01-key.pem --cert=reports01.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports02-key.pem --cert=reports02.pem
kubectl create -n default secret tls tls-credential --key=reports11-key.pem --cert=reports11.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports12-key.pem --cert=reports12.pem
kubectl create -n default secret tls tls-credential --key=avi-ubu-key.pem --cert=avi-ubu.pem
kubectl create -n default secret tls tls-secondary-credential --key=frt-ubu-key.pem --cert=frt-ubu.pem

Not Secure: 
The browsers will always show not secure when accessing these web sites from computers other than the development system unless you add the RootCA.pfx to the trused root certificate store. 
As you will recall MkCert generated the rootCA.pem and rootCA-key.pem files during installation. Since Windows wants this certificate in pfx format it must be converted first. 
    Go to the /home/brent/.local/share/mkcert folder 
    has password,M0b3x@dm!n, then run openssl pkcs12 -inkey rootCA-key.pem -in rootCA.pem -export -out rootCA.pfx 
    no password: then run openssl pkcs12 -inkey rootCA-key.pem -in rootCA.pem -export -out rootCA.pfx -passin pass: -passout pass:

    Then go to the Windows system and do the following:
    open power shell
    cd source/repos 
    git clone https://github.com/brentgroves/linux-utils.git
    cd certificates
    ls RootCA.pfx on desired system.  
    Then go to Administrator: PowerShell and type certmgr.msc. 
    From the Trusted Root Certification Authorities\Cerficates folder right click and select Import from the All Tasks context menu. From the Certificate Import Wizard select Current User or Local Machine store location and click next.   
    Then select the location of the RootCA.pfx file using the Browse button. 
    Press Yes button for the Do you want to install this certificate security warning dialog. 
    If you exit and run certmgr.msc again you should see a new trusted root certificate: mkcert: brent@moto. 
 

Instead of adding the root certificate to every computer you can add use a group policy to distribute it. 
https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/distribute-certificates-to-client-computers-by-using-group-policy 

This is how you can add digital certificates to Windows 10 from trusted CAs. 

    First, you’ll need to download a root certificate from a CA. For example, you could download one from the GeoTrust site. 

    Next, open Local Security Policy in Windows by pressing the Win key + R hotkey and entering ‘secpol.msc’ in Run’s text box. Note that Windows 10 Home edition doesn’t include the Local Security Policy editor. If your Windows key doesn’t work, check this quick guide to fix it. 

    Then, click Public Key Policies and Certificate Path Validation Settings to open a Certificate Path Validation Settings Properties window. 

    Click the Stores tab and select the Define these policy settings check box. 

    Select the Allow user trusted root CAs to be used to validate certificates and Allow users to trust peer trust certificates options if they’re not already selected. 

    You should also select the Third-Party Root CAs and Enterprise Root CAs checkbox and press the Apply > OK buttons to confirm the selected settings. 

    Next, press the Win key + R hotkey and enter ‘certmgr.msc’ in Run’s text box to open the window shown in the snapshot directly below. That’s the Certification Manager which lists your digital certificates.certificates manager 

    Click Trusted Root Certification Authorities and right-click Certificates to open a context menu. 

    Select All Tasks > Import on the context menu to open the window shown below.certificate import wizard 

    Press the Next button, click Browse, and then select the digital certificate root file saved to your HDD. 

    Press Next again to select the Automatically select the certificate store based on the type of certificate option. 

    Then you can press Next > Finish to wrap up the import wizard. A window will open confirming that “the import was successful.” 

    You should now be able to see the Mobex trusted root certificate it is the one Issued To brent@moto(Brent). 

How to add a root certificate to Ubuntu:
Installing a root CA certificate in the trust store
Often in an enterprise environments there is a local Certificate Authority (CA) that issues certificates local to the organization. For an Ubuntu server to be functional and trust the hosts in this environment this CA must be installed in Ubuntu’s trust store.
https://ubuntu.com/server/docs/security-trust-store

Installing a certificate in PEM form

To install a certificate in the trust store it must be in PEM form. Assuming the root CA certificate is in PEM form at a file called local-ca.crt, follow the steps below to convert to DER form an install.
cd ~/src
git clone git@github.com:brentgroves/linux-utils.git
cd linux-utils/certificates/ubuntu-ca-certficate

$ sudo apt-get install -y ca-certificates
# the mode should already be correct.
$ chmod 644 mkcert_development_CA_303095335489122417061412993970225104069.crt
$ ls -al /usr/local/share/ca-certificates
$ sudo cp mkcert* /usr/local/share/ca-certificates
$ ls -al /usr/local/share/ca-certificates
$ sudo update-ca-certificates
ls /etc/ssl/certs show a list of all certificates.
For Ubuntu do this:
curl https://reports01/myhello/ --cacert /usr/local/share/ca-certificates/mkcert_development_CA_303095335489122417061412993970225104069.crt 

/usr/local/share/ca-certificates/mkcert_development_CA_303095335489122417061412993970225104069.crt

/usr/local/share/ca-certificates
Note: It is important to have the .crt extension on the file, otherwise it will not be processed.

After this point you can use Ubuntu’s tools like curl and wget to connect to local sites.

Add certificate store to firefox.
https://docs.vmware.com/en/VMware-Adapter-for-SAP-Landscape-Management/2.1.0/Installation-and-Administration-Guide-for-VLA-Administrators/GUID-0CED691F-79D3-43A4-B90D-CD97650C13A0.html


Add root certificate to chrome.
https://docs.vmware.com/en/VMware-Adapter-for-SAP-Landscape-Management/2.1.0/Installation-and-Administration-Guide-for-VLA-Administrators/GUID-D60F08AD-6E54-4959-A272-458D08B8B038.html
Cant get the certificate added to chrome but mkcert said it added it but I don't see it and can't add it.
Get a private key failure:
Certificate Import Error
The Private Key for this Client Certificate is missing or invalid
https://superuser.com/questions/1213287/private-key-is-missing-or-invalid-when-importing-a-certificate-in-google-chrom
Add the certificate under the authorities tab.

Certificate Types 

Publicly-trusted certificates 

Publicly trusted SSL/TLS certificates are used for public-facing web servers and applications. A publicly-trusted certificate can only be issued by an external, trusted third-party CA (e.g. Entrust, DigiCert, etc.) which verifies the domain owner. 

Privately-trusted certificates 

Privately-trusted SSL/TLS certificates are used to authenticate users and devices on the internal network. A privately-trusted certificate can be issued by either a public CA, or more often, by any organization that runs their own dedicated internal public key infrastructure (e.g. Microsoft CA). 

What is a Self-Signed Certificate? 

Another strategy is to issue self-signed SSL certificates. A self-signed certificate is one that is not signed by a CA at all – neither private nor public. In this case, the certificate is signed with its own private key, instead of requesting it from a public or a private CA. 

 
 

 

 

 

 

 
 