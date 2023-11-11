#!/bin/bash
# https://security.stackexchange.com/questions/252622/what-is-the-purpose-of-certificatepolicies-in-a-csr-how-should-an-oid-be-used
openssl req -new -subj "/C=GB/CN=foo" \
             -addext "subjectAltName = DNS:foo.co.uk" \
             -addext "certificatePolicies = 1.2.3.4" \
             -newkey rsa:2048 -keyout key.pem -out req.pem