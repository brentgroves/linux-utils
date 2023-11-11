thank you Father for this beautiful day.
go to jdbc-test for an ETL example.

https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-22-04

Execute the following command to install the JRE from OpenJDK 11:

sudo apt install default-jre
The JRE will allow you to run almost all Java software.

Verify the installation with:

java -version
You’ll receive output similar to the following:

Output
openjdk version "11.0.14" 2022-01-18
OpenJDK Runtime Environment (build 11.0.14+9-Ubuntu-0ubuntu2)
OpenJDK 64-Bit Server VM (build 11.0.14+9-Ubuntu-0ubuntu2, mixed mode, sharing)
You may need the JDK in addition to the JRE in order to compile and run some specific Java-based software. To install the JDK, execute the following command, which will also install the JRE:

sudo apt install default-jdk
Verify that the JDK is installed by checking the version of javac, the Java compiler:

javac -version
You’ll see the following output:

Output
javac 11.0.14
Next, you’ll learn how to install Oracle’s official JDK and JRE.


Step 3 — Setting the JAVA_HOME Environment Variable
Many programs written using Java use the JAVA_HOME environment variable to determine the Java installation location.

To set this environment variable, first determine where Java is installed. Use the update-alternatives command:

sudo update-alternatives --config java
We only have OpenJRE installed so we get: 
There is only one alternative in link group java (providing /usr/bin/java): /usr/lib/jvm/java-11-openjdk-amd64/bin/java

This command shows each installation of Java along with its installation path:

Output
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                         Priority   Status
------------------------------------------------------------
  0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java   1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java   1111      manual mode
* 2            /usr/lib/jvm/java-11-oracle/bin/java          1091      manual mode

Press <enter> to keep the current choice[*], or type selection number:
In this case the installation paths are as follows:

OpenJDK 11 is located at /usr/lib/jvm/java-11-openjdk-amd64/bin/java.
Oracle Java is located at /usr/lib/jvm/java-11-oracle/jre/bin/java.
Copy the path from your preferred installation. Then open /etc/environment using nano or your favorite text editor:

sudo nano /etc/environment
At the end of this file, add the following line, making sure to replace the highlighted path with your own copied path, and to not include the bin/ portion of the path:

We put this in exports.zh so we don't have to put it into /etc/environment:
/etc/environment
JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
Modifying this file will set the JAVA_HOME path for all users on your system.
Save the file and exit the editor.
Now reload this file to apply the changes to your current session:

source /etc/environment
Verify that the environment variable is set:

echo $JAVA_HOME
You’ll see the path you just set:

Output
/usr/lib/jvm/java-11-openjdk-amd64
Other users will need to execute the command source /etc/environment or log out and log back in to apply this setting.

https://howtodoinjava.com/java/basics/java-classpath/
# jar files in this path will be accessible to all programs
export CLASSPATH=/usr/lib/jvm/ext/*.jar

