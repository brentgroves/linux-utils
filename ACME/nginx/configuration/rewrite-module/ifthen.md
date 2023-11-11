Syntax:	if (condition) { ... }
Default:	—
Context:	server, location
The specified condition is evaluated. If true, this module directives specified inside the braces are executed, and the request is assigned the configuration inside the if directive. Configurations inside the if directives are inherited from the previous configuration level.

A condition may be any of the following:

a variable name; false if the value of a variable is an empty string or “0”;
Before version 1.0.1, any string starting with “0” was considered a false value.
comparison of a variable with a string using the “=” and “!=” operators;
matching of a variable against a regular expression using the “~” (for case-sensitive matching) and “~*” (for case-insensitive matching) operators. Regular expressions can contain captures that are made available for later reuse in the $1..$9 variables. Negative operators “!~” and “!~*” are also available. If a regular expression includes the “}” or “;” characters, the whole expressions should be enclosed in single or double quotes.
checking of a file existence with the “-f” and “!-f” operators;
checking of a directory existence with the “-d” and “!-d” operators;
checking of a file, directory, or symbolic link existence with the “-e” and “!-e” operators;
checking for an executable file with the “-x” and “!-x” operators.
Examples:

if ($http_user_agent ~ MSIE) {
    rewrite ^(.*)$ /msie/$1 break;
}

if ($http_cookie ~* "id=([^;]+)(?:;|$)") {
    set $id $1;
}

if ($request_method = POST) {
    return 405;
}

if ($slow) {
    limit_rate 10k;
}

if ($invalid_referer) {
    return 403;
}
A value of the $invalid_referer embedded variable is set by the valid_referers directive.
