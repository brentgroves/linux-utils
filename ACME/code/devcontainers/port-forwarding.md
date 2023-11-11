# enable port forwarding for all interfaces not just localhost
https://stackoverflow.com/questions/67983378/specify-listening-address-0-0-0-0-for-forwarded-port-in-vscode-remote-containers
Update to Ubuntu comment made earlier:
If you don't change the Remote: Local Port Host setting then vscode will only listen on 127.0.0.1 and not on its public ip address
```
sudo lsof -nP -iTCP:5432 | grep LISTEN
code    76068 brent   42u  IPv4 1089447      0t0  TCP 127.0.0.1:5432 (LISTEN)
```
**![forward](https://i.stack.imgur.com/oM0zl.png)**
- Manage settings and type forward 
- go to the remote extension settings
- change Remote: Local Port Host from localhost to all interfaces.
As of vscode 1.79.2 vscode has the Remote: Local Port Host setting when running on Ubuntu 22.04 and the "appPort": ["5432:5432"] setting is not allowed in the devcontainer.json file. After the setting is changed in vscode and the container is rebuilt vscode will listen on all interfaces not just 127.0.0.1
```
sudo lsof -nP -iTCP:5432 | grep LISTEN
code    76068 brent   42u  IPv4 1216443      0t0  TCP *:5432 (LISTEN)
```