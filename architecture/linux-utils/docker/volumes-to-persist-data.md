https://www.freecodecamp.org/news/docker-mount-volume-guide-how-to-mount-a-local-directory/

How to Use Docker Volumes to Persist Changes
Instead of binding your local directory, you can use Docker volumes. A Docker volume is a directory somewhere in your Docker storage directory and can be mounted to one or many containers. They are fully managed and do not depend on certain operating system specifics.

Let’s create a Docker volume and mount it to persist MySQL data:

# create volume
docker volume create mysql-data

# run mysql container in the background
$ docker run --name mysql-db -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest

# stop mysql container
docker rm -f mysql-db

# remove volume
docker volume remove mysql-data
Before removing the Docker volume, you can open your Docker GUI and inspect the volume by clicking on the data tab.

docker-ui-volume

You see the files, but they're isolated in a Docker volume. It’s recommended to use them for persisting files that you don’t need to observe or change from your host system. This method is known to have better performance than local directory bindings.

Summary
Docker containers get more powerful when you know how to persist your data and not to lose them when stopping a container.

You bind local directories and volumes to a container by providing the Docker run -v parameter. You need to give the absolute local path or a volume name and map it to a directory within the container -v <source>:<target>.

docker volume inspect example-app_sail-redis

[
    {
        "CreatedAt": "2023-05-26T16:01:43-04:00",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "example-app",
            "com.docker.compose.version": "2.18.1",
            "com.docker.compose.volume": "sail-redis"
        },
        "Mountpoint": "/var/lib/docker/volumes/example-app_sail-redis/_data",
        "Name": "example-app_sail-redis",
        "Options": null,
        "Scope": "local"
    }
]

ls /var/lib/docker/volumes