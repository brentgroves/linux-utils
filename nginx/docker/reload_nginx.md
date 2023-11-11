https://cyral.com/blog/how-to-auto-reload-nginx/

Create a new file called nginxReloader.sh that will use inotify-tools to listen for filesystem events and then automatically reload Nginx.

nginxReloader.sh
#!/bin/bash
###########

while true
do
 inotifywait --exclude .swp -e create -e modify -e delete -e move /etc/nginx/conf.d
 nginx -t
 if [ $? -eq 0 ]
 then
  echo "Detected Nginx Configuration Change"
  echo "Executing: nginx -s reload"
  nginx -s reload
 fi
done

http://blog.tobiasforkel.de/en/2016/08/18/reload-nginx-inside-docker-container/

Reload Nginx Inside Docker Container
I am using docker for Nginx which is running with multiple virtual hosts. Sometimes I have to reload my updated nginx configurations, but I don’t want restart the container each time. Here is how you can reload your nginx without any downtime and without interrupting any connections.

1. Find your container name
Use docker ps to find your nginx container.

2. Reload Nginx
With docker exec -it {container_name} {command} you can directly access your container and execute commands. In my case the name of the container is nginx-server.

$ docker exec -it nginx-server nginx -s reload
2016/08/18 09:52:38 [notice] 19#19: signal process started
1
2
$ docker exec -it nginx-server nginx -s reload
2016/08/18 09:52:38 [notice] 19#19: signal process started