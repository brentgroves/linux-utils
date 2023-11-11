https://reqbin.com/req/c-ea0d5rlb/curl-send-header-example
curl https://reqbin.com/echo/get/json
   -H "X-Custom-Header: value"
   -H "Content-Type: application/json"

https://catonmat.net/cookbooks/curl/make-post-request
Send a POST Request with JSON Data
curl -d '{"login": "emma", "pass": "123"}' -H 'Content-Type: application/json' https://google.com/login
In this recipe, curl sends a POST request with JSON data in it. This is accomplished by passing JSON to the -d option and also using the -H option that sets the Content-Type header to application/json. Setting the content type header to application/json is necessary because otherwise, the web server won't know what type of data this is. I've also removed the -X POST argument as it can be skipped because -d forces a POST request.