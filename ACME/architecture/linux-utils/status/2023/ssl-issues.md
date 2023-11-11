SSL/TLS database issues:
- have seen in browsers, sql servers, mongodb.  
- problems fixed in newer SSL/TLS versions:  
```
Denial of service
Heartbleed
Man in the middle
```
- how does database clients use SSL/TLS?  
OpenSSL doesn't run in the background but if installed a database client can load the library.
- how to know which version is installed?  
Checking the versions and the status of both the frontend and the library can be done with the following command:
dpkg -l 'openssl*'
- What if I would like 2 versions of SSL/TLS installed because mssql and mongodb require older version 1.1.1  
All the available ssl versions can be found here:  
http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/?C=M;O=D

wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
                                                              libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
openssl version
or  
wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

Ubuntu 22.04 upgraded to OpenSSL 3.0  
https://askubuntu.com/questions/1403837/how-do-i-use-openssl-1-1-1-in-ubuntu-22-04  
I don't want to downgrade to version 1.1.1, but instead install 1.1.1 alongside 3.0  
**notes**
https://opensource.com/article/19/6/cryptography-basics-openssl-part-1
OpenSSL library wraps the socket infrastructure  
http://theshybulb.com/2015/10/10/use-openssl-c-library.html  
How to use OpenSSL library  
```
sudo apt-get install libssl-dev
```
when you compile your program you link to the openssl library