https://catonmat.net/cookbooks/curl/make-post-request

Send a POST Request with Plain Text Data
curl -d 'hello world' -H 'Content-Type: text/plain' https://google.com/login
This recipe sends a POST request with a plain text string hello world in request's body. It also sets the Content-Type header to text/plain to tell web server that it's just plain text coming in.

