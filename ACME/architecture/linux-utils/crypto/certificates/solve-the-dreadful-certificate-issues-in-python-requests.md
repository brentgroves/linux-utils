https://levelup.gitconnected.com/solve-the-dreadful-certificate-issues-in-python-requests-module-2020d922c72f

As Root CA are very very sacred, they need intermediary CAs to delegate responsibility to sign a server certificate when any one asks for it by providing a CSR. Theses intermediaries are called Intermediate CAs. There may be multiple intermediate CAs in a certificate chain.

The intermediate CA certificate is not available in the server.pem file
As we are manually specifying which certificate file to use by specifying verify=server.pem, the python request module will not use the already existing CA bundle, rather will use the server.pem only and expects that, it contains all the certificate in the chain, the server.cer, intermediate cert and root cert

So I manually stripped the server certificate like this:

After stripping all the certificates from the server.cer, we will have different .cer file for all the CAs. So for the above case, we will have 4 .cer files.

Root CA(Zeescalar root ca)
Intermediate CA 1(Zscalar intermediate Root CA)
Intermediate CA 2 (Zscalar intermediate Root CA)
google server .cer file


Now all we have to do is to convert all these .cer files to .pem file and add them together to create a consolidated pem file and feed it to python requests.

So for all the cer files run the following command 4 times.

openssl x509 -in server.cer -inform DER -outform PEM  >> consolidate.pem

All we are doing it here is to create a full fledged CA bundle which has all the certificates and anyway we can do it, is just fine.

That’s it, we feed our new CA pem file to python requests and it is happy.

response = requests.post(url, files=files, headers=headers, verify='consolidate.pem')
<Response [200]>
