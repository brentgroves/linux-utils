https://www.geeksforgeeks.org/tr-command-in-unix-linux-with-examples/

tr
Unix-like operating system command
tr is a command in Unix, Plan 9, Inferno, and Unix-like operating systems. It is an abbreviation of translate or transliterate, indicating its operation of replacing or removing specific characters in its input data set. Wikipedia
Stands for: Translate
Function: Translate, squeeze, and/or delete characters from standard input, writing to standard output
Syntax: tr -cds STRING1 STRING2
Example: tr A-Z a-z <mixed >lower



$ SIGNATURE_HEX=$(openssl x509 -in stackexchange.crt -text -noout -certopt ca_default -certopt no_validity -certopt no_serial -certopt no_subject -certopt no_extensions -certopt no_signame | grep -v 'Signature Algorithm' | tr -d '[:space:]:')
   
$ echo $SIGNATURE_HEX 

tr
Unix-like operating system command
tr is a command in Unix, Plan 9, Inferno, and Unix-like operating systems. It is an abbreviation of translate or transliterate, indicating its operation of replacing or removing specific characters in its input data set. Wikipedia
Stands for: Translate
Function: Translate, squeeze, and/or delete characters from standard input, writing to standard output
Syntax: tr -cds STRING1 STRING2
Example: tr A-Z a-z <mixed >lower
