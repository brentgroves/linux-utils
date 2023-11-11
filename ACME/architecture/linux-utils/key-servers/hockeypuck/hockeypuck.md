Hockeypuck is an OpenPGP Key Server that implements the HTTP Keyserver Protocol and the SKS database reconciliation protocol.
another image
https://hub.docker.com/r/jenserat/hockeypuck

https://hockeypuck.io/
https://hockeypuck.io/install-docker.html
https://github.com/hockeypuck/hockeypuck
https://hockeypuck.io/install-docker.html
Install Hockeypuck
cd ~/src
git clone git@github.com:brentgroves/hockeypuck.git
pushd /home/brent/src/hockeypuck/contrib/docker-compose/devel/
https://linuxhint.com/add-no-cache-option-docker-compose-build/
docker compose build --no-cache
http://reports51:11371/pks/lookup?op=stats
http://reports51:11371/pks/lookup?op=index&fingerprint=on&search=4148BE367A80A6B7D7CB08A8A9CB7B55FA3C60CA

Configure Hockeypuck
https://hockeypuck.io/configuration.html
Edit the configuration file in ./etc/hockeypuck.conf as necessary.
https://github.com/hockeypuck/hockeypuck/blob/master/contrib/docker-compose/standalone/hockeypuck/etc/hockeypuck.conf.tmpl

[hockeypuck]
loglevel="INFO"
indexTemplate="/hockeypuck/lib/templates/index.html.tmpl"
vindexTemplate="/hockeypuck/lib/templates/index.html.tmpl"
statsTemplate="/hockeypuck/lib/templates/stats.html.tmpl"
webroot="/hockeypuck/lib/www"
hostname="${FQDN}"
contact="${FINGERPRINT}"

1.6.2.1. Protocol and network options
[hockeypuck.conflux.recon]
allowCIDRs=["172.20.88.0/22"]      # default is []
filters=["yminsky.dedup"]      # default is []
allowCIDRs=["10.0.0.1/8"]      # default is []
filters=["yminsky.dedup"]      # default is []

allowCIDRS is used to allow incoming recon connections from remote addresses other than the defined peers. This is especially useful when inbound connections to Hockeypuck are subject to NAT (some cloud providers do this). If not specified, inbound connections are only allowed from partner IP addresses.

pushd /home/brent/src/hockeypuck/contrib/docker-compose/devel/etc/

# Populate with a keydump
Populate the ./keydump/ directory with a keydump, e.g. from a location listed in the KeydumpSources.

https://github.com/SKS-Keyserver/sks-keyserver/wiki/KeydumpSources
SKS is the OpenPGP keyserver. Hockpuck leverages the SKS infrastructure downloading from SKS key dump sources.
This directory will contain the `*.pgp` files from your keydump source.
get /home/brent/src/hockeypuck/contrib/docker-compose/devel/keydump/hkp-dump-0000.pgp
https://roll.urown.net/server/pgp-keyserver.html
pushd /home/brent/src/hockeypuck/contrib/docker-compose/devel/keydump
Readme.txt
Download with rsync: cd /var/lib/sks/dump && rsync -av rsync://rsync.cyberbits.eu/sks/dump/ . && shasum -c SHA256SUMS
Download with wget: cd /var/lib/sks/dump && wget -rc -e robots=off -np -nd -A pgp,txt https://mirror.cyberbits.eu/sks/dump/ && shasum -c SHA256SUMS

```
$ wget --continue \
       -r \
       --page-requisites \
       --execute robots=off \
       --timestamping \
       --level=1 \
       --cut-dirs=3 \
       --no-host-directories \
       https://mirror.cyberbits.eu/sks/dump/
       <!-- http://keys.niif.hu/keydump/ Timeout-->
       <!-- https://keyserver.mattrude.com/dump/2018-02-13/ -->
```
# Start the service
Run the docker images:
pushd /home/brent/src/hockeypuck/contrib/docker-compose/devel/
https://linuxize.com/post/how-to-use-linux-screen/
screen sudo -sH
-s, --shell
-H, --set-home
Ctrl+a " // list screen sessions
docker compose up -d
This will first import the keydump; expect this to take a day at least. To follow the progress or see error messages, use:
docker compose logs --follow
Ctrl+a d  // detach from screen session
screen -r // reattach to your screen session
http://localhost:11371
http://dockerhost:11371

docker compose logs --follow

docker exec -it 8c3a337c245d bash
docker exec -it devel-hockeypuck bash

local     devel_hkp_data
local     devel_pg_data--search-keys moto.groves@gmail.com

docker volume inspect devel_pg_data
docker exec -it devel-hockeypuck-1 bash
4957dd31bb1e


/usr/bin/gpg --homedir /home/tom/.my_app/.gnupg --no-permission-warning --keyserver pgp.mit.edu --recv-keys brent@moto

/usr/bin/gpg --homedir /home/brent/.gnupg --no-permission-warning --keyserver reports51 --search-keys brent@moto
