https://www.freecodecamp.org/news/docker-mount-volume-guide-how-to-mount-a-local-directory/

https://blog.logrocket.com/docker-volumes-vs-bind-mounts/
Docker volumes vs. bind mounts
June 3, 2021  4 min read 

Docker Volumes Bind Mounts
When a Docker container is destroyed, creating a new container off of the existing Docker image does so without making any changes to the original container. Therefore, you’ll lose data any time you destroy one container and create a new one.

To avoid losing data, Docker provides volumes and bind mounts, two mechanisms for persisting data in your Docker container. In this tutorial, we’ll examine volumes and bind mounts before looking at some examples and use cases for each.

Let’s get started!

Bind mounts
Bind mounts have been available in Docker since its earliest days for data persisting. Bind mounts will mount a file or directory on to your container from your host machine, which you can then reference via its absolute path.

To use bind mounts, the file or directory does not need to exist on your Docker host already. If it doesn’t exist, it will be created on demand. Bind mounts rely on the host machine’s filesystem having a specific directory structure available. You must explicitly create a path to the file or folder to place the storage.

Another important piece of information about bind mounts is that they give access to sensitive files. According to the Docker docs, you can change the host filesystem through processes running in a container. This includes creating, modifying, and deleting system files and directories, which can have pretty severe security implications. It could even impact non-Docker processes.

Getting started using bind mounts
To use bind mounts on a container, you two flag options to use, --mount and -v. The most notable difference between the two options is that --mount is more verbose and explicit, whereas -v is more of a shorthand for --mount. It combines all the options you pass to --mount into one field.

On the surface, both commands create a PostgreSQL container and set a volume to persist data. However, there are some scenarios where the difference between using --mount and -v will be noticeably different. For example, it’s best practice to use --mount when you are working with services because you’ll need to specify more options than are possible with -v.

Specify the bind mount using the --mount flag by running:

docker run --rm --name postgres-db -e POSTGRES_PASSWORD=password --mount type=bind,source="$pwd",target=/var/lib/postgresql/data -p 2000:5432 -d postgres
Use this code to specify it with the -v flag:

docker run --rm --name postgres-db -e POSTGRES_PASSWORD=password --v "$pwd":/var/lib/postgresql/data -p 2000:5432 -d postgres
Note that in both cases, we specify $pwd, the working directory, as the source. Basically, we’re telling Docker to create the bind mount in the directory we are currently in.

Docker volumes
Volumes are a great mechanism for adding a data persisting layer in your Docker containers, especially for a situation where you need to persist data after shutting down your containers.

Docker volumes are completely handled by Docker itself and therefore independent of both your directory structure and the OS of the host machine. When you use a volume, a new directory is created within Docker’s storage directory on the host machine, and Docker manages that directory’s contents.

Benefits of using volumes
In Docker volumes, storage is not coupled to the lifecycle of the container, but instead exists outside of it. This has many benefits. For one, you can kill your container as many times as you want and still have your data persisted. It’s also easy to reuse storage in multiple containers; for example, one container writes to the storage while another reads from it.

Since volumes are not tied to any container, you can easily attach them to multiple running containers at the same time. You’ll also find that volumes don’t increase the size of the Docker container using them. Lastly, you can use the Docker CLI to manage volumes, for example, retrieving the list of volumes or removing unused volumes.