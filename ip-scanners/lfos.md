https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/
sudo lsof -i -P -n

sudo lsof -i -P -n | grep :80  