    https://github.com/cloudflare/cfssl/blob/master/doc/cmd/cfssl.txt

       + expiry: This should contain a time duration in the form
      understood by Go's time package[1]. This unfortunately means
      that the maximum unit of time that can be used here is the hour.

    + usages: strings of key usages. The following are acceptable key
      usages:

	+ Key Usages
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
		
	+ Ext Key Usages
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

    + ca_constraint: this object controls the CA bit and CA pathlen constraint of the returned certificates. For example, in order to issue a intermediate CA certificate with pathlen = 1, we put 
      {"is_ca": true, "max_path_len":1}. 
   For another example, to issue an intermediate CA certificate with pathlen = 0, we put
    {"is_ca": true, "max_path_len":0, "max_path_len_zero": true}.
   Notice the extra "max_path_len_zero" field: Without it, the
   intermediate CA certificate will have no pathlen constraint.