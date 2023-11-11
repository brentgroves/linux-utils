https://jsta.github.io/r-docker-tutorial/04-Dockerhub.html
Getting an image from Docker Hub
Docker Hub is the place where open Docker images are stored. When we ran our first image by typing

docker run --rm -p 8787:8787 rocker/verse
the software first checked if this image is available on your computer and since it wasn’t it downloaded the image from Docker Hub. So getting an image from Docker Hub works sort of automatically. If you just want to pull the image but not run it, you can also do

docker pull rocker/verse
Getting an image to Docker Hub
Imagine you made your own Docker image and would like to share it with the world you can sign up for an account on https://hub.docker.com/. After verifying your email you are ready to go and upload your first docker image.

Log in on https://hub.docker.com/
or
docker login

docker login --username=brentgroves --email=brent.groves@gmail.com

# tag your image
docker tag bb38976d03cf brentgroves/devcon:1.0


# Push your image to the repository you created
docker push brentgroves/devcon:1.0
docker push brentgroves/httpd:1.0

# Pull image from our repository
docker pull brentgroves/devcon:1.0
docker pull brentgroves/httpd:1.0