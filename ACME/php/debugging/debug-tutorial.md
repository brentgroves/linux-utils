https://deliciousbrains.com/xdebug-advanced-php-debugging/
https://stackify.com/php-debugging-guide/
Outputting values
When you need a simple way to debug programs and you have no other options, you can usually output values. Sometimes this means doing a var_dump or logging a whole series of events.

It’s useful to have debug logging in your program. In PHP, you can use various loggers to log debug messages. When the program is run in debug mode or the log level is set to debug, these messages will end up in your stdout, stderr, or log files. The logs will fill up pretty quickly in “debug mode,” so you only want to turn it on temporarily. But I’m getting ahead of myself here. Let me backup to some simple ways to output values.

Dumping variables to stdout
The var_dump function is one way to see what’s happening in your PHP program. It’ll dump a variable value to stdout. There are other functions you can use for debugging through outputs. Here are a few and how they’ll help you:

var_dump ($var) dumps the variable type and value to stdout.
print_r ($var) prints the variable value in human-readable form to stdout.
get_defined_vars() gets all the defined variables including built-ins and custom variables (print_r to view them).
debug_zval_dump ($var) dumps the variable with its reference counts. This is useful when there are multiple paths to update a single reference.
debug_print_backtrace() prints a backtrace that shows the current function call-chain.
debug_backtrace() gets the backtrace. You can print_r, log it to a file, or send it to a logging endpoint asynchronously.
Here’s sample code that exercises each of these useful debugging functions:

<?php
$myVar = "hello world!";

var_dump($myVar);
print_r($myVar);

$allVars = get_defined_vars();
print_r($allVars);
debug_zval_dump($allVars);

function sayHello($hello) {
    echo $hello;
    debug_print_backtrace();
}

sayHello($myVar);
?>
These functions are a quick way to debug your PHP code. You can see them in action in this Paiza. Each function has a purpose and can be useful for debugging.
https://paiza.io/projects/8WFzDA_9grobzvSEM3y27g

[Switching error reporting level](https://www.php.net/manual/en/errorfunc.configuration.php#ini.error-reporting)
PHP has a few ways to configure error reporting. You can use the php.ini file, if you have access to it. Otherwise, you might use the htaccess configuration. If you can’t use configuration files, you have the option of changing the values via a script. This is possible, but think about how you would change modes after deploying your application.

A combination of settings will get you the right levels of error logging. You’ll want to consider the following settings:

error_reporting sets the level of logging. E_NOTICE is useful during development since it will tell you about defects such as unassigned variables.
display_errors tells PHP if and where to display error messages.
display_startup_errors should only be used when debugging.
log_errors and error_log work together to send errors to a log file. Do this in production rather than displaying them to end users.
The PHP manual spells out these settings in more detail and provides more information I could ever fit in this section. But even with the best logging settings, you still need to monitor for errors.

Monitoring error logs
It’s one thing to log errors—that’s almost a given. It’s a whole other thing to take action when errors are logged. First, you have to know about the errors. Unless you have all day and night to hover over the logs, you will not know when something bad is happening!

The best thing you can do is send your PHP logs to a service that will handle a few key things for you:

Log aggregation. You want to see all your logs in one place. If you can centralize your logs and metrics across instances, that’s even better! You’d be able to spot trouble wherever it happens.

![log service](https://stackify.com/wp-content/uploads/2019/01/word-image-9.png)

Alerting. There’s nothing better than automation. If you’re a programmer, you know what I mean! You’ll want to automate almost anything if you can. Alerting is a way to send alerts automatically to a group email (better than an individual for continuity) when there’s a problem. This can be a server issue or errors hitting your logs. It should be configurable and you should have control over the configuration.
Traces in your logs. What’s a trace? It’s not just a stack dump that lets you see what was going on when an error happened. It’s also a way to track performance, which is often a sign or a cause of a bug.
Deduplication of log entries. When a bug causes an error, it can fill up the logs pretty quickly. Just combing through the logs with hundreds or thousands of the same entry is a showstopper. Deduplication takes away the pain!
You can configure many of the PHP logging utilities to work with Stackify Retrace by following this guide. Retrace works with PHP, and it does all of these things for you. Plus, it automatically collects lightweight traces—and only when it should.

Sure, Retrace is a great tool for detecting bugs! But once you detect them, fix them. Often that means attaching a debugger. Let’s get into that next!

Stepping through code
Now we will talk about debugging by stepping through code. This is what many of us developers think of when we see “debugging.” It’s a common way to debug code (remove defects that cause errors). With a web app or website, debugging is often two-pronged.

Once notified about an error that’s been logged, we can debug if needed. With enough detail in the logs, this should be easy. We might not even have to use a debugger. Often, the less use one, the better. But if you do, here’s how to tackle that!

PHP debugging tools
You can debug PHP using one of many debugging tools to attach a debugger client. PhpStorm works with debug utilities like Xdebug and ZendDebugger.

Being a polyglot, I need an IDE that supports multiple languages, so I’m opting for VS Code these days. I’ve used Xdebug with Visual Studio in the past, so let’s see how we can set it up with VS Code.

The debug server setup is the same, but each client (IDE or CLI) will have a slightly different setup. See, the debug server (a Zend extension) opens a port, and the client communicates with the server through that port. It’s just a matter of configuration and installing the right components.

Here are the steps I’m taking on this journey:




