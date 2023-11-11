https://blog.logrocket.com/docker-volumes-vs-bind-mounts/
Volumes are a great mechanism for adding a data persisting layer in your Docker containers, especially for a situation where you need to persist data after shutting down your containers.

Docker volumes are completely handled by Docker itself and therefore independent of both your directory structure and the OS of the host machine. When you use a volume, a new directory is created within Docker’s storage directory on the host machine, and Docker manages that directory’s contents.

Benefits of using volumes
In Docker volumes, storage is not coupled to the lifecycle of the container, but instead exists outside of it. This has many benefits. For one, you can kill your container as many times as you want and still have your data persisted. It’s also easy to reuse storage in multiple containers; for example, one container writes to the storage while another reads from it.

Since volumes are not tied to any container, you can easily attach them to multiple running containers at the same time. You’ll also find that volumes don’t increase the size of the Docker container using them. Lastly, you can use the Docker CLI to manage volumes, for example, retrieving the list of volumes or removing unused volumes.