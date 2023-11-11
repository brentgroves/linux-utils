https://docs.nginx.com/nginx/admin-guide/web-server/web-server/

Configuring NGINX and NGINX Plus as a Web Server
Configure NGINX and NGINX Plus as a web server, with support for virtual server multi-tenancy, URI and response rewriting, variables, and error handling.

This article explains how to configure NGINX Open Source and NGINX Plus as a web server, and includes the following sections:

Setting Up Virtual Servers
Configuring Locations
Location Priority
Using Variables
Returning Specific Status Codes
Rewriting URIs in Requests
Rewriting HTTP Responses
Handling Errors

Note: The information in this article applies to both NGINX Open Source and NGINX Plus. For ease of reading, the remainder of the article refers to NGINX Plus only.

At a high level, configuring NGINX Plus as a web server is a matter of defining which URLs it handles and how it processes HTTP requests for resources at those URLs. At a lower level, the configuration defines a set of virtual servers that control the processing of requests for particular domains or IP addresses. For more information about configuration files, see Creating NGINX Plus Configuration Files.

Each virtual server for HTTP traffic defines special configuration instances called locations that control processing of specific sets of URIs. Each location defines its own scenario of what happens to requests that are mapped to this location. NGINX Plus provides full control over this process. Each location can proxy the request or return a file. In addition, the URI can be modified, so that the request is redirected to another location or virtual server. Also, a specific error code can be returned and you can configure a specific page to correspond to each error code.


