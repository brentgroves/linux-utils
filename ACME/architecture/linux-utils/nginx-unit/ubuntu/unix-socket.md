https://stackoverflow.com/questions/55585586/how-to-access-control-unit-sock-with-nginx-for-securely-proxying-unit-api

control.unit.sock

# Stack Overflow question
I'm trying to use Nginx as proxy to access control.unit.sock (Nginx Unit) as it is recommended here : Securely Proyxing Unit Api. But Nginx is not able to access the socket.

I use the default configuration for Unit. unix:control.unit.sock is created as root with 600 permissions. Nginx uses the user : www-data by default.

How can I give Nginx access to this socket securely ? By avoid opening sockets on public interfaces in production or something else. (For sure, Nginx has access if I set permission as 777.)

server {
    location / {
        proxy_pass http://unix:/var/run/control.unit.sock;
    }
}

You can consider to run Unit with --control option and specify address that you want use (e.g. --control 127.0.0.1:8080).

Documentation https://unit.nginx.org/installation/#installation-startup:

--control socket
Address of the control API socket. IPv4, IPv6, and Unix domain sockets are supported.


