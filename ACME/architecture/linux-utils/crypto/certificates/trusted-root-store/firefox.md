https://support.mozilla.org/en-US/questions/1379667

Getting error  SSL_ERROR_BAD_CERT_DOMAIN on all my sites that are signed with a SSL Cert from my internal CA since updating past version 99

This appears to be a bug starting after Firefox version 99 on Windows because after i upgraded to Firefox version 100 i started getting this on all my SSL Certs from my CA and they worked fine prior to the update. Can anyone confirm if something changed after version 100 that is causing this?



It must be due to removed "subject common name" fallback support from certificate validation. This fallback mode was previously enabled only for manually installed certificates. The CA Browser Forum Baseline Requirements have required the presence of the "subjectAltName" extension since 2012, and use of the subject common name was deprecated in RFC 2818.

Firefox from 101.0 onward no longer use certificate CN (Common Name) for matching domain name to certificate and have migrated to only using SAN (Subject Alternate Name) so if you self sign for internal devices you’ll need to regenerate.
