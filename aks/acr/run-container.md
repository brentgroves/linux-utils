docker login mobexcr.azurecr.io
Both commands return Login Succeeded once completed.

# First, pull a public Nginx image to your local computer. This example pulls an image from Microsoft Container Registry.

docker pull mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
docker image ls 
REPOSITORY                          TAG             IMAGE ID       CREATED         SIZE
brentgroves/bi-connector            1               7751e0e33e3f   6 days ago      277MB
brentgroves/mongobi                 1               b9d2660d7872   10 days ago     277MB
brentgroves/mongobi                 latest          b9d2660d7872   10 days ago     277MB
mongo                               6.0.3           0850fead9327   3 months ago    700MB
hello-world                         latest          feb5d9fea6a5   17 months ago   13.3kB
mcr.microsoft.com/azure-cli         2.6.0           4a87928e8b40   2 years ago     699MB
mongo                               4.0.17          6182b91a1dbe   2 years ago     418MB
mcr.microsoft.com/oss/nginx/nginx   1.15.5-alpine   aae476eee77d   4 years ago     17.7MB

# Run the container locally
Execute the following docker run command to start a local instance of the Nginx container interactively (-it) on port 8080. The --rm argument specifies that the container should be removed when you stop it.

docker run -it --rm -p 8080:80 mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine

Because you started the container interactively with -it, you can see the Nginx server's output on the command line after navigating to it in your browser.

To stop and remove the container, press Control+C.

