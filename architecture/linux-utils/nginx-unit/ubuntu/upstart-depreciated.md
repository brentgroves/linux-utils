sudo service unit status 
sudo service unit restart

To stop and start services temporarily (Does not enable / disable them for future boots), you can type service SERVICE_NAME [action]. For example:

sudo service apache2 stop: Will STOP the Apache service until Reboot or until you start it again.
sudo service apache2 start: Will START the Apache service assuming it was stopped before.
service apache2 status: Will tell you the STATUS of the service, if it is either enabled/running of disabled/NOT running.
sudo service apache2 restart: Will RESTART the service. This is most commonly used when you have changed, a config file. In this case, if you changed either a PHP configuration or an Apache configuration. Restart will save you from having to stop/start with 2 command lines
service apache2: In this case, since you did not mention the ACTION to execute for the service, it will show you all options available for that specific service. This aspect varies depending on the service, for example, with MySQL it would only mention that it is missing a parameter. For other services like networking service it would mention the small list of all options available.
