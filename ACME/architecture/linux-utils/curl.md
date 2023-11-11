sudo snap install curl

https://www.geeksforgeeks.org/curl-command-in-linux-with-examples/
https://man7.org/linux/man-pages/man1/curl.1.html

 curl -L https://k8s.io/examples/application/shell-demo.yaml -o shell-demo.yaml
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
RUN sudo curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list



      -O, --remote-name
              Write output to a local file named like the remote file we
              get. (Only the file part of the remote file is used, the
              path is cut off.)

              The file will be saved in the current working directory.
              If you want the file saved in a different directory, make
              sure you change the current working directory before
              invoking curl with this option.

              The remote file name to use for saving is extracted from
              the given URL, nothing else, and if it already exists it
              will be overwritten. If you want the server to be able to
              choose the file name refer to -J, --remote-header-name
              which can be used in addition to this option. If the
              server chooses a file name and that name already exists it
              will not be overwritten.

              There is no URL decoding done on the file name. If it has
              %20 or other URL encoded parts of the name, they will end
              up as-is as file name.

              You may use this option as many times as the number of
              URLs you have.

 -L, --location
              (HTTP) If the server reports that the requested page has
              moved to a different location (indicated with a Location:
              header and a 3XX response code), this option will make
              curl redo the request on the new place. If used together
              with -i, --include or -I, --head, headers from all
              requested pages will be shown. When authentication is
              used, curl only sends its credentials to the initial host.
              If a redirect takes curl to a different host, it won't be
              able to intercept the user+password. See also --location-
              trusted on how to change this. You can limit the amount of
              redirects to follow by using the --max-redirs option.

              When curl follows a redirect and if the request is a POST,
              it will send the following request with a GET if the HTTP
              response was 301, 302, or 303. If the response code was
              any other 3xx code, curl will re-send the following
              request using the same unmodified method.

              You can tell curl to not change POST requests to GET after
              a 30x response by using the dedicated options for that:
              --post301, --post302 and --post303.

              The method set with -X, --request overrides the method
              curl would otherwise select to use.

curl is a command-line tool to transfer data to or from a server, using any of the supported protocols (HTTP, FTP, IMAP, POP3, SCP, SFTP, SMTP, TFTP, TELNET, LDAP, or FILE). curl is powered by Libcurl. This tool is preferred for automation since it is designed to work without user interaction. curl can transfer multiple files at once. 
Syntax:  

curl [options] [URL...]
URL: The most basic use of curl is typing the command followed by the URL.  

curl https://www.geeksforgeeks.org
This should display the content of the URL on the terminal. The URL syntax is protocol dependent and multiple URLs can be written as sets like: 

curl http://site.{one, two, three}.com
URLs with numeric sequence series can be written as: 

curl ftp://ftp.example.com/file[1-20].jpeg
Progress Meter: curl displays a progress meter during use to indicate the transfer rate, amount of data transferred, time left, etc. 

curl -# -O ftp://ftp.example.com/file.zip
curl --silent ftp://ftp.example.com/file.zip
If you like a progress bar instead of a meter, you can use the -# option as in the example above, or –silent if you want to disable it completely. 

Options: 
-o: saves the downloaded file on the local machine with the name provided in the parameters. 
Syntax:

curl -o [file_name] [URL...]
Example:
curl -o hello.zip ftp://speedtest.tele2.net/1MB.zip


The above example downloads the file from the FTP server and saves it with the name hello.zip.
-O: This option downloads the file and saves it with the same name as in the URL. 
Syntax:

curl -O [URL...]
Example:
curl -O ftp://speedtest.tele2.net/1MB.zip


-C -: This option resumes download which has been stopped due to some reason. This is useful when downloading large files and was interr

d. 
Syntax:
curl -C - [URL...]
Example:
curl -C - -O ftp://speedtest.tele2.net/1MB.zip

–limit-rate: This option limits the upper bound of the rate of data transfer and keeps it around the given value in bytes. 
Syntax:

curl --limit-rate [value] [URL]
Example:
curl --limit-rate 1000K -O ftp://speedtest.tele2.net/1MB.zip

The command limits the download to 1000K bytes.
-u: curl also provides options to download files from user authenticated FTP servers. 
Syntax:

curl -u {username}:{password} [FTP_URL]
Example:
curl -u demo:password -O ftp://test.rebex.net/readme.txt


-T: This option helps to upload a file to the FTP server. 
Syntax:

curl -u {username}:{password} -T {filename} {FTP_Location}
If you want to append an already existing FTP file you can use the -a or –append option.
–libcurl: This option is very useful from a developer’s perspective. If this option is appended to any cURL command, it outputs the C source code that uses libcurl for the specified option. It is a code similar to the command line implementation. 
Syntax: 

curl [URL...] --libcurl [filename]
Example:
curl https://www.geeksforgeeks.org > log.html --libcurl code.c

The above example downloads the HTML and saves it into log.html and the code in code.c file. The next command shows the first 30 lines of the code.
-x, –proxy: curl also lets us use a proxy to access the URL. 
Syntax:

curl -x [proxy_name]:[port] [URL...]
If the proxy requires authentication, it can be used with the command: 
curl -u [user]:[password] -x [proxy_name]:[port] [URL...]
Sending mail: As curl can transfer data over different protocols, including SMTP, we can use curl to send mails. 
Syntax: 

curl –url [SMTP URL] –mail-from [sender_mail] –mail-rcpt [receiver_mail] -n –ssl-reqd -u {email}:{password} -T [Mail text file] 

DICT protocol: The Libcurl defines the DICT protocol which can be used to easily get the definition or meaning of any word directly from the command line. 
Syntax: 

curl [protocol:[dictionary_URL]:[word]
Example:
curl dict://dict.org/d:overclock
