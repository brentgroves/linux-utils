https://medium.com/the-godev-corner/how-to-create-a-go-private-module-with-docker-b705e4d195c4



Because Docker is outside the scope of this article, I will only explain specific parts of the Dockerfile. Lines 8 and 9 are shown below:

ARG GITHUB_TOKEN
ENV CGO_ENABLED=0 GO111MODULE=on GOOS=linux TOKEN=$GITHUB_TOKEN
We are defining an argument that will accept a value during the Docker image build.

💡Due to security concerns, the argument is set dynamically. I cannot emphasize enough that your secret and tokens should not be hard coded in your Dockerfile.

We then pass the GITHUB_TOKEN docker argument once we receive the GITHUB_TOKEN environment variable value which is our Personal Access Token:

RUN go env -w GOPRIVATE=github.com/username/*
As previously stated, this command on line 11 will set the Go GOPRIVATE environment variable:

RUN git config --global url."https://${TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
Line 14 specifies how we will download our private Go modules and retrieve the environment variable using the Personal Access Token passed as TOKEN:

Before we begin, let’s create a .env file for our project.

In the project root, create the .env file and add the following content:

After we’ve finished with the .env, let’s build our application Docker image by running the command below:

export $(egrep -v ‘^#’ .env | xargs) && docker build --build-arg GITHUB_TOKEN=${GITHUB_TOKEN} -t go-private-example .
On the above commands, we grab the values from our .env file and export them as environment variables with their values. Then we run Docker build to build the Docker image with arguments from the environment variables passed from the .env file.

After building the image we can run the Docker image by running this command:

docker run go-private-example
And the output should be as shown below:

Go private module Example [1 2 3 4 5 0 9 45]