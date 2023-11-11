# change config
https://github.com/nginx/unit/issues/283
sudo curl -X PUT --data-binary @unit.config.python --unix-socket /var/run/control.unit.sock http://localhost/config
# output
{
	"success": "Reconfiguration done."
}
# get config
sudo curl --unix-socket /var/run/control.unit.sock http://localhost/config/

# test
curl http://localhost:8400/

