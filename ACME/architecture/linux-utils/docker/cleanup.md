https://middleware.io/blog/docker-cleanup/
docker  system prune

docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq) 
docker rmi $(docker images -q) -f
docker volume ls  
docker volume prune --all
docker volume rm vol_name vol_name2  
docker network ls
# remove networks created more that 5 minutes ago
docker network prune --force --filter until=5m
Note that system networks such as bridge, host, and none will never be pruned:
docker network prune 
docker network rm [networkID] 
https://docs.docker.com/engine/reference/commandline/builder_prune/
docker builder prune --all
Installing honnef.co/go/tools/cmd/staticcheck@v0.3.3 (/home/vscode/go/bin/staticcheck
If you get errors, remove the containers using the network.
Remove unnecessary Docker files via Docker command line tool in Linux systems.

Docker packages software into a complete filesystem with everything needed to run it: code, runtime, system tools, system libraries – anything you can install on a server. It helps run software anywhere, regardless of its environment. 

However, when working with Docker, you can end up piling up unused images, containers, and datasets that clutter the output and take up disk space. The good news is that Docker offers useful tools to help you clean up your system and stay organized.

Finding the right information on Docker cleanup can be a little back-breaking. This is essential when you completely remove an image from your system or reduce your project’s size to fit a shared host. So how do you get started?

This quick tutorial shows the different ways to rid your system of unused and unnecessary Docker files and enable smoother system performance.

Docker prune command
Docker has a single command that cleans up all dangling resources, such as images, containers, volumes, and networks, not tagged or connected to a container.



The Docker prune command automatically removes the resources not associated with a container. This is a quick way to get rid of old images, containers, volumes, and networks.

You can use additional indicators with this command:

Add -a to display all resources, and -q to display only ID
Add -f to bypass confirmation dialog

How to clean up Docker resources
When cleaning up Docker, first check all the available resources using the following commands:


docker  container ls
docker  image ls
docker  volume ls
docker  network ls
docker  info

Delete all these resources one by one.

1. Removing Docker images
Put simply, a Docker image is a template that includes the program and all the dependencies (multi-layered files to run programs within a container) needed to run it on Docker.

While producing an image, it can go through several revisions. Old and outdated images clog up your system, eating up storage space and complicating searches.

To delete a Docker image, you first need to list images to obtain information about a specific image, such as its ID and name.


docker images  or docker images -a

Now run the following command to delete the selected image (using image ID):


docker rmi  

Remove multiple images
If you want to remove multiple images at once, you need image IDs and list them as:


docker rmi    ...

Remove all images at once
If you want to remove all images, simply run:


docker rmi $(docker images -q) 

Remove dangling images
Layers with no relation to labeled images are called dangling images. They’re outdated and take up unnecessary disk space. You can find them using the docker images command with the -f filter parameter set to dangling=true. 


docker images -f dangling=true
#Remove
docker image prune

Removing Docker images with filters
Docker contains two filters: until and label. Although few, they’re effective resource management tools for Docker.

To delete all resources for a specific period, use the until filter.


docker image prune -a -a --filter "until=12h"

Here -a removes all the images created in the last 12 hours. Containers, images, and filters can all be used with this command. It accepts Unix timestamps, date-formatted timestamps, and a duration calculated from the machine time.

To delete labeled assets, use the label command.


docker image prune --filter="label=unused"

This command simplifies your work. It deletes docker images marked “unused.”

 A breakdown of label commands:


label  = 
label  =  = 
label!  = 
label!  =  = 

2. Removing Docker container 
Docker containers prepare different environments for development without the need for installing dependencies or messing anything up. These containers are based on Linux systems with the necessary tools to run applications in a secure environment. 

Many containers are produced, tested, and abandoned during the development lifecycle. Therefore, it’s critical to understand how to locate and eliminate unwanted containers.

List containers
You can use the ls command with the -a option to get a list of all containers.


docker container ls -a

This command displays a list of active containers, including their IDs, names, and other details. 

Stop containers
Run the following command to terminate a specific container:


docker container stop [id]

You can use the same command to provide multiple container IDs.

Run this command to stop containers:


docker container stop $(docker container ls -aq)

Remove a stopped container
Use this command to delete a paused container:


docker container rm [id]

Remove stopped containers
To remove stopped containers:


docker container rm $(docker container ls -aq) 

Remove one or more containers
The commands below delete one or more containers:


docker rm ID_or_Name ID_or_Name 

Remove all Docker containers
Use this command to completely wipe and restart Docker.


docker container stop $(docker container ls -aq) && docker system prune -af --volumes  

Removing container with filters
You may also delete the items that don’t fit into a certain category.


docker container prune --filter="label=maintainer=john"  

The above command instructs Docker to delete all containers with the maintainer “john”.

3. Removing Docker volumes
Docker volume is a feature introduced in Docker Engine 1.13.18 that allows users to create, mount, and share filesystems. With this capability, you can store and mount images at runtime. Common use cases include acting as a working directory and a storage medium for data files or databases in an application container.

To get a list of available Docker volumes, use the following command:

Note: All commands listed below apply to Docker 1.9 and later.


docker volume ls  

Remove one or more specific volumes 
You can use this docker volume command to delete one or more volumes:


docker volume rm vol_name vol_name2  

Remove dangling volumes 
A dangling volume is a volume that exists but is no longer attached to any container.


docker volume ls -f dangling=true 

With docker volume prune, you can get rid of dangling volumes.


docker volume prune

4. Removing Docker networks
Docker networks allow containers to freely connect while preventing traffic from leaving the network. 

Removing a single network
With the command, docker network ls, you can see a list of existing Docker networks. Use the following command to remove these networks.


docker network rm [networkID] 

If you get errors, remove the containers using the network.