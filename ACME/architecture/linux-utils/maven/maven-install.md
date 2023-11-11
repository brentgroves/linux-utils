Installing Maven on Linux/Ubuntu
We will install Maven in a similar way that we have installed JDK in the Linux system.

pushd .
cd ~/Downloads
popd
# install from apt
https://www.hostinger.com/tutorials/how-to-install-maven-on-ubuntu
How to Install Apache Maven on Ubuntu 22.04
Before installing Apache Maven, your system must meet the following requirements:

User with sudo privileges
OpenJDK 1.7 or above installed on your computer or virtual private server

Users can install Apache Maven using the Advanced Package Tool (APT) or through the official Apache Maven website.

Let’s start with the APT method.

Method 1. Install Apache Maven on Ubuntu 22.04 Using APT
The official Ubuntu repositories contain Maven packages by default. Thus, the most convenient way to install Apache Maven is by using the APT package manager.

However, the Maven package version in Ubuntu repositories may differ from the official one. It may also not be the latest release.

Update the package index with the following Linux command:
sudo apt-get update
Install OpenJDK:
sudo apt install default-jdk
Verify the installation by running the following command:
java -version
The terminal window displays version of newly installed OpenJDK that is necessary to install Maven
Install Maven using the command below:
sudo apt-get -y install maven
The default Maven installation directories are /usr/share/maven and /etc/maven. Verify the Apache Maven version using the following command:

mvn -version
The terminal window displays the successful installation of the latest version of Apache Maven
If you see a similar window, you’ve successfully installed Apache Maven on your machine.
update-alternatives: using /usr/share/maven/bin/mvn to provide /usr/bin/mvn (mvn) in auto mode
I did not use update alternatives although the following command works:
update-alternatives --list mvn
http://dev-maziarz.blogspot.com/2012/09/ubuntu-1204-installing-both-maven3-and.html

https://gist.github.com/rubenghio/4693802
[rghio@localhost ~]$ su -

[root@localhost ~]$ alternatives --install /usr/bin/mvn mvn ${MAVEN_HOME_2}/bin/mvn 120

[root@localhost ~]$ alternatives --install /usr/bin/mvn mvn ${MAVEN_HOME_3}/bin/mvn 120

[root@localhost ~]$ alternatives --config mvn

There are 2 programs which provide 'mvn'.

  Selection    Command
-----------------------------------------------
*+ 1           /opt/apache-maven-2.2.1/bin/mvn
   2           /opt/apache-maven-3.0.4/bin/mvn

[rghio@localhost ~]$ mvn --version
Apache Maven 2.2.1 (r801777; 2009-08-06 16:16:01-0300)
Java version: 1.7.0_11
Java home: /usr/java/jdk1.7.0_11/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux" version: "3.7.4-204.fc18.x86_64" arch: "amd64" Family: "unix"

[root@localhost ~]$ alternatives --config mvn

There are 2 programs which provide 'mvn'.

  Selection    Command
-----------------------------------------------
*+ 1           /opt/apache-maven-2.2.1/bin/mvn
   2           /opt/apache-maven-3.0.4/bin/mvn

Enter to keep the current selection[+], or type selection number: 2

[root@localhost ~]$ mvn --version
Apache Maven 3.0.4 (r1232337; 2012-01-17 05:44:56-0300)
Maven home: /opt/apache-maven-3.0.4
Java version: 1.7.0_11, vendor: Oracle Corporation
Java home: /usr/java/jdk1.7.0_11/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "3.7.4-204.fc18.x86_64", arch: "amd64", family: "unix"

# install from website 
Method 2. Install Maven on Ubuntu Using the Official Website
The second method is to install Maven from the official Apache website.

Java Installation

Enter the following commands to update the package index and install the default OpenJDK package.
sudo apt-get update

sudo apt install default-jdk
The installation might take a few minutes to complete.

Verify the OpenJDK version using the following command:
java -version
The terminal will display the installed Java version.

Download Apache Maven

Open the Maven official page to check the latest release. At the time of writing, the latest release is 3.8.7. Download it using the wget command to the /tmp Maven installation directory:
wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz -P /tmp
Extract the newly downloaded tar.gz file to the /opt directory with the following command:
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
To ensure Maven works properly, configure a few environment variables, including JAVA_HOME, M3_HOME, MAVEN_HOME, and PATH. To do this, create a file named Maven.sh inside /etc/profile.d/ directory with your preferred text editor.
sudo nano /etc/profile.d/maven.sh
Fill in the file with the following environment variables: export JAVA_HOME=/usr/lib/jvm/default-java
export JAVA_HOME=/usr/lib/jvm/default-java
export M3_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M3_HOME}/bin:${PATH}
Save this file and provide the required execute privileges:
sudo chmod +x /etc/profile.d/maven.sh
Refresh and execute the file with the following command:
source /etc/profile.d/maven.sh
Confirm the Maven installation by checking its version with the following command:
mvn -version

# install from website
https://www.digitalocean.com/community/tutorials/install-maven-linux-ubuntu
Step 1: Download the Maven Binaries
Go to the URL: https://maven.apache.org/download.cgi Copy the link for the “Binary tar.gz archive” file. Then run the following commands to download and untar it.
$ wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
$ tar -xvf apache-maven-3.6.3-bin.tar.gz
$ mv apache-maven-3.6.3 /opt/
Step 2: Setting M2_HOME and Path Variables
Add the following lines to the user profile file (.profile).

M2_HOME='/opt/apache-maven-3.6.3'
PATH="$M2_HOME/bin:$PATH"
export PATH
Relaunch the terminal or execute source .profile to apply the changes.

Step 3: Verify the Maven installation
Execute mvn -version command and it should produce the following output.

$ mvn -version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /opt/apache-maven-3.6.3
Java version: 13.0.1, vendor: Oracle Corporation, runtime: /opt/jdk-13.0.1
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.15.0-47-generic", arch: "amd64", family: "unix"
$
That’s all. Maven is successfully installed in your Linux system.