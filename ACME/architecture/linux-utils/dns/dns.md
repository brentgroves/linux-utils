Hello,
Please consider the following request to make reporting easier from Microsoft Teams.
A Power BI report hosted on Microsoft Teams needs a public endpoint to connect to our internal data warehouses to work. We can make this connection more secure by having the public and private keys to the TLS certificate for mobexglobal.com. Both the TLS public and private keys would be added to our k8s Nginx ingress controllers in order to perform TLS termination before passing the network traffic to the data warehouses. In order to make this work we also need port forwarding to the following k8s nodes hosting MySQL databases:
10.1.0.120 alb-ubu 30101
172.20.88.16 avi-ubu 30102
172.20.1.190 frt-ubu 30103
10.1.0.116 reports01 30001
10.1.0.117 reports02 30002
10.1.0.118 reports03 30003
10.1.0.110 reports11 30011
10.1.0.111 reports12 30012
10.1.0.112 reports13 30013
172.20.88.61 reports31 30031
172.20.88.62 reports32 30032
172.20.88.63 reports33 30033

Thank you for considering this request!
