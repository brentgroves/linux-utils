https://github.com/nginx/unit/

NGINX Unit is a lightweight and versatile open-source server that has three core capabilities:

acts as an HTTP reverse proxy,
serves static media assets,
runs application code in seven languages.
Unit compresses several layers of the modern application stack into a potent, coherent solution with a focus on performance, low latency, and scalability. It is intended as a universal building block for any web architecture regardless of its complexity, from enterprise-scale deployments to your pet's homepage.

Its native RESTful JSON API enables dynamic updates with zero interruptions and flexible configuration, while its out-of-the-box productivity reliably scales to production-grade workloads. We achieve that with a complex, asynchronous, multithreading architecture comprising multiple processes to ensure security and robustness while getting the most out of today's computing platforms.

Docker
$ docker pull docker.io/nginx/unit
For a description of image tags, see the docs.

https://unit.nginx.org/installation/#docker-images


https://blog.castopod.org/containerize-your-php-applications-using-nginx-unit/

Some background information
PHP is a language commonly used in web applications. To execute your PHP code you need a PHP interpreter that can be used as a module embedded in your web server (e.g. the PHP module for the Apache HTTP Server), using the Common Gateway Interface or FastCGI. FastCGI and modules are the main ways to run PHP applications, the difference between these two methods is that FastCGI requires an additional server to run (the FastCGI server) and the web server will then communicate with the FastCGI server, whereas modules run in the same server as the web server.

Moreover, it is very common nowadays to distribute your applications as Docker images so your users can easily deploy the applications.

A container is not a virtual machine, and it is not a good practice to put multiple services in a single Docker container. Otherwise you would not be taking advantage of what Docker has to offer. So if you decide to use a deployment that relies on FastCGI, you will need at least two containers (your web server and the FastCGI Server).

If you want your application to run in a single container, you will have to use a web server that embeds a PHP module. The most common solution is to use Apache with its PHP module, but it's not very efficient when facing a lot of requests (that's why Nginx was initially written, but it doesn't include a PHP module so you must use FastCGI). A new solution, Nginx Unit, came out in 2017, and it can be compiled with support for some languages such as PHP or Python.