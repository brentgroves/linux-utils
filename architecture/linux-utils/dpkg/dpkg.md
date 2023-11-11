https://unix.stackexchange.com/questions/195794/how-to-uninstall-a-deb-installed-with-dpkg

First of all you should check if this package is correctly installed in your system and being listed by dpkg tool:

dpkg -l '*libssl1*'
It should have an option ii in the first column of the output - that means 'installed ok installed'.
If you'd like to remove the package itself (without the configuration files), you'll have to run:
dpkg -r urserver
If you'd like to delete (purge) the package completely (with configuration files), you'll have to run:
dpkg -P urserver
You may check if the package has been removed successfully - simply run again:
dpkg -l urserver
If the package has been removed without configuration files, you'll see the rc status near the package name, otherwise, if you have purged the package completely, the output will be empty.
Just a note that you have to use the package name, not the name of the installed software. Example: dpkg -i google-chrome-stable_current_amd64.deb installs google-chrome, but to remove you must use dpkg -i google-chrome-stable, not dpkg -i google-chrome, neither dpkg -i google-chrome-stable_current_amd64.deb

moto:
un  libssl1.0-dev     <none>            <none>       (no description available)
rc  libssl1.0.0:amd64 1.0.2n-1ubuntu5.4 amd64        Secure Sockets Layer toolkit - shared libraries
un  libssl1.0.2       <none>            <none>       (no description available)
ii  libssl1.1:amd64   1.1.1f-1ubuntu2   amd64        Secure Sockets Layer toolkit - shared libraries
ii  libssl3:amd64  3.0.2-0ubuntu1.7 amd64        Secure Sockets Layer toolkit - shared libraries
ii  libssl3:i386   3.0.2-0ubuntu1.7 i386         Secure Sockets Layer toolkit - shared libraries

before python ws_to_dw-test.py
OpenSSL 1.1.1n  15 Mar 2022
after python ws_to_dw-test.py
OpenSSL 1.1.1q  5 Jul 2022

reports-avi:
ii  libssl1.1:amd64   1.1.1f-1ubuntu2   amd64        Secure Sockets Layer toolkit - shared libraries
ii  libssl3:amd64  3.0.2-0ubuntu1.7 amd64        Secure Sockets Layer toolkit - shared libraries


dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
dpkg -r libssl1.1
dpkg -P libssl1.1