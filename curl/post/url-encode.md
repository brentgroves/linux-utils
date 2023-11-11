https://catonmat.net/cookbooks/curl/make-post-request

URL-encode POST Data
curl --data-urlencode 'comment=hello world' https://google.com/login
So far, all recipes have been using the -d argument to add POST data to requests. This argument assumes that your data is URL-encoded already. If it is not, then there can be some trouble. If your data is not URL-encoded, then replace -d with --data-urlencode. It works exactly the same way as -d, except the data gets URL-encoded by curl before it's sent out on the wire.

