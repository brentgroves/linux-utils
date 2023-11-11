# Force no-cache
https://www.freecodecamp.org/news/docker-cache-tutorial/
docker build -t my-custom-nginx --build-arg CACHEBUST=$(date +%s) .



# Should I always run apt-get update before installing packages?
If you don't then any install may fail if the package has changed
since the last build.

https://github.com/moby/moby/issues/3313 

As with normal Debian installs, if the package lists have changed between the last run of apt-get update and the run of apt-get install the install may fail - this is because apt-get update is non-deterministic. The docker cache just allows use of previous builds, but because apt-get update is non-deterministic, the original run of the update and the run which occurs later have different results. I don't believe Docker has any special ability to know that apt-get update is non-deterministic, and thus should not be cached. 

For Debian or Ubuntu, if you're appending to a Dockerfile and want to use a cached build, another apt-get update should be run before trying to install a new package. That way you can still take advantage of the previous cached build (and any packages installed or upgraded subsequent to the first update), but your APT cache will be up-to-date when installing the next package. 

There may be a better way to do this - other suggestions welcome. There's some discussion of this in #880 


# build error message: debconf: delaying package configuration, since apt-utils is not installed
# https://unix.stackexchange.com/questions/629112/what-does-delaying-package-configuration-since-apt-utils-is-not-installed-tru
# The message means that the package can’t be pre-configured before its installation, because apt-extracttemplates is missing. 
# Nothing bad happens as a result, and the package does end up being configured correctly.

# Is more layers better?
# Layers are pulled in parallel from docker hub, so more layers would be 
# faster.
# Thanks to cache more layers would may build faster if something has 
# changed in the long run command.

# Do I need to remove old image before building a new one?
# I don't think so although I do see dangling, unnamed, images
# after doing this which can be removed.
# docker rmi $(docker images -qa -f 'dangling=true')

Do the dangling images make the build go faster?
A dangling image just means that you have created a new image without
deleting the old image. I think it is possible for the old image to be used by an existing container.

