https://www.nixcraft.com/t/gpg-keyserver-receive-failed-no-keyserver-available-error-and-solution/4535

The procedure to fix “gpg: keyserver receive failed: No keyserver available” is as follows:
Open terminal app on your Linux machine.
Run the following pkill command to kill dirmngr that takes care of accessing the OpenPGP keyservers:
sudo pkill dirmngr
Try again gpg command again:
/usr/bin/gpg --homedir /home/tom/.my_app/.gnupg --no-permission-warning --keyserver pgp.mit.edu --recv-keys my_key_here
/usr/bin/gpg --homedir /home/brent/.gnupg --no-permission-warning --keyserver reports51 --search-keys brent@moto

If above failed try prefixing the hkp:// to pgp.mit.edu. Example:
/usr/bin/gpg --homedir /home/tom/.my_app/.gnupg --no-permission-warning --keyserver hkp://pgp.mit.edu --recv-keys my_key_here
Here is how to debug dirmngr issues:
sudo pkill dirmngr; dirmngr --debug-all --daemon --standard-resolver

