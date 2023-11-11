https://www.thegeekstuff.com/2010/07/bash-string-manipulation/
2. Extract a Substring from a Variable inside Bash Shell Script
Bash provides a way to extract a substring from a string. The following example expains how to parse n characters starting from a particular position.

${string:position}
Extract substring from $string at $position

${string:position:length}
Extract $length of characters substring from $string starting from $position. In the below example, first echo statement returns the substring starting from 15th position. Second echo statement returns the 4 characters starting from 15th position. Length must be the number greater than or equal to zero.

$ cat substr.sh
#! /bin/bash

var="Welcome to the geekstuff"

echo ${var:15}
echo ${var:15:4}

$ ./substr.sh
geekstuff
geek
