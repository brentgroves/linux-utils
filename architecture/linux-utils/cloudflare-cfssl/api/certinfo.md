https://github.com/cloudflare/cfssl/blob/master/doc/api/endpoint_certinfo.txt
THE CERTINFO ENDPOINT

Endpoint: /api/v1/cfssl/certinfo
Method:   POST

Required parameters:

        One of the following parameters is required.

        * certificate: the PEM-encoded certificate to be parsed.
        * domain: a domain name indicating a remote host to retrieve a
          certificate for.
        * serial and authority_key_id: a certificate serial number and a
          matching authority key to look for in the database

Result:

	The certinfo endpoint returns a JSON object with the following
	keys:

        * subject contains a JSON object corresponding to a PKIX Name, including:
            * common_name
            * serial_number
            * country
            * organization
            * organizational_unit
            * locality
            * province
            * street_address
            * postal_code
            * names
            * extra_names
        * sans is a list of Subject Alternative Names.
        * not_before is the certificate's start date.
        * not_after is the certificate's end date.
        * sigalg is the signature algorithm used to sign the certificate.

Example:
export data="{'certificate':'${v}'}"
export data="{\"certificate\":\"${v}\"}"

CLEANED=${data//[$'\t\r\n']}
curl -d "${data}" -H "Content-Type: application/json" -X POST localhost:8080/api/v1/cfssl/certinfo | python -m json.tool
curl -d "{'certificate':${data}}" -H "Content-Type: application/json" -X POST localhost:8080/api/v1/cfssl/certinfo | python -m json.tool
man -Pless\ +/parameter/pattern/string bash
echo "|${data//[$'\t\r\n ']}|"
curl -d '{"certificate":"-----BEGIN CERTIFICATE-----
MIIEFTCCAv2gAwIBAgIUMgsfcbzGKOitjg+oySqw7RYK72IwDQYJKoZIhvcNAQEL
BQAwejELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0luZGlhbmExDzANBgNVBAcTBkF2
aWxsYTEVMBMGA1UEChMMTW9iZXggR2xvYmFsMRcwFQYDVQQLEw5NSVMgZGVwYXJ0
bWVudDEYMBYGA1UEAxMPTW9iZXggR2xvYmFsIENBMB4XDTIzMDQwNzE2NTgwMFoX
DTMzMDQwNDE2NTgwMFowdDELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0luZGlhbmEx
DzANBgNVBAcTBkF2aWxsYTEVMBMGA1UEChMMTW9iZXggR2xvYmFsMRcwFQYDVQQL
Ew5NSVMgZGVwYXJ0bWVudDESMBAGA1UEAxMJcmVwb3J0czUxMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1QvT1wv/RYhARNcFwMRsSCm1fSxEY6Bolbyg
5xE6I9C7SFKHXS7X9sTKG7EU0hqdLefsRr4cTRHMUej8v2kplqyCPbXBhNQCwSzX
SMFCM3bb5/7k8PEiKSpupWIwbLeGH9bm6pDnS5HdGS6pHnle9lWt2ACU6Kp6s7RD
B/h0et/pG9lWVL3B0+GEFl7ouS1Z4P+2AIUgqyXoa8RGBAnDOxeXzYFwhE4h4Kpo
PRPm5suyTTqOL0IX6afBWs4y6EtudRVwcCiYuaW5Dkw/f6Ny4Ybk0SpyFPFC9LsK
XqsBHpQjfBVgSB2nNIvJNMfwqRYpXIb6IH4nm311KovDR+KX/QIDAQABo4GYMIGV
MA4GA1UdDwEB/wQEAwIFoDATBgNVHSUEDDAKBggrBgEFBQcDATAMBgNVHRMBAf8E
AjAAMB0GA1UdDgQWBBQeDyPtwWbzhPX8bMbSjCuAFYe7zDAfBgNVHSMEGDAWgBRI
coMoWWXL739XwZ86l407pdOOTjAgBgNVHREEGTAXgglyZXBvcnRzNTGHBH8AAAGH
BKwUWEEwDQYJKoZIhvcNAQELBQADggEBAFNfj/kkoz7aN28rT8TDwDaFvx8YLSYi
JZ1W5ysrbbSMrXlPeEiMHLcgIcucd6Wywp8bwdgSfIyhMuH+NNI20fKjltBuY7hC
uwiRt6szzv7X01zwfAG8qKkJ+GbEor4liy6aG8C29/qgzXGShbkmQhzOeEsjoy+/
CJbjJP+MYAnSLNQMNdbtUQMC3f4evWqXafhONuS9805lCkTDaeaYK7FiUmQPKXLN
ZxJLRF0lG+QVVwHsy8Dh3BO0gS8tBFxvbIuZtmp+5e+6DNLfhC3M4I4IEqQ3fwU5
ZqVUYJgXYDoPhoSFbW1ZtOMQ67vaq+BjQcUvG3gmwX/FSoTYaz0A+30=-----END CERTIFICATE-----"}' -H "Content-Type: application/json" -X POST localhost:8080/api/v1/cfssl/certinfo | python -m json.tool

    $ curl -d '{"domain": "cloudflare.com"}' \
          ${CFSSL_HOST}/api/v1/cfssl/certinfo \
          | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  3229    0  3201  100    28  66658    583 --:--:-- --:--:-- --:--:-- 68106
