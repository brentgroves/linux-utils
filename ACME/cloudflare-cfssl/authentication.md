https://github.com/cloudflare/cfssl/blob/master/doc/cmd/cfssl.txt

AUTHENTICATION

See also: authentication.txt

Authentication is used to restrict access to the signing keys when
cfssl is run as a server. A client making a request generates an
authentication token for their request, submitting this token
alongside the request. The authentication section is used to tell
cfssl that authentication is required and how to authenticate.

This section consists of a dictionary of authenticators under the key
"auth_keys"; each authenticator should have the keys "type" and "key",
both strings. For example, to use the standard authenticator with the
(hex-encoded) key "0123456789ABCDEF0123456789ABCDEF" as the "primary"
authenticator, the "auth_keys" section might look like

    "auth_keys": {
        "primary": {
            "type":"standard",
            "key":"0123456789ABCDEF0123456789ABCDEF"
	}
    }

The authentication documentation covers available authenticators and
their key formats.
