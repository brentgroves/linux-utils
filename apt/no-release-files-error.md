https://askubuntu.com/questions/866901/what-can-i-do-if-a-repository-ppa-does-not-have-a-release-file
E: The repository 'https://ppa.launchpadcontent.net/hockeypuck/daily/ubuntu jammy Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.



The PPA you've added does not support your version of Ubuntu, meaning there aren't any packages for your particular release.
W: The repository 'http://ppa.launchpad.net/mc3man/trusty-media/ubuntu xenial Release' does not have a Release file.

For example, the ppa:mc3man/trusty-media PPA is only for Trusty (Ubuntu 14.04) only (trusty-media). Obviously, it has no files for Xenial (16.04). You can check the PPA's Launchpad page to see which versions of Ubuntu are supported.

I'd suggest the following:

Remove the PPA for an older release. For this example:
sudo ppa-purge ppa:hockeypuck/daily
sudo ppa-purge ppa:mc3man/trusty-media
If there's a PPA for your curent release, add it. In this case, there's a PPA for Xenial: mc3man/xerus-media. You can add it using
sudo add-apt-repository ppa:mc3man/xerus-media
To summarize, you need to remove the added PPA, and use another one that has packages for your particular release.


# check release support for package
sudo apt-get install ppa-purge
Remove the PPA for an older release. For this example:
sudo ppa-purge ppa:mc3man/trusty-media
If there's a PPA for your curent release, add it. In this case, there's a PPA for Xenial: mc3man/xerus-media. You can add it using
sudo add-apt-repository ppa:mc3man/xerus-media
To summarize, you need to remove the added PPA, and use another one that has packages for your particular release.

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
https://launchpad.net/ubuntu/xenial/+source/hockeypuck


