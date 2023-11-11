https://hub.docker.com/_/eclipse-mosquitto

uses the Alpine OS

Three directories have been created in the image to be used for configuration, persistent storage and logs.

/mosquitto/config
/mosquitto/data
/mosquitto/log


docker pull eclipse-mosquitto:2.0.15

docker run -it -p 1883:1883 -p 9001:9001 -v mosquitto.conf:/mosquitto/config/mosquitto.conf -v /mosquitto/data -v /mosquitto/log eclipse-mosquitto

Configuration
When running the image, the default configuration values are used. To use a custom configuration file, mount a local configuration file to /mosquitto/config/mosquitto.conf

$ docker run -it -p 1883:1883 -p 9001:9001 -v mosquitto.conf:/mosquitto/config/mosquitto.conf eclipse-mosquitto