https://itsfoss.com/ubuntu-repositories/

The concept of repositories in Ubuntu
Okay, so you already know that to install software in Ubuntu, you can use the apt command. This is the same APT package manager that Ubuntu Software Center utilizes underneath. So all the software (except Snap packages) that you see in the Software Center are basically from APT.

Have you ever wondered where does the apt program install the programs from? How does it know which packages are available and which are not?

Apt basically works on the repository. A repository is nothing but a server that contains a set of software. Ubuntu provides a set of repositories so that you won’t have to search on the internet for the installation file of various software of your need. This centralized way of providing software is one of the main strong points of using Linux.

**![repo](https://itsfoss.com/content/images/2023/02/image-1.png)**
The APT package manager gets the repository information from the /etc/apt/sources.list file and files listed in /etc/apt/sources.list.d directory. Repository information is usually in the following format:

deb http://us.archive.ubuntu.com/ubuntu/ bionic main

In fact, you can go to the above server address and see how the repository is structured.

When you update Ubuntu using the apt update command, the apt package manager gets the information about the available packages (and their version info) from the repositories and stores them in local cache. You can see this in /var/lib/apt/lists directory.

Keeping this information locally speeds up the search process because you don’t have to go through the network and search the database of available packages just to check if a certain package is available or not.

Now you know how repositories play an important role, let’s see why there are several repositories provided by Ubuntu.

Ubuntu Repositories: Main, Universe, Multiverse, Restricted and Partner

Software in Ubuntu repository are divided into five categories: main, universe, multiverse, restricted and partner.

Why Ubuntu does that? Why not put all the software into one single repository? To answer this question, let’s see what are these repositories:

Main
When you install Ubuntu, this is the repository enabled by default. The main repository consists of only FOSS (free and open source software) that can be distributed freely without any restrictions.

Software in this repository are fully supported by the Ubuntu developers. This is what Ubuntu will provide with security updates until your system reaches end of life.

Universe
This repository also consists free and open source software but Ubuntu doesn’t guarantee of regular security updates to software in this category.

Software in this category are packaged and maintained by the community. The Universe repository has a vast amount of open source software and thus it enables you to have access to a huge number of software via apt package manager.

Multiverse
Multiverse contains the software that is not FOSS. Due to licensing and legal issues, Ubuntu cannot enable this repository by default and cannot provide fixes and updates.

It’s up to you to decide if you want to use the Multiverse repository and check if you have the right to use the software.

Restricted
Ubuntu tries to provide only free and open source software but that’s not always possible specially when it comes to supporting hardware.

The restricted repositories consist of proprietary drivers.

Partner
This repository consists of proprietary software packaged by Ubuntu for their partners. Earlier, Ubuntu used to provide Skype through this repository. This repository is going to be discontinued in the futire versions of Ubuntu as it moves towards snap packaging.

Third party repositories and PPA (Not provided by Ubuntu)
The above five repositories are provided by Ubuntu. You can also add third-party repositories (it’s up to you if you want to do it) to access more software or to access newer version of a software (as Ubuntu might provide old version of the same software).

For example, if you add the repository provided by VirtualBox, you can get the latest version of VirtualBox. It will add a new entry in your sources.list.

You can also install additional application using PPA (Personal Package Archive). I have written about what is PPA and how it works in detail so please read that article.

Add universe, multiverse and other repositories
As of now, you should have the main, and universe repositories enabled by default. But, if you want to enable additional repositories through the terminal, here are the commands to do that:

To enable Universe repository, use:

sudo add-apt-repository universe
To enable Restricted repository, use:

sudo add-apt-repository restricted
To enable Multiverse repository, use this command:

sudo add-apt-repository multiverse
You must use sudo apt update command after adding the repository so that your system creates the local cache with package information.

If you want to remove a repository, simply add -r like sudo add-apt-repository -r universe.

https://packages.ubuntu.com/?ref=itsfoss.com
Bonus Tip: How to know which repository a package belongs to?
Ubuntu has a dedicated website that provides you with information about all the packages available in the Ubuntu archive. Go to Ubuntu Packages website.

Ubuntu Packages
You can search for a package name in the search field. You can select if you are looking for a particular Ubuntu release or a particular repository. I prefer using ‘any’ option in both fields.

