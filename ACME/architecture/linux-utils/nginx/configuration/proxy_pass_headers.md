https://serverfault.com/questions/499343/why-proxy-pass-header-server
I'm just starting on NGINX, and I have seen in several example configs that people use

proxy_pass_header    Server;

It's telling the nginx service to pass the upstream's Server header instead of putting its own in the response. It's essentially cosmetic.

This is required for compliance with HTTP/1.1 which states that Server is an origin header:
https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.38

If the response is being forwarded through a proxy, the proxy application MUST NOT modify the Server response-header. Instead, it SHOULD include a Via field

    location /pks {
        proxy_pass         http://127.0.0.1:11371;
        proxy_pass_header  Server;
        add_header         Via "1.1 reports51:11371 (nginx)";
    }

    Server
The Server response-header field contains information about the software used by the origin server to handle the request. The field can contain multiple product tokens (section 3.8) and comments identifying the server and any significant subproducts. The product tokens are listed in order of their significance for identifying the application.

       Server         = "Server" ":" 1*( product | comment )
Example:

       Server: CERN/3.0 libwww/2.17
If the response is being forwarded through a proxy, the proxy application MUST NOT modify the Server response-header. Instead, it SHOULD include a Via field (as described in section 14.45).

      Note: Revealing the specific software version of the server might
      allow the server machine to become more vulnerable to attacks
      against software that is known to contain security holes. Server
      implementors are encouraged to make this field a configurable
      option.
