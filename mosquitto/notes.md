http://www.steves-internet-guide.com/mosquitto-broker/

sudo service mosquitto stop
sudo systemctl stop mosquitto.service

http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/


http://www.steves-internet-guide.com/mossquitto-conf-file/

listener 1883
protocol mqtt
allow_anonymous true
persistence true
persistence_location /mosquitto/data/
log_dest file /mosquitto/log/mosquitto.log