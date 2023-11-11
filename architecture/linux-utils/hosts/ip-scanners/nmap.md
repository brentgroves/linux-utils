https://www.techrepublic.com/article/how-to-scan-for-ip-addresses-on-your-network-with-linux/
sudo apt-get install nmap -y

Once the installation completes, you are ready to scan your LAN with nmap. To find out what addresses are in use, issue the command:
Avilla
nmap -sP 172.20.88.0/22
Albion
nmap -sP 10.1.0.0/22

Note: You will need to alter the IP address scheme to match yours.

The output of the command (Figure B), will show you each address found on your LAN.

