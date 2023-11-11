https://catonmat.net/cookbooks/curl/make-post-request

Send a POST Request and Follow a Redirect
curl -L -d 'tweet=hi' https://api.twitter.com/tweet
This recipe uses the -L command line option that tells curl to follow any possible redirects that it may encounter in the way. By default, curl doesn't follow the redirects, so you have to add -L to make it follow them. This recipe skips the -X POST argument because -d argument forces curl to make a POST request.

