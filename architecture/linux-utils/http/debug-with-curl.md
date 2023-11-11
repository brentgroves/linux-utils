https://www.browserling.com/
https://catonmat.net/cookbooks/curl/debug-curl-requests
https://catonmat.net/cookbooks/curl

Debug Curl Requests (TLDR: Use -v or --trace arguments)
Last updated 1 week ago
These curl recipes show you how to debug curl requests to see what it's sending and receiving. By default, curl only prints the response body. To make it print the full communication, including the request headers, SSL certificate information, response headers, and response body, use the -v command line argument. To make it print a hexdump of everything, use the --trace argument. To make it print both the response headers and the body, use the -i command line argument.

Make Curl Verbose
Detailed Trace
Detailed Trace with Timestamps
Include Response Headers in the Output
Print Only the Response Headers
Print Only the Request Headers
Print Only the Response Code
Make Curl Verbose
curl -v https://catonmat.net

This recipe uses the -v argument to make curl print detailed information about the request and the response. Lines prefixed by > is the data sent to the server, lines prefixed by < is the data received from the server, and lines starting with * is misc information, such as connection information, SSL handshake information, and protocol information.

Detailed Trace
curl --trace - https://catonmat.net
In this recipe, we use the --trace - argument to enable full trace dump of all incoming and outgoing data. The trace dump prints hexdump of all bytes sent and received.

Include Response Headers in the Output
curl -i https://catonmat.net
By default, curl prints the response body to the screen. This recipe uses the -i argument to make it also print response headers. When this flag is specified, curl will first print the response headers, then a blank line, then the response body.

Print Only the Response Headers
curl -s -o /dev/null -D - https://catonmat.net

To print only the response headers (and discard the body), three arguments have to be used together. The -s argument makes curl silent and hides errors and progress bar, then -o /dev/null (if you're on Windows, use -o NUL) makes curl ignore the response body, and -D - prints response headers to stdout (- is stdout).

Print Only the Request Headers
curl -v -s -o /dev/null --stderr - https://catonmat.net | grep '^>'
There is no easy way to print just the request headers with curl. You have to shell out to an external helper program to do it and use a bunch of command line options to disable all other output. This recipe enables the verbose output via the -v argument, then makes curl silent via the -s argument, then makes curl ignore the output from the server via the -o /dev/null argument, then makes curl to redirect stderr to stdout via the --stderr - argument, and finally asks grep to print all lines that begin with > that contain request headers.

Print Only the Response Code
curl -w '%{response_code}' -s -o /dev/null https://catonmat.net
This recipe uses the -w argument that makes curl print extra information after the request has completed. The extra information we're asking it to print is %{response_code} which is the response code of the request. To make curl only print the code and not the content or other information, we also use -s to silence curl and -o /dev/null that ignores the response output.

Created by Browserling
These curl recipes were written down by me and my team at Browserling. We use recipes like this every day to get things done and improve our product. Browserling itself is an online cross-browser testing service powered by alien technology. Check it out!

Secret message: If you love my curl recipe, then I love you, too! Use coupon code CURLLING to get a discount at my company.


