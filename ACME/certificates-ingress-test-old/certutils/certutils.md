/etc/ssl/certs/CA_certificate.pem
https://www.mankier.com/1/certutil
Create a new certificate database:
certutil -N -d .
List all certificates in a database:
certutil -L -d .
certutil -L -d /home/brent/.mozilla/firefox/905iw7av.default-release -a -n "My Root CA"

List all private keys in a database:
certutil -K -d . -f path/to/password_file.txt
Import the signed certificate into the requesters database:
certutil -A -n "server_certificate" -t ",," -i path/to/file.crt -d .
Add subject alternative names to a given certificate:
certutil -S -f path/to/password_file.txt -d . -t ",," -c "server_certificate" -n "server_name" -g 2048 -s "CN=common_name,O=organization"
