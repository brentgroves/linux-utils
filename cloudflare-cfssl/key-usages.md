https://github.com/cloudflare/cfssl/blob/master/doc/cmd/cfssl.txt

CFSSL supports different profiles for generating various types of
certificates, as well as a default profile to be used when no profile
is given.

A signing profile may contain the following fields, requiring at a
minimum the expiry field. Fields that are not required may be left
blank.

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
