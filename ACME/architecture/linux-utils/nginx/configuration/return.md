https://docs.nginx.com/nginx/admin-guide/web-server/web-server/

Returning Specific Status Codes
Some website URIs require immediate return of a response with a specific error or redirect code, for example when a page has been moved temporarily or permanently. The easiest way to do this is to use the return directive. For example:

location /wrong/url {
    return 404;
}
The first parameter of return is a response code. The optional second parameter can be the URL of a redirect (for codes 301, 302, 303, and 307) or the text to return in the response body. For example:

location /permanently/moved/url {
    return 301 http://www.example.com/moved/here;
}

The return directive can be included in both the location and server contexts.


