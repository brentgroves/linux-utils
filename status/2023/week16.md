I love you my son and have a plan for your well being and the well being of those around you.
Good morning dear ones,
I hope you all made it through another week without too much difficulties. and depending on how you enjoy social gatherings were able to enjoy some good food and company or "chill" at home during the Easter holiday.


Mobex Global's PKI and CA server:
It is made by using CFSSL's Public Key Infrastructure, PKI tools, and its CA server.
https://blog.cloudflare.com/how-to-build-your-own-public-key-infrastructure/
We can use this software for all sorts of things but it is mainly for browsers to verify our web services and secure connections to our database servers.
- Generating TLS Certificates: We do everything but signing the certificate locally.
1. Create the JSON for a CSR request by replacing reports51 with the host name and replace the IP address.
csr.json
{
  "CN": "reports51",
  "hosts": [
    "127.0.0.1",
    "172.20.88.65",
    "reports51"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
      {
        "C": "US",
        "L": "Avilla",
        "O": "Mobex Global",
        "ST": "Indiana",
        "OU": "MIS department"
      }
  ]
}
2. generate the CSR 
https://github.com/cloudflare/cfssl/wiki/Creating-a-new-CSR
"A CSR is what you give to a Certificate Authority; they'll sign it and give you back a certificate that you install on your webserver. CFSSL can generate both a private key and certificate request." for you
cfssl genkey csr.json | cfssljson -bare certificate
This will produce a "certificate.csr" and "certificate-key.pem" file.

3. generate a signed certificate using HMAC256:
To ensure certificate are not able to be signed by anyone with access to our HTTPS API CFSSL uses the HMAC256 hash algorithm and a hex API key to verify the CSR's integrity. 

This process can be done with any programming language that has a crypto library.  Here we use bash.  The trick to getting bash to do what you want is to use pipe the output to the input of many smaller standard programs.  The small programs are used in place of writing your own functions that are used in a typical programming language to accomplish the same task.

hex_encoded_onboarding_key="F8DACFCC00D330F55740D00C87DA8D39"
cn="reports51"
csr=$(cat "reports51.csr")
sans=""
certificate_req=$(jq -n -c -j \
                    --arg csr  "${csr}" \
                    --arg cn   "${cn}" \
                    --arg sans "${sans}" \
                    '{"certificate_request":($csr+"\n"),"profile":"server","hosts":([ $cn ] + ($sans | split(" ")))}')
base64_certificate_req=$(printf '%s' "${certificate_req}" | base64 | tr -d '\n')
base64_token=$(printf '%s' "${certificate_req}" | \
                openssl dgst -sha256 -binary -mac HMAC -macopt "hexkey:${hex_encoded_onboarding_key}" | \
                base64 | tr -d '\n')
auth_req=$(jq -n -c -j \
             --arg token "${base64_token}" \
             --arg req "${base64_certificate_req}" \
             '{"token":$token,"request":$req}')

echo "$auth_req" > reports51_authsign_request.json
curl -k -X POST -d @reports51_authsign_request.json \
    -H "Content-Type: application/json" \
    "localhost:8080/api/v1/cfssl/authsign" \
    | jq -r '.result.certificate' > reports51.crt
openssl x509 -in reports51.crt -text
Note: There is a simple way to do this locally but then anyone with access to our HTTPS API would be able to sign a certificate with our root certificate's private key.

4. Install the certificate on your webserver or NGINX ingress controller.

Expire dates: We want our root certificate to not expire any time soon so I set the expire date for 10 years instead of the default 5 year period.

Other uses for the Mobex Global PKI:
	+ Other Key Usages
		+ signing
		+ digital signature
		+ content commitment
		+ key encipherment
		+ key agreement
		+ data encipherment
		+ cert sign
		+ crl sign
		+ encipher only
		+ decipher only
		
	+ More Key Usages
		+ any
		+ server auth
		+ client auth
		+ code signing
		+ email protection
		+ s/mime
		+ ipsec end system
		+ ipsec tunnel
		+ ipsec user
		+ timestamping
		+ ocsp signing
		+ microsoft sgc
		+ netscape sgc


How to use exchange files securely:
The trick seems to be in exchanging and managing keys or key pairs. Since public/private key pairs are the main ingredient of assymetrical cyphers, such as RSA, the most secure option, and only one key is required in the faster but less secure symmetrical cyphers such as AES.  A good system used for the management of keys and use of cyphers is GPG which is now recommended way of storing repository keys in Ubuntu.

https://stackoverflow.com/questions/14218925/how-can-i-decrypt-a-hmac
HMAC with SHA256 can only be used to hash a value, which is a one-way trip only. If you want to be able to encrypt/decrypt files you will have to use a program such as gpg or write code that uses a cipher, such as aes or des.

1. use gpp program
https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/

2. Use any programming language with has crypto library.  Here is an example using node.js.

Example on how encryption/decryption:

const crypto = require("crypto");

// key and iv   
var key = crypto.createHash("sha256").update("OMGCAT!", "ascii").digest();
var iv = "1234567890123456";

// this is the string we want to encrypt/decrypt
var secret = "ermagherd";

console.log("Initial: %s", secret);

// create a aes256 cipher based on our password
var cipher = crypto.createCipheriv("aes-256-cbc", key, iv);
// update the cipher with our secret string
cipher.update(secret, "ascii");
// save the encryption as base64-encoded
var encrypted = cipher.final("base64");

console.log("Encrypted: %s", encrypted);

// create a aes267 decipher based on our password
var decipher = crypto.createDecipheriv("aes-256-cbc", key, iv);
// update the decipher with our encrypted string
decipher.update(encrypted, "base64");

console.log("Decrypted: %s", decipher.final("ascii"));

