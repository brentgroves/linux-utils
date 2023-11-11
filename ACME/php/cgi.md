CGI is a standard method used to generate dynamic content on web pages. CGI stands for Common Gateway Interface and provides an interface between the HTTP server and programs generating web content. These programs are better known as CGI scripts. They are written in a scripting language.

https://www.keil.com/pack/doc/mw/Network/html/group__ws__script__langugage.html#:~:text=CGI%20is%20a%20standard%20method,written%20in%20a%20scripting%20language.

In computing, Common Gateway Interface (CGI) is an interface specification that enables web servers to execute an external program, typically to process user requests.[1]

Such programs are often written in a scripting language and are commonly referred to as CGI scripts, but they may include compiled programs.[2]

A typical use case occurs when a web user submits a web form on a web page that uses CGI. The form's data is sent to the web server within an HTTP request with a URL denoting a CGI script. The web server then launches the CGI script in a new computer process, passing the form data to it. The output of the CGI script, usually in the form of HTML, is returned by the script to the Web server, and the server relays it back to the browser as its response to the browser's request.[3]

Developed in the early 1990s, CGI was the earliest common method available that allowed a web page to be interactive.


Purpose of the CGI specification
Each Web server runs HTTP server software, which responds to requests from web browsers. Generally, the HTTP server has a directory (folder), which is designated as a document collection – files that can be sent to Web browsers connected to this server.[8] For example, if the Web server has the domain name example.com, and its document collection is stored at /usr/local/apache/htdocs/ in the local file system, then the Web server will respond to a request for http://example.com/index.html by sending to the browser the (pre-written) file /usr/local/apache/htdocs/index.html.

For pages constructed on the fly, the server software may defer requests to separate programs and relay the results to the requesting client (usually, a Web browser that displays the page to the end user). In the early days of the Web, such programs were usually small and written in a scripting language; hence, they were known as scripts.

Such programs usually require some additional information to be specified with the request. For instance, if Wikipedia were implemented as a script, one thing the script would need to know is whether the user is logged in and, if logged in, under which name. The content at the top of a Wikipedia page depends on this information.

HTTP provides ways for browsers to pass such information to the Web server, e.g. as part of the URL. The server software must then pass this information through to the script somehow.

Conversely, upon returning, the script must provide all the information required by HTTP for a response to the request: the HTTP status of the request, the document content (if available), the document type (e.g. HTML, PDF, or plain text), et cetera.

Initially, different server software would use different ways to exchange this information with scripts. As a result, it wasn't possible to write scripts that would work unmodified for different server software, even though the information being exchanged was the same. Therefore, it was decided to specify a way for exchanging this information: CGI (the Common Gateway Interface, as it defines a common way for server software to interface with scripts). Webpage generating programs invoked by server software that operate according to the CGI specification are known as CGI scripts.

This specification was quickly adopted and is still supported by all well-known server software, such as Apache, IIS, and (with an extension) node.js-based servers.

An early use of CGI scripts was to process forms. In the beginning of HTML, HTML forms typically had an "action" attribute and a button designated as the "submit" button. When the submit button is pushed the URI specified in the "action" attribute would be sent to the server with the data from the form sent as a query string. If the "action" specifies a CGI script then the CGI script would be executed and it then produces an HTML page.

Using CGI scripts
A Web server allows its owner to configure which URLs shall be handled by which CGI scripts.

This is usually done by marking a new directory within the document collection as containing CGI scripts – its name is often cgi-bin. For example, /usr/local/apache/htdocs/cgi-bin could be designated as a CGI directory on the Web server. When a Web browser requests a URL that points to a file within the CGI directory (e.g., http://example.com/cgi-bin/printenv.pl/with/additional/path?and=a&query=string), then, instead of simply sending that file (/usr/local/apache/htdocs/cgi-bin/printenv.pl) to the Web browser, the HTTP server runs the specified script and passes the output of the script to the Web browser. That is, anything that the script sends to standard output is passed to the Web client instead of being shown on-screen in a terminal window.

As remarked above, the CGI specification defines how additional information passed with the request is passed to the script. For instance, if a slash and additional directory name(s) are appended to the URL immediately after the name of the script (in this example, /with/additional/path), then that path is stored in the PATH_INFO environment variable before the script is called. If parameters are sent to the script via an HTTP GET request (a question mark appended to the URL, followed by param=value pairs; in the example, ?and=a&query=string), then those parameters are stored in the QUERY_STRING environment variable before the script is called. If parameters are sent to the script via an HTTP POST request, they are passed to the script's standard input. The script can then read these environment variables or data from standard input and adapt to the Web browser's request.[9]

Example
The following Perl program shows all the environment variables passed by the Web server:

#!/usr/bin/env perl

=head1 DESCRIPTION

printenv — a CGI program that just prints its environment

=cut
print "Content-Type: text/plain\n\n";

foreach ( sort keys %ENV ) {
    print "$_=\"$ENV{$_}\"\n";
}

Alternatives
For each incoming HTTP request, a Web server creates a new CGI process for handling it and destroys the CGI process after the HTTP request has been handled. Creating and destroying a process can consume much more CPU and memory resources than the actual work of generating the output of the process, especially when the CGI program still needs to be interpreted by a virtual machine. For a high number of HTTP requests, the resulting workload can quickly overwhelm the Web server.

The overhead involved in CGI process creation and destruction can be reduced by the following techniques:

CGI programs precompiled to machine code, e.g. precompiled from C or C++ programs, rather than CGI programs interpreted by a virtual machine, e.g. Perl, PHP or Python programs.
Web server extensions such as Apache modules (e.g. mod_perl, mod_php, mod_python), NSAPI plugins, and ISAPI plugins which allow long-running application processes handling more than one request and hosted within the Web server. Web 2.0 allows to transfer data from the client to the server without using HTML forms and without the user noticing.[13]
FastCGI, SCGI, and AJP which allow long-running application processes handling more than one request to be hosted externally; i.e., separately from the Web server. Each application process listens on a socket; the Web server handles an HTTP request and sends it via another protocol (FastCGI, SCGI or AJP) to the socket only for dynamic content, while static content is usually handled directly by the Web server. This approach needs fewer application processes so consumes less memory than the Web server extension approach. And unlike converting an application program to a Web server extension, FastCGI, SCGI, and AJP application programs remain independent of the Web server.
Jakarta EE runs Jakarta Servlet applications in a Web container to serve dynamic content and optionally static content which replaces the overhead of creating and destroying processes with the much lower overhead of creating and destroying threads. It also exposes the programmer to the library that comes with Java SE on which the version of Jakarta EE in use is based.
The optimal configuration for any Web application depends on application-specific details, amount of traffic, and complexity of the transaction; these trade-offs need to be analyzed to de