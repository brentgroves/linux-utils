https://ar.al/2022/08/30/dear-linux-privileged-ports-must-die/

# allow unprivileged access to port <=1024
The workaround
On modern Linux systems, you can configure privileged ports using sysctl:

sudo sysctl -w net.ipv4.ip_unprivileged_port_start=80
However, that setting does not survive a reboot.

You can also configure the setting in a persistent way using a configuration file. e.g., by creating a file called /etc/sysctl.d/99-reduce-unprivileged-port-start-to-80.conf with the following content:

net.ipv4.ip_unprivileged_port_start=80

echo "net.ipv4.ip_unprivileged_port_start=80" | sudo tee -a /etc/sysctl.d/99-reduce-unprivileged-port-start-to-80.conf >/dev/null

After making any changes, please run "service procps force-reload" (or, from
a Debian package maintainer script "deb-systemd-invoke restart procps.service").

To remove all privileged ports, you can set that value to 0. For our needs, 80 will do as it means our web server can bind to ports 80 and 443 without requiring superuser privileges.

In fact, the Kitten installer does just this.

But even that has issues.

For one thing, it doesn’t work in rootless containers (e.g., if you’re running on an “immutable” Linux distribution like Fedora Silverblue2) because the configuration file gets added to the container, which doesn’t have systemd running sysctl.d so the configuration setting doesn’t get applied at boot.

So we’re back to having to gain temporary privileges and drop them just to alter this configuration setting every time the server is run.

What a pain in the ass.

The fix
The fix is easy: ship Linux distributions so that privileged ports start from 80 to begin with.3

net.ipv4.ip_unprivileged_port_start=80
Sure, this could also be set to zero but setting it to 80 would fix the number one use case today, which is to allow web servers to bind to ports 80 and 443 without requiring superuser privileges. So I’d be happy with either solution.

And for the three folks in Finland who administer multi-user Linux instances and rely on privileged ports for their mainframe-era security properties, they can always run sysctl and set their port limit to 1024 as it was before.

Yay, everyone’s happy!

