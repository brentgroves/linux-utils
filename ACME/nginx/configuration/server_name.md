server_name
http://nginx.org/en/docs/http/server_names.html


Wildcard names
Regular expressions names
Miscellaneous names
Internationalized names
Virtual server selection
Optimization
Compatibility
Server names are defined using the server_name directive and determine which server block is used for a given request. See also “How nginx processes a request”. They may be defined using exact names, wildcard names, or regular expressions:

server {
    listen       80;
    server_name  example.org  www.example.org;
    ...
}

server {
    listen       80;
    server_name  *.example.org;
    ...
}

server {
    listen       80;
    server_name  mail.*;
    ...
}

server {
    listen       80;
    server_name  ~^(?<user>.+)\.example\.net$;
    ...
}

When searching for a virtual server by name, if name matches more than one of the specified variants, e.g. both wildcard name and regular expression match, the first matching variant will be chosen, in the following order of precedence:

exact name
longest wildcard name starting with an asterisk, e.g. “*.example.org”
longest wildcard name ending with an asterisk, e.g. “mail.*”
first matching regular expression (in order of appearance in a configuration file)


Wildcard names
A wildcard name may contain an asterisk only on the name’s start or end, and only on a dot border. The names “www.*.example.org” and “w*.example.org” are invalid. However, these names can be specified using regular expressions, for example, “~^www\..+\.example\.org$” and “~^w.*\.example\.org$”. An asterisk can match several name parts. The name “*.example.org” matches not only www.example.org but www.sub.example.org as well.

A special wildcard name in the form “.example.org” can be used to match both the exact name “example.org” and the wildcard name “*.example.org”.

Regular expressions names
The regular expressions used by nginx are compatible with those used by the Perl programming language (PCRE). To use a regular expression, the server name must start with the tilde character:

server_name  ~^www\d+\.example\.net$;
otherwise it will be treated as an exact name, or if the expression contains an asterisk, as a wildcard name (and most likely as an invalid one). Do not forget to set “^” and “$” anchors. They are not required syntactically, but logically. Also note that domain name dots should be escaped with a backslash. A regular expression containing the characters “{” and “}” should be quoted:

server_name  "~^(?<name>\w\d{1,3}+)\.example\.net$";
otherwise nginx will fail to start and display the error message:

directive "server_name" is not terminated by ";" in ...
A named regular expression capture can be used later as a variable:

server {
    server_name   ~^(www\.)?(?<domain>.+)$;

    location / {
        root   /sites/$domain;
    }
}

The PCRE library supports named captures using the following syntax:

?<name>	Perl 5.10 compatible syntax, supported since PCRE-7.0
?'name'	Perl 5.10 compatible syntax, supported since PCRE-7.0
?P<name>	Python compatible syntax, supported since PCRE-4.0
If nginx fails to start and displays the error message:
pcre_compile() failed: unrecognized character after (?< in ...
this means that the PCRE library is old and the syntax “?P<name>” should be tried instead. The captures can also be used in digital form:

server {
    server_name   ~^(www\.)?(.+)$;

    location / {
        root   /sites/$2;
    }
}
However, such usage should be limited to simple cases (like the above), since the digital references can easily be overwritten.

Miscellaneous names
There are some server names that are treated specially.

If it is required to process requests without the “Host” header field in a server block which is not the default, an empty name should be specified:

server {
    listen       80;
    server_name  example.org  www.example.org  "";
    ...

If a server name is defined as “$hostname” (0.9.4), the machine’s hostname is used.

If someone makes a request using an IP address instead of a server name, the “Host” request header field will contain the IP address and the request can be handled using the IP address as the server name:

server {
    listen       80;
    server_name  example.org
                 www.example.org
                 ""
                 192.168.1.1
                 ;
    ...
}
In catch-all server examples the strange name “_” can be seen:

server {
    listen       80  default_server;
    server_name  _;
    return       444;
}
There is nothing special about this name, it is just one of a myriad of invalid domain names which never intersect with any real name. Other invalid names like “--” and “!@#” may equally be used.