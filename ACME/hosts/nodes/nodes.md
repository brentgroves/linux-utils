# port mappings
 <!-- The range of valid ports is 30000-32767 -->
IP              node        mysql   mosquitto mongodb
10.1.0.116      reports01   30001   30201
10.1.0.117      reports02   30002   30202
10.1.0.118      reports03   30003   30203
10.1.0.116      reports41   30041   30241     30341  
10.1.0.117      reports42   30042   30242     30342  
10.1.0.118      reports43   30043   30243     30343  


10.1.0.120      devcon2
10.1.0.14 mgalb-hv1.busche-cnc.com
10.1.0.12/ui
10.1.12.8 
   IPv4 Address. . . . . . . . . . . : 10.1.1.151
   Subnet Mask . . . . . . . . . . . : 255.255.252.0
   Subnet 10.1.0.0/22
   Default Gateway . . . . . . . . . : 10.1.1.205
https://mayastor.gitbook.io/introduction/reference/kubectl-plugin
Prerequisites
Ensure that port 30011 is open. This port will be needed by Mayastor kubectl plugin to communicate to REST servers from outside the cluster.


10.1.0.110      reports11   30011   30211     30311
10.1.0.111      reports12   30012   30212     30312
10.1.0.112      reports13   30013   30213     30313
172.20.88.61    reports31   30031   30231     30331
172.20.88.62    reports32   30032   30232     30332
172.20.88.63    reports33   30033   30233     30332
172.20.88.64    reports-avi # dev system
172.20.88.65    reports51   30051   30251     30351
172.20.88.66    reports52   30052   30252     30352
172.20.88.67    reports53   30053   30253     30353
172.20.88.68    reports54   30054   30254     30354


10.1.0.120      alb-ubu     30101   30111
172.20.88.16    avi-ubu     30102   30112
172.20.1.190    frt-ubu     30103   30113
10.1.1.83       moto        31008   30108

