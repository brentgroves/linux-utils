https://itsfoss.com/ppa-guide/#comments

What is PPA?
PPA stands for Personal Package Archive. The PPA allows application developers and Linux users to create their own repositories to distribute software. With PPA, you can easily get newer software version or software that are not available via the official Ubuntu repositories.

Does that make sense? Probably not.

Before you understand PPA, you should know the concept of repositories in Linux. I won’t go into details here though.

Concept of repositories and package management
A repository is a collection of files that has information about various software, their versions and some other details like the checksum. Each Ubuntu version has its own official set of four repositories:

Main – Canonical-supported free and open-source software.
Universe – Community-maintained free and open-source software.
Restricted – Proprietary drivers for devices.
Multiverse – Software restricted by copyright or legal issues.
You can see such repositories for all Ubuntu versions here. You can browse through them and also go to the individual repositories. For example, Ubuntu 16.04 main repository can be found here.

So basically it’s a web URL that has information about the software. How does your system know where are these repositories?

This information is stored in the sources.list file in the directory /etc/apt. If you look at its content, you’ll see that it has the URL of the repositories. The lines with # at the beginning are ignored.

Now when you run the command sudo apt update, your system uses APT tool to check against the repo and stores the information about the software and their version in a cache. When you use the command sudo apt install package_name, it uses the information to get that package from the URL where the actual software is stored.

If the repository doesn’t have the information about a certain package, you’ll see unable to locate package error:

E: Unable to locate package
At this point, I recommend reading my guide to using apt commands. This will give you a much better understanding of apt commands, update etc.

So this was about repositories. But what is PPA? How does it enter into the picture?

Why is PPA used?
As you can see, Ubuntu controls what software and more importantly which version of a software you get on your system. But imagine if a software developer releases a new version of the software.

Ubuntu won’t make it available immediately. There is a procedure to check if the new version of the software is compatible with the system or not. This ensures the stability of the system.

But this also means that it will be some weeks or in some cases, some months before it is made available by Ubuntu. Not everyone would want to wait that long to get their hands on the new version of their favorite software.

Similarly, suppose someone develops a software and wants Ubuntu to include that software in the official repositories. It again will take months before Ubuntu makes a decision and includes it in the official repositories.

Another case would be during  beta testing. Even if a stable version of the software is available in the official repositories, a software developer may want some end users to test their upcoming release. How do they enable the end user to beta test the upcoming release?

Enter PPA!

How to use PPA? How does PPA work?
PPA, as I already told you, means Personal Package Archive. Mind the word ‘Personal’ here. That gives the hint that this is something exclusive to a developer and is not officially endorsed by the distribution.

Ubuntu provides a platform called Launchpad that enables software developers to create their own repositories. An end user i.e. you can add the PPA repository to your sources.list and when you update your system, your system would know about the availability of this new software and you can install it using the standard sudo apt install command like this.

sudo add-apt-repository ppa:dr-akulavich/lighttable
sudo apt-get update
sudo apt-get install lighttable-installer
To summarize:

sudo add-apt-repository <PPA_info> <– This command adds the PPA repository to the list.
sudo apt-get update <– This command updates the list of the packages that can be installed on the system.
sudo apt-get install <package_in_PPA> <– This command installs the package.
You see that it is important to use the command sudo apt update or else your system will not know when a new package is available. Ubuntu 18.04 and higher versions automatically run the update to refresh the list of packages but I cannot vouch for other distributions. It’s a good practice to run this command.

Now let’s take a look at the first command in a bit more detail.

sudo add-apt-repository ppa:dr-akulavich/lighttable
You would notice that this command doesn’t have a URL to the repository. This is because the tool has been designed to abstract the information about URL from you.

Just a small note. If you add ppa:dr-akulavich/lighttable, you get Light Table. But if you add ppa:dr-akulavich, you’ll get all the repository or packages mentioned in the ‘upper repository’. It’s hierarchical.

Basically, when you add a PPA using add-apt-repository, it will do the same action as if you manually run these commands:

deb http://ppa.launchpad.net/dr-akulavich/lighttable/ubuntu YOUR_UBUNTU_VERSION_HERE main
deb-src http://ppa.launchpad.net/dr-akulavich/lighttable/ubuntu YOUR_UBUNTU_VERSION_HERE main
The above two lines are the traditional way to add any repositories to your sources.list. But PPA does it automatically for you, without wondering about the exact repository URL and operating system version.

One important thing to note here is that when you use PPA, it doesn’t change your original sources.list. Instead, it creates two files in /etc/apt/sources.list.d directory, a list and a back up file with suffix ‘save’.

This is a safety measure to ensure that adding PPAs doesn’t mess with the original sources.list. It also helps in removing the PPA.

Why PPA? Why not DEB packages?
You may ask why you should use PPA when it involves using the command line which might not be preferred by everyone. Why not just distribute a DEB package that can be installed graphically?

The answer lies in the update procedure. If you install software using a DEB package, there is no guarantee that the installed software will be updated to a newer version when you run sudo apt update && sudo apt upgrade.

It’s because the apt upgrade procedure relies on the sources.list. If there is no entry for software, it doesn’t get the update via the standard software updater.

So does it mean software installed using DEB never gets an update? No, not really. It depends on how the package was created.

Some developers automatically add an entry to the sources.list and then it is updated like regular software. Google Chrome is one such example.

Some software would notify you of the availability of a new version when you try to run it. You’ll have to download the new DEB package and run it again to update the current software to a newer version. Oracle Virtual Box is an example in this case.

For the rest of the DEB packages, you’ll have to manually look for an update and this is not convenient, especially if your software is meant for beta testers. You need to add more updates frequently. This is where PPA come to the rescue.

Official PPA vs unofficial PPA
You may also hear the term official PPA or unofficial PPA. What’s the difference?

When developers create PPA for their software, it is called the official PPA. Quite obviously, because it is coming from none other than the project developers.

But at times, individuals create PPA of projects that were created by other developers.

Why would someone do that? Because many developers just provide the source code of the software and you know that installing software from source code in Linux is a pain and not everyone could or would do that.

This is why volunteers take it upon themselves to create a PPA from those source code so that other users can install the software easily. After all, using those 3 lines is a lot easier than battling the source code installation.

Make sure that a PPA is available for your distribution version
When it comes to using PPA in Ubuntu or any other Debian based distribution, there are a few things you should keep in mind.

Not every PPA is available for your particular version. You should know which Ubuntu version you are using. The codename of the release is important because when you go to the webpage of a certain PPA, you can see which Ubuntu versions are supported by the PPA.

For other Ubuntu-based distributions, you can check the content of /etc/os-release to find out the Ubuntu version information.