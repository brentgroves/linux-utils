https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/

Chmod 777
NEVER use 777. It might be one nifty number, but even in testing it’s a sign of having no clue what you’re doing. Look at the permissions in the whole path and think through what’s going on.

To easily display all the permissions on a path, you can use:

namei -om namei -om ~/src/hockeypuck 

Root inside Location Block
BAD:

server {
    server_name www.example.com;
    location / {
        root /var/www/nginx-default/;
        # [...]
      }
    location /foo {
        root /var/www/nginx-default/;
        # [...]
    }
    location /bar {
        root /some/other/place;
        # [...]
    }
}
This works. Putting root inside of a location block will work and it’s perfectly valid. What’s wrong is when you start adding location blocks. If you add a root to every location block then a location block that isn’t matched will have no root. Therefore, it is important that a root directive occur prior to your location blocks, which can then override this directive if they need to. Let’s look at a good configuration.

GOOD:

server {
    server_name www.example.com;
    root /var/www/nginx-default/;
    location / {
        # [...]
    }
    location /foo {
        # [...]
    }
    location /bar {
        root /some/other/place;
        # [...]
    }
}

Multiple Index Directives¶
BAD:

http {
    index index.php index.htm index.html;
    server {
        server_name www.example.com;
        location / {
            index index.php index.htm index.html;
            # [...]
        }
    }
    server {
        server_name example.com;
        location / {
            index index.php index.htm index.html;
            # [...]
        }
        location /foo {
            index index.php;
            # [...]
        }
    }
}

Why repeat so many lines when not needed? Simply use the index directive one time. It only needs to occur in your http{} block and it will be inherited below.

GOOD:

http {
    index index.php index.htm index.html;
    server {
        server_name www.example.com;
        location / {
            # [...]
        }
    }
    server {
        server_name example.com;
        location / {
            # [...]
        }
        location /foo {
            # [...]
        }
    }
}

Using if
There is a little page about using if statements. It’s called IfIsEvil and you really should check it out. Let’s take a look at a few uses of if that are bad.

See also
If Is Evil

Server Name (If)
BAD:

server {
    server_name example.com *.example.com;
        if ($host ~* ^www\.(.+)) {
            set $raw_domain $1;
            rewrite ^/(.*)$ $raw_domain/$1 permanent;
        }
        # [...]
    }
}
There are actually three problems here. The first being the if. That’s what we care about now. Why is this bad? Did you read If is Evil? When NGINX receives a request - no matter what is the subdomain being requested, be it www.example.com or just the plain example.com - this if directive is always evaluated. Since you’re requesting NGINX to check for the Host header for every request, it’s extremely inefficient. You should avoid it. Instead use two server directives like the example below.

GOOD:

server {
    server_name www.example.com;
    return 301 $scheme://example.com$request_uri;
}
server {
    server_name example.com;
    # [...]
}

