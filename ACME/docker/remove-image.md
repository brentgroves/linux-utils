docker rmi -f $(docker image ls --format '{{.Repository}} {{.ID}}' | grep nginx | awk '{ print $2}')

docker image prune