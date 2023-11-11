https://code.visualstudio.com/docs/remote/linux#_local-linux-prerequisites
Local Linux prerequisites
If you are running Linux locally, the VS Code prerequisites drive most of the requirements.

In addition, specific Remote Development extensions have further requirements:

Remote - SSH: ssh needs to be in the path. The shell binary is typically in the openssh-client package.
Dev Containers: Docker CE/EE 18.06+ and Docker Compose 1.21+. Follow the official install instructions for Docker CE/EE for your distribution. If you are using Docker Compose, follow the Install Docker Compose directions as well. (Note that the Ubuntu Snap package is not supported and packages in distributions may be out of date.) docker and docker-compose must also be in the path. However, Docker does not need to be running if you are using a remote host.
