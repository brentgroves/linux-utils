https://www.thegeekstuff.com/2010/07/bash-string-manipulation/
https://linuxhint.com/30_bash_script_examples/#t2
3. Shortest Substring Match
Following syntax deletes the shortest match of $substring from front of $string

${string#substring}
Following syntax deletes the shortest match of $substring from back of $string

${string%substring}
Following sample shell script explains the above two shortest substring match concepts.

$ cat shortest.sh
#! /bin/bash

filename="bash.string.txt"

echo ${filename#*.}
echo ${filename%.*}

$ ./shortest.sh
After deletion of shortest match from front: string.txt
After deletion of shortest match from back: bash.string
In the first echo statement substring ‘*.’ matches the characters and a dot, and # strips from the front of the string, so it strips the substring “bash.” from the variable called filename. In second echo statement substring ‘.*’ matches the substring starts with dot, and % strips from back of the string, so it deletes the substring ‘.txt’

USERNAME
USERNAME="${USERNAME:-"${_REMOTE_USER}"}"

