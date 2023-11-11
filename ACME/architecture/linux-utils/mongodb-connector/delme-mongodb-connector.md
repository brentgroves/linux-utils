https://eder-chamale.medium.com/building-a-docker-image-for-mongo-bi-connector-c9872b1821ba
# DOCUMENTATION
https://docs.mongodb.com/bi-connector/master/components/

FROM ubuntu:18.04
WORKDIR /home/mongobi
RUN apt-get update
RUN apt-get install -y libssl1.0.0 libssl-dev libgssapi-krb5-2 wget
RUN wget https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-ubuntu1804-v2.13.1.tgz
RUN tar -xvzf mongodb-bi-linux-x86_64-ubuntu1804-v2.13.1.tgz
WORKDIR /home/mongobi/mongodb-bi-linux-x86_64-ubuntu1804-v2.13.1
RUN mkdir /logs
RUN ls
RUN echo $PATH
RUN install -m755 bin/mongo* /usr/local/bin/
EXPOSE 3307
CMD ["mongosqld", "--config=/home/mongobi/mongosqld.conf"]


✅{{YourLogFolder}}✅ = /home/brent/mongobi/logs
✅{{YourConfFolder}}✅ = /home/brent/mongobi/conf
✅{{YourDockerUser}}✅ = brent
✅{{YourSchemaPath}}✅ = /home/brent/mongobi/schema/schema.drdl # IF YOU HAVE, NOT REQUIRED 😋

docker build
This method allows the users to build their own Docker images.

Syntax
docker build  -t ImageName:TagName dir
Options
-t − is to mention a tag to the image
ImageName − This is the name you want to give to your image.
TagName − This is the tag you want to give to your image.
Dir − The directory where the Docker File is present.

# build docker image

docker build -t brent/mongobi .

To run this image first create a log folder, for example:
mkdir -p /home/brent/mongobi/logs

# And create a mongosqld.conf (for example):
mkdir -p /home/brent/mongobi/conf/
code /home/brent/mongobi/conf/mongosqld.conf

