http://unit.nginx.org/howto/source/#source-startup
We advise installing Unit from precompiled packages; in this case, startup is configured automatically.

Even if you install Unit otherwise, avoid manual startup. Instead, configure a service manager (OpenRC, systemd, and so on) or create an rc.d script to launch the Unit daemon using the options below.

The startup command depends on the directories you set with ./configure, but their default values place the unitd binary in a well-known place, so:

unitd RUNTIME OPTIONS
Run unitd -h or unitd --version to list Unit’s compile-time settings. Usually, the defaults don’t require overrides; still, the following runtime options are available. For their compile-time counterparts, see here.

--help, -h	Displays a summary of the command-line options and their defaults.
--version	Displays Unit’s version and the ./configure settings it was built with.
--no-daemon	Runs Unit in non-daemon mode.
--control socket	
Control API socket address in IPv4, IPv6, or UNIX domain format:

unitd --control 127.0.0.1:8080
unitd --control [::1]:8080
unitd --control unix:/path/to/control.unit.sock
--group name, --user name	Group name and user name used to run Unit’s non-privileged processes.
--log pathname	Pathname for Unit’s log.
--modules directory	Directory path for Unit’s language modules (*.unit.so files).
--pid pathname	Pathname for the PID file of Unit’s main process.
--state directory	Directory path for Unit’s state storage.
--tmp directory	Directory path for Unit’s temporary file storage.
Finally, to stop a running Unit:

pkill unitd
This command signals all Unit’s processes to terminate in a graceful manner.

