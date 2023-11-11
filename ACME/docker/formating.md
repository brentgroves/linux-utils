https://birthday.play-with-docker.com/cli-formating/
docker system info --format '{{json .}}'

Oh no, that looks horrible. Lets run that through jq to make it look pretty:
docker system info --format '{{json .}}' | jq .
docker image ls --format '{{json .}} | jq

docker $(docker image ls --format '{{.Repository}},{{.ID}}')
docker image ls --format '{{.Repository}},{{.ID}}' | grep test | awk -F, '!seen[$1]++'

docker system info --format 'The kernel version is: {{.KernelVersion}}' 
docker image ls --format '{{.Repository}}

docker image ls --format '{{.Repository}}' | grep test | awk -F, '!seen[$1]++'

docker image ls --format '{{range .Repository}}'

docker image ls --format '{{.Repository}}{{with split . "="}}{{printf "%s: %s\n" ( index . 0)'

docker container inspect --format '{{range .Config.Env}}{{with split . "="}}{{printf "%s: %s\n" ( index . 0 ) ( index . 1 )}}{{end}}{{end}}' $(docker container ls -lq)
