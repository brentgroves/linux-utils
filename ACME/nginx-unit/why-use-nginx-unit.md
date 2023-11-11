https://octopus.com/blog/why-use-nginx-unit

https://octopus.com/blog/why-use-nginx-unit#standardized-json-configuration-files

Standardized JSON configuration files
The traditional NGINX configuration files tend to look like this:

server {
  location / {
    fastcgi_pass localhost:9000;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param QUERY_STRING  $query_string;
  }

  location ~ \.(gif|jpg|png)$ {
    root /data/images;
  }
}
While this format should be reasonably familiar to developers from curly-quote languages, the NGINX config file syntax does not conform to any general standard. If you want to update this file on a regular basis, you can expect to write complex sed commands to edit the raw text.

But using regular expressions to modify configuration files is not a pleasant experience. Inevitably, you will find your regex has matched something you didn’t expect, didn’t account for line endings or didn’t quite capture all the variations of a value.

NGINX Unit addresses this by utilizing JSON for its configuration. There is no longer any ambiguity as to how to structure the configuration data, and it is much easier to update configuration values programmatically. Relying on a common data format makes NGINX Unit much easier to manage.

HTTP configuration API
Every modern computing platform has a rich CLI tool backed by a well-structured API. It’s easy to take this functionality for granted until you find yourself running sed against a configuration file and then restarting a service.

While NGINX Unit doesn’t provide a CLI tool (all the examples in the documentation use curl), it does expose all of the configuration via an easy to understand HTTP API. This provides you with a great deal of flexibility in choosing how to expose the API (i.e., expose it on localhost or securely proxy it to make it publicly available), and it means you can use any scripting tool of your choice to interact with it.

