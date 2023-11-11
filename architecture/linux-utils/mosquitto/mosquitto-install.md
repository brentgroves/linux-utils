https://hub.docker.com/_/eclipse-mosquitto


https://mosquitto.org/download/
sudo apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
sudo apt-get update
sudo apt-get install mosquitto
For clients only:
sudo apt  install mosquitto-clients

http://www.steves-internet-guide.com/mosquitto-broker/

http://www.steves-internet-guide.com/mossquitto-conf-file/

listener 1883
protocol mqtt
allow_anonymous true
persistence true
persistence_location /etc/mosquitto/data/
log_dest file /etc/mosquitto/log/mosquitto.log
