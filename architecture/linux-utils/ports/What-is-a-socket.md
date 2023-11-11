https://www.penguintutor.com/linux/network-services-ports

Penguin Tutor LogoGoogle Ads
Third party cookies may be stored when visiting this site. Please see the cookie information.
 
PenguinTutor YouTube Channel

HomeLearn LinuxLearn ElectronicsRaspberry PiProgrammingProjectsLPI certificationNews & Reviews
Learn Linux : 
Linux TutorialsCyberSecurity (PenguinFortress)
TCP and UDP port numbers (/etc/services) quick reference
Whilst the IP address provides the connection to the correct machine, it cannot distinguish the different service that is required. The port is used to distinguish the application. It is a value from 0 to 65535. The combination of IP address, port and protocol is called a socket, and has to be unique for every service. The port numbers area available for both TCP and UDP, and when referred to in conjunction with the IP address it specifies the "socket".

The first 1000 ports are reserved for specific applications, and on Linux can normally own be used by a daemon / application that has super user privileges. These are referred to as well known ports. Some are defined in RFC 1340, and more are defined by IANA.

Details of the reserved ports are listed on most systems in the /etc/services file, an example of which is shown below (taken from a Ubuntu Linux distribution).

/etc/services
