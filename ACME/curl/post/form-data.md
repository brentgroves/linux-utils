https://catonmat.net/cookbooks/curl/make-post-request

Send a POST Request with Form Data
curl -d 'login=emma&password=123' -X POST https://google.com/login

Send a POST Request with Form Data
curl -d 'login=emma&password=123' -X POST https://google.com/login
This recipe sends a POST request to https://google.com/login with login=emma&password=123 data in request's body. When using the -d argument, curl also sets the Content-Type header to application/x-www-form-urlencoded. Additionally, when the -d option is set, the -X POST argument can be skipped as curl will automatically set the request's type to POST.


curl -v -d 'login=emma&password=123' -X POST https://google.com/login | grep '^>'

curl -v -s -o /dev/null -d 'login=emma&password=123' -X POST https://google.com/login | grep '^>'

Skipping the -X Argument
curl -d 'login=emma&password=123' https://google.com/login
In this recipe, we skip the -X POST argument that explicitly tells curl to send a POST request. We can skip it because we have specified the -d argument. When -d is used, curl implicitly sets the request's type to POST.

A Neater Way to POST Data
curl -d 'login=emma' -d 'password=123' https://google.com/login
The previous recipe used a single -d option to send all data login=emma&password=123 but here's a neater way to do the same that makes the command easier to read. Instead of using a single -d argument for all data, use multiple -d arguments for each key=value data piece! If you do that, then curl joins all data pieces with the & separator symbol when creating the request. This recipe skips the -X POST argument because when -d argument is present, curl makes a POST request implicitly.


curl -v -s -o /dev/null --stderr - https://catonmat.net | grep '^>'