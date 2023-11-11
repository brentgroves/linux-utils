http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_split_path_info
Defines a regular expression that captures a value for the $fastcgi_path_info variable. The regular expression should have two captures: the first becomes a value of the $fastcgi_script_name variable, the second becomes a value of the $fastcgi_path_info variable. For example, with these settings

location ~ ^(.+\.php)(.*)$ {
    fastcgi_split_path_info       ^(.+\.php)(.*)$;
    fastcgi_param SCRIPT_FILENAME ^(.+\.php)(.*)$;
    fastcgi_param PATH_INFO       $fastcgi_path_info;
and the “/show.php/article/0001” request, the SCRIPT_FILENAME parameter will be equal to “/path/to/php/show.php”, and the PATH_INFO parameter will be equal to “/article/0001”.

