# Install screen

Note: I think this comes installed with Ubuntu 22.04 server.  

```bash
sudo apt-get install screen

# some test commands 
# create named session
screen -S frt-ubu
# detach from session
ctrl-a and d
# list sessions
screen -ls
# attach to named session
screen -r frt-ubu
# verify if attached
screen -ls
# log session
screen -L
ls ~/screenlog.*
cat ~/screelog.x 
x is a number
# kill session
screen -r frt-ubu -X quit

```
