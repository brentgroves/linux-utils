https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/

Adding PPA Repositories
Personal Package Archives (PPA) is a service that allows users to upload Ubuntu source packages that are built and published with Launchpad as an apt repository.

When adding a PPA repository the add-apt-repository command creates a new file under the /etc/apt/sources.list.d/ directory.
For example, to add the Jonathon F’s PPA which provides FFmpeg version 4.x you would run:

sudo add-apt-repository ppa:jonathonf/ffmpeg-4
Copy
When prompted press Enter an the repository will be enabled.

Press [ENTER] to continue or Ctrl-c to cancel adding it.
Copy
The PPA repository public key will be automatically downloaded and registered.

Once the PPA is added to your system you can install the repository packages:

sudo apt install ffmpeg
Copy
The apt command will install the package and all its dependencies.
