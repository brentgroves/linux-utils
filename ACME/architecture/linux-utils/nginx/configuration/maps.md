https://www.digitalocean.com/community/tutorials/how-to-use-nginx-s-map-module-on-ubuntu-20-04
Introduction
Nginx’s map module lets you create variables in Nginx’s configuration file whose values are conditional — that is, they depend on other variables’ values. In this guide, we will look at how to use Nginx’s map module to implement two examples: setting up a list of redirects from old website URLs to new ones and creating an allowlist of countries to control traffic to your website.

Step 1 — Creating and Testing an Example Webpage
First, we will create a test file representing a newly published website. We’ll use this file to test our configuration.
Let’s create a simple page, index.html, in the default Nginx website directory. This file will just have plain text describing what’s inside: Home:
sudo sh -c 'echo "Home" > /var/www/html/index.html'
With this test file in place, we’ll check that it’s being served correctly with curl. We don’t need to specify index.html for this command because that file is served by default if no exact filename is provided:

curl http://localhost/
In response, you should see a single word saying Home just like below:

Output
Home
Now let’s try to access a file that doesn’t exist in /var/www/html/, like old.html:

curl -L http://localhost/old.html


http://nginx.org/en/docs/http/ngx_http_map_module.html
Example Configuration
Directives
     map
     map_hash_bucket_size
     map_hash_max_size
The ngx_http_map_module module creates variables whose values depend on values of other variables.

Example Configuration
map $http_host $name {
    hostnames;

    default       0;

    example.com   1;
    *.example.com 1;
    example.org   2;
    *.example.org 2;
    .example.net  3;
    wap.*         4;
}

map $http_user_agent $mobile {
    default       0;
    "~Opera Mini" 1;
}

Directives
Syntax:	map string $variable { ... }
Default:	—
Context:	http

Creates a new variable whose value depends on values of one or more of the source variables specified in the first parameter.

Before version 0.9.0 only a single variable could be specified in the first parameter.
Since variables are evaluated only when they are used, the mere declaration even of a large number of “map” variables does not add any extra costs to request processing.
Parameters inside the map block specify a mapping between source and resulting values.

Source values are specified as strings or regular expressions (0.9.6).

Strings are matched ignoring the case.

A regular expression should either start from the “~” symbol for a case-sensitive matching, or from the “~*” symbols (1.0.4) for case-insensitive matching. A regular expression can contain named and positional captures that can later be used in other directives along with the resulting variable.

If a source value matches one of the names of special parameters described below, it should be prefixed with the “\” symbol.

The resulting value can contain text, variable (0.9.0), and their combination (1.11.0).

The following special parameters are also supported:

default value
sets the resulting value if the source value matches none of the specified variants. When default is not specified, the default resulting value will be an empty string.

hostnames
indicates that source values can be hostnames with a prefix or suffix mask:
*.example.com 1;
example.*     1;
The following two records
example.com   1;
*.example.com 1;
can be combined:
.example.com  1;
This parameter should be specified before the list of values.

include file
includes a file with values. There can be several inclusions.
volatile
indicates that the variable is not cacheable (1.11.7).
If the source value matches more than one of the specified variants, e.g. both a mask and a regular expression match, the first matching variant will be chosen, in the following order of priority:

string value without a mask
longest string value with a prefix mask, e.g. “*.example.com”
longest string value with a suffix mask, e.g. “mail.*”
first matching regular expression (in order of appearance in a configuration file)
default value
