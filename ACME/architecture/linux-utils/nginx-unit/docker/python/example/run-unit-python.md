http://unit.nginx.org/howto/docker/
http://unit.nginx.org/howto/docker/#apps-in-a-containerized-unit

pushd ~/src/linux-utils/nginx-unit/docker/python/example
Suppose we have a web app with a few dependencies, say Flask’s official hello, world app:
[here doc](https://en.wikipedia.org/wiki/Here_document)
cd /path/to/app/
mkdir webapp
cat << EOF > webapp/wsgi.py

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
EOF

However basic it is, there’s already a dependency, so let’s list it in a file called requirements.txt:

cat << EOF > requirements.txt

flask
EOF

Next, create a simple Unit configuration for the app:

mkdir config
cat << EOF > config/config.json
{
    "listeners":{
        "*:8000":{
            "pass":"applications/webapp"
        }
    },

    "applications":{
        "webapp":{
            "type":"python 3",
            "path":"/www/",
            "module": "wsgi",
             "callable": "app"
        }
    }
}
EOF

Finally, let’s create log/ and state/ directories to store Unit log and state respectively:

mkdir log
touch log/unit.log
mkdir state
Our file structure so far:

/path/to/app
├── config
│   └── config.json
├── log
│   └── unit.log
├── requirements.txt
├── state
└── webapp
    └── wsgi.py

Everything is ready for a containerized Unit. First, let’s create a Dockerfile to install app prerequisites:

FROM unit:1.30.0-python3.11
COPY requirements.txt /config/requirements.txt
RUN python3 -m pip install -r /config/requirements.txt


# build docker image
docker build --tag=unit-webapp .

# start container
pushd ~/src/linux-utils/nginx-unit/docker/python/example
Next, we start a container and map it to our directory structure:
export UNIT=$(                                                         \
      docker run --name unit-wsgi-ex -d                                 \
      --mount type=bind,src="$(pwd)/config/",dst=/docker-entrypoint.d/   \
      --mount type=bind,src="$(pwd)/log/unit.log",dst=/var/log/unit.log  \
      --mount type=bind,src="$(pwd)/state",dst=/var/lib/unit             \
      --mount type=bind,src="$(pwd)/webapp",dst=/www                     \
      -p 8080:8000 unit-webapp                                           \
  )

With this mapping, Unit stores its state and log in your file structure. By default, our Docker images forward their log output to the [Docker log collector](https://docs.docker.com/config/containers/logging/).


We’ve mapped the source config/ to /docker-entrypoint.d/ in the container; the official image uploads any .json files found there into Unit’s config section if the state is empty. Now we can test the app:

curl -X GET localhost:8080

    Hello, World!
# examine logs
docker logs --tail=10 -f unit-wsgi-ex

# stop and remove container
docker rm $(docker stop $UNIT$)
docker rm $(docker stop $(docker ps -a -q --filter NAME=unit-wsgi-ex --format="{{.ID}}"))

## run interactive terminal
docker exec -it some-nginx /bin/bash
docker exec -it tmp-nginx-container sh
