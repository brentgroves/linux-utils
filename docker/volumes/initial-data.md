In docker, can I publish a volume with initial data?

4


I want to share a file storage between two containers. From the documentation, I've seen that you can create and use volumes like this:

docker volume create --name DataVolume1
docker run -ti --rm -v DataVolume1:/datavolume1 ubuntu
However, I want containers to be able to access an initial set of shared data. Does docker support publishing of volumes? If not, does this mean I should write the initial data manually, after creating the volume, or is there another solution for publishing the data along with the images?

With a named volume (not with a host volume, aka bind mount) docker will initialize an empty named volume to the contents of the image at the location you mount it. So if you have files in your image at /datavolume1, and DataVolume1 is empty, docker will copy those files into the named volume.

https://docs.docker.com/storage/volumes/#populate-a-volume-using-a-container