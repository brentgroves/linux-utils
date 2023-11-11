# client vrs server rendering
What happens when a user updates form data and presses the submit button?
## server side rendering
an http request is sent to the web server and the entire web page is rerendered based upon parameters sent on the request's querystring or included in its body.
## client side rendering
an http request is sent to the web server to perform some specific computation such as a database transaction and the response data is returned to the user agent. The user agent then rerenders the page with the response data by calling javascript module functions.