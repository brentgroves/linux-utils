SKS is a new OpenPGP keyserver. 
https://www.youtube.com/watch?v=S4L6cUSrvBw

chown -R debian-sks:debian-sks /var/lib/sks/DB
sudo nvim /etc/default/sks
initstart=yes

sudo ls /etc/init.d
sudo /etc/init.d/sks start
sudo /etc/init.d/sks stop
sudo apt install apache2

Was already created
sudo mkdir /var/lib/sks/www

https://github.com/SKS-Keyserver/sks-keyserver

https://github.com/SKS-Keyserver/sks-keyserver/wiki/Peering

w3m http://localhost:11371
http://localhost:11371/

https://manpages.debian.org/bullseye/sks/sks.8.en.html

https://github.com/SKS-Keyserver/sks-keyserver/wiki/TLS-Configuration

http://web.archive.org/web/20160215171208/http://www.rainydayz.org/node/8

nvim /var/lib/sks/sksconf
/var/lib/sks/sksconf
https://github.com/SKS-Keyserver/sks-keyserver/blob/master/sampleConfig/sksconf.typical

https://gist.github.com/mattrude/84aa65d1bb2bbf9bd81370ec6cdbf91a
https://gist.github.com/mattrude/84aa65d1bb2bbf9bd81370ec6cdbf91a

sudo lsof -i -P -n | grep :11371
sks       3947952      debian-sks    4u  IPv4 39643795      0t0  TCP 127.0.0.1:11371 (LISTEN)
sks       3947952      debian-sks    5u  IPv6 39643796      0t0  TCP [::1]:11371 (LISTEN)

172.20.88.64