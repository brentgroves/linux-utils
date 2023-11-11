<https://nmap.org/book/port-scanning-tutorial.html>
<https://www.techrepublic.com/article/how-to-scan-for-ip-addresses-on-your-network-with-linux/>
sudo snap install nmap
sudo apt-get install nmap -y

Once the installation completes, you are ready to scan your LAN with nmap. To find out what addresses are in use, issue the command:

nmap -sP 172.20.88.0/22
nmap -sP 10.1.0.0/22
nmap 172.20.88.115
<https://172.20.88.115-118>

Note: You will need to alter the IP address scheme to match yours.

The output of the command (Figure B), will show you each address found on your LAN.

sudo nmap -vv -sS -O -n 172.20.88.0/22

While this simple command is often all that is needed, advanced users often go much further. In Example 4.3, the scan is modified with four options. -p0- asks Nmap to scan every possible TCP port, -v asks Nmap to be verbose about it, -A enables aggressive tests such as remote OS detection, service/version detection, and the Nmap Scripting Engine (NSE). Finally, -T4 enables a more aggressive timing policy to speed up the scan.

nmap p0- -v -A -T4 172.20.88.115
