https://github.com/microsoft/vscode-dev-containers/tree/main/containers/kubernetes-helm
This example illustrates how you can do this by using CLIs (kubectl, Helm, Docker), the Kubernetes extension, and the Docker extension right from inside your dev container. This definition builds up from the docker-from-docker container definition to add Kubernetes and Helm support. It installs the Docker and Kubernetes extensions inside the container so you can use its full feature set with your project.

When using Remote - Containers, the dev container also syncs your local Kubernetes config (~/.kube/config or %USERPROFILE%\.kube\config) into the container with the necessary modifications to allow it to interact with anything running on your local machine whenever the container or a terminal window is started. This includes interacting with a Kubernetes cluster managed through Docker Desktop or a local Minikube install. (Note that this does not happen when using GitHub Codespaces, so you may find the Kubernetes - Minikube-in-Docker definition more interesting for this scenario.)

How it works / adapting your existing dev container config
The .devcontainer folder in this repository contains a complete example that you can simply change the FROM statement to another Debian/Ubuntu based image to adapt to your own use (along with adding anything else you need).

However, this section will outline the how you can selectively add this functionality to your own Dockerfile. Follow these steps:

First, see the docker-from-docker definition for information on how make your local Docker instance available in the dev container. However, the docker script in the script library provides an easy way to add this to your own Dockerfile, so we'll assume you're using the script.

Next, update your devcontainer.json to mount your local .kube folder in the container so its contents can be reused. From .devcontainer/devcontainer.json:

"mounts": [
    "source=/var/run/docker.sock,target=/var/run/docker-host.sock,type=bind",
    "source=${env:HOME}${env:USERPROFILE}/.kube,target=/usr/local/share/kube-localhost,type=bind"
],
"remoteEnv": {
    "SYNC_LOCALHOST_KUBECONFIG": "true"
}

Dev containers can be useful for all types of applications including those that also deploy into a container based-environment. While you can directly build and run the application inside the dev container you create, you may also want to test it by deploying a built container image into a local minikube or remote Kubernetes cluster without affecting your dev container.

https://code.visualstudio.com/remote/advancedcontainers/use-docker-kubernetes

Use Docker or Kubernetes from a container
While you can build, deploy, and debug your application inside a dev container, you may also need to test it by running it inside a set of production-like containers. Fortunately, by installing the needed Docker or Kubernetes CLIs and mounting your local Docker socket, you can build and deploy your app's container images from inside your dev container.

Once the needed CLIs are in place, you can also work with the appropriate container cluster using the Docker extension or the Kubernetes extension.

See the following example Dev Container Templates for additional information on a specific scenario. To add them to your project, open the folder you want to work with in VS Code and run the Dev Containers: Add Dev Container Configuration Files... command in the Command Palette (F1).

You'll be prompted to pick a pre-defined container configuration from our first-party and community index in a filterable list sorted based on your folder's contents. From the VS Code UI, you may select one of the Templates described in the sections below.

