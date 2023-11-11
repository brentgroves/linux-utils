echo "welcome" >> welcome.msg 
Linux upload single quotes
curl -T welcome.msg -u 'brent:JesusLives1!' ftp://172.20.88.64/
Windows upload double quotes
curl -T welcome.msg -u "brent:JesusLives1!" ftp://172.20.88.64/


curl ftp://brent:JesusLives1!@172.20.88.64