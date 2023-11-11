https://github.com/cloudflare/cfssl/issues/864
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

auth_key="F8DACFCC00D330F55740D00C87DA8D39"

b64token=$(cat ../certs/csr.json | openssl dgst -sha256 -mac HMAC -macopt hexkey:$auth_key -binary | base64)

openssl req -new -newkey rsa:2048 -nodes \
    -out     example.csr \
    -keyout example.key

onboarding_key="F8DACFCC00D330F55740D00C87DA8D39"
cn=example.com
csr=$(cat "example.csr")
cn=reports51
csr=$(cat "reports51.csr")
sans=""
certificate_req=$(jq -n -c -j \
                    --arg csr  "${csr}" \
                    --arg cn   "${cn}" \
                    --arg sans "${sans}" \
                    '{"certificate_request":($csr+"\n"),"profile":"server","hosts":([ $cn ] + ($sans | split(" ")))}')

base64_certificate_req=$(printf '%s' "${certificate_req}" | base64 | tr -d '\n')
hex_encoded_onboarding_key=onboarding_key
hex_encoded_onboarding_key="$(echo -n "${onboarding_key}" \
                                | od -tx1 -An -v \
                                | tr -d ' ' \
                                | tr -d '\n' )"

base64_token=$(printf '%s' "${certificate_req}" | \
                openssl dgst -sha256 -binary -mac HMAC -macopt "hexkey:${hex_encoded_onboarding_key}" | \
                base64 | tr -d '\n')

auth_req=$(jq -n -c -j \
             --arg token "${base64_token}" \
             --arg req "${base64_certificate_req}" \
             '{"token":$token,"request":$req}')

echo "$auth_req" > example_authsign_request.json

$ curl -k -X POST -d @example_authsign_request.json \
    -H "Content-Type: application/json" \
    "localhost:8080/api/v1/cfssl/authsign" \
    | jq -r '.result.certificate' > example.crt
curl -k -X POST -d @example_authsign_request.json \
    -H "Content-Type: application/json" \
    "localhost:8080/api/v1/cfssl/authsign" \
    | jq -r '.result.certificate' > example.crt    

$ curl -k -X POST -d @example_authsign_request.json \
    -H "Content-Type: application/json" \
    "https://self.signed.ca.com:8088/api/v1/cfssl/authsign" \
    | jq -r '.result.certificate' > example.crt

"F8DACFCC00D330F55740D00C87DA8D39"


https://clairekeum.wordpress.com/2017/08/01/cfssl-using-authsign-endpoint/
export auth_key="F8DACFCC00D330F55740D00C87DA8D39"
cat request.json | openssl dgst -sha256 -mac HMAC -macopt hexkey:$auth_key -binary | base64

export data=$(cat testcsr.json) 
CLEANED=${data//[$'\t\r\n ']}
export request=$CLEANED
https://www.devglan.com/online-tools/hmac-sha256-online
ComputeHmac256(inbyted, encodedStr),
export token="e3ece92ba51ff9d471cd9394136cc14b4d8b42f0ac3cfe2c4a3be453a6f12a17"
base64.StdEncoding.EncodeToString(inbyted)
export b64token="ZTNlY2U5MmJhNTFmZjlkNDcxY2Q5Mzk0MTM2Y2MxNGI0ZDhiNDJmMGFjM2NmZTJjNGEzYmU0NTNhNmYxMmExNw==" 
export b64request= "eyJob3N0cyI6WyJ3d3cuZXhhbXBsZS5jb20iXSwia2V5Ijp7ImFsZ28iOiJyc2EiLCJzaXplIjoyMDQ4fSwibmFtZXMiOlt7IkMiOiJVUyIsIkwiOiJTYW5GcmFuY2lzY28iLCJPIjoiZXhhbXBsZS5jb20iLCJTVCI6IkNhbGlmb3JuaWEifV19"

export data="{\"token\":\"${b64token}\",\"request\":\"${b64request}\"}"

export data="{\"token\":\"${token}\",\"request\":\"${b64request}\"}"
curl -d "${data}" -H "Content-Type: application/json" -X POST localhost:8080/api/v1/cfssl/authsign | python -m json.tool

https://github.com/cloudflare/cfssl/issues/864
https://github.com/cloudflare/cfssl/blob/master/config/testdata/valid_config_auth.json
curl -d '{ "token":"","request": {"hosts":["www.example.com"], "names":[{"C":"US", "ST":"California", "L":"San Francisco", "O":"example.com"}], "CN": "www.example.com"} }' \
          localhost:8080/api/v1/cfssl/newcert  \
          | python -m json.tool

      "key":"F8DACFCC00D330F55740D00C87DA8D39"

export data="{'certificate':'${v}'}"
export data="{\"certificate\":\"${v}\"}"
export authkey="F8DACFCC00D330F55740D00C87DA8D39"
CLEANED=${data//[$'\t\r\n']}
CLEANED=${data//[$'\t\r\n ']}

curl -d "${data}" -H "Content-Type: application/json" -X POST localhost:8080/api/v1/cfssl/certinfo | python -m json.tool
curl -d "{'certificate':${data}}" -H "Content-Type: application/json" -X POST localhost:8080/api/v1/cfssl/certinfo | python -m json.tool
man -Pless\ +/parameter/pattern/string bash
echo "|${data//[$'\t\r\n ']}|"


curl -d '{ "request": {"hosts":["www.example.com"], "names":[{"C":"US", "ST":"California", "L":"San Francisco", "O":"example.com"}], "CN": "www.example.com"} }' \
          localhost:8080/api/v1/cfssl/newcert  \
          | python -m json.tool

https://github.com/cloudflare/cfssl/blob/master/doc/api/endpoint_authsign.txt
curl -d '{"domain": "cloudflare.com"}' \
	      ${CFSSL_HOST}/api/v1/cfssl/bundle	 \
	      | python -m json.tool

THE AUTHENTICATED SIGNING ENDPOINT

Endpoint: /api/v1/cfssl/authsign
Method:   POST

Required parameters:

    * token: the authentication token
    * request: an encoded JSON signing request (e.g. as
           documented in endpoint_sign.txt).

Optional parameters:

    The following parameters might be used by the authenticator
    as part of the authentication process.

    * timestamp: a Unix timestamp
    * remote_address: an address used in making the request.
    * bundle: a boolean specifying whether to include an "optimal"
    certificate bundle along with the certificate

Result:

    The returned result is a JSON object with a single key:

    * certificate: a PEM-encoded certificate that has been signed
    by the server.
    * bundle: See the result of endpoint_bundle.txt (only included if the bundle parameter was set)

The authentication documentation contains more information about how
authentication with CFSSL works.