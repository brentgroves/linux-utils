However, instead of repeatedly typing vendor/bin/sail to execute Sail commands, you may wish to configure a shell alias that allows you to execute Sail's commands more easily:

https://tecadmin.net/tutorial/bash-check-if-file-exists
if file exists then run it else run vender/bin/sail
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'