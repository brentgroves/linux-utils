https://unit.nginx.org/configuration/#applications
supported applications:
Application type: external (Go and Node.js), java, perl, php, python, or ruby

pplications
Each app that Unit runs is defined as an object in the /config/applications section of the control API; it lists the app’s language and settings, its runtime limits, process model, and various language-specific options.

Note

Our official language-specific packages include end-to-end examples of application configuration, available for your reference at /usr/share/doc/<module name>/examples/ after package installation.

Here, Unit runs 20 processes of a PHP app called blogs, stored in the /www/blogs/scripts/ directory:

{
    "blogs": {
        "type": "php",
        "processes": 20,
        "root": "/www/blogs/scripts/"
    }
}
App objects have a number of options shared between all application languages:

Option	Description
type (required)	
Application type: external (Go and Node.js), java, perl, php, python, or ruby.

Except with external, you can detail the runtime version: "type": "python 3", "type": "python 3.4", or even "type": "python 3.4.9rc1". Unit searches its modules and uses the latest matching one, reporting an error if none match.

For example, if you have only one PHP module, 7.1.9, it matches "php", "php 7", "php 7.1", and "php 7.1.9". If you have modules for versions 7.0.2 and 7.0.23, set "type": "php 7.0.2" to specify the former; otherwise, PHP 7.0.23 will be used.

environment	String-valued object; environment variables to be passed to the app.
group	
String; group name that runs the app process.

The default is the user’s primary group.

isolation	Object; manages the isolation of an application process. For details, see here.
limits	Object; accepts two integer options, timeout and requests. Their values govern the life cycle of an application process. For details, see here.
processes	
Integer or object; integer sets a static number of app processes, and object options max, spare, and idle_timeout enable dynamic management. For details, see here.

The default is 1.

user	
String; username that runs the app process.

The default is the username configured at build time or at startup.

working_directory	
String; the app’s working directory.

The default is the working directory of Unit’s main process.