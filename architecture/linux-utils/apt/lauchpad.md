https://launchpad.net/~mc3man/+archive/ubuntu/trusty-media
Ubuntu Multimedia for Trusty
PPA description
Upgraded, advanced or not normally available multimedia packages for Trusty
Xenial users go here - https://launchpad.net/~mc3man/+archive/ubuntu/xerus-media

*Please note that if using this ppa I would *not* try upgrading to 14.10/15.04, ect. Do a fresh install instead. The intent here is just for users wishing to stay on 14.04*

If upgrading releases anyway use ppa-purge *First* -
sudo ppa-purge ppa:mc3man/trusty-media

Also note that using this ppa then disabling may cause issue for installing i386 packages like used by wine. So once enabled leave enabled or purge before removing.

Additionally if using apt-get * sudo apt-get dist-upgrade will be needed* at times.(pay attention). Otherwise package managers may be ok.

So typically to enable & first use -
sudo add-apt-repository ppa:mc3man/trusty-media
sudo apt-get update
sudo apt-get dist-upgrade

https://code.launchpad.net/hockeypuck

Packages in Distributions
hockeypuck source package in Xenial
Version 1.0~rel20140413+7a1892a~trusty.1 uploaded on 2014-09-03
hockeypuck source package in Trusty
Version 1.0~rel20140413+7a1892a~trusty uploaded on 2014-04-14
hockeypuck source package in Bionic
Version 1.0~rel20140413+7a1892a~trusty.1 uploaded on 2014-09-03

https://launchpad.net/~mc3man/+archive/ubuntu/xerus-media
