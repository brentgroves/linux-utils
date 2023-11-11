https://hub.docker.com/_/nginx

Hosting some simple static content
$ docker run --name some-nginx -v /some/content:/usr/share/nginx/html:ro -d nginx

Alternatively, a simple Dockerfile can be used to generate a new image that includes the necessary content (which is a much cleaner solution than the bind mount above):

FROM nginx
COPY static-html-directory /usr/share/nginx/html