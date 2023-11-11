tr -d '[blank]'

That should be [:blank:], otherwise it will simply delete all instances of [, b, l, a, n, k, and ] in the file.

12


If you want to squeeze "white space" you will want to use tr's pre-defined character sets ":blank:" (horizontal whitespace tab and space) or ":space:" (verical whitespace) :

/bin/echo -e  "val1\t\tval2   val3" | tr -s "[:blank:]"
Examples were run on Red Hat 5 (GNU tr).

In my case I wanted to normalize all whitespace to a single space so I could rely on the space as a delmitter.

As pointed out by dastrobu's second comment I missed the wording in the man page:

 -s uses the last specified SET, and occurs after translation or deletion.
This allows us to eliminate the first tr. Kudo's to scott for his patiences in the face of my denseness.

Before, parsing port from Redis config. file:

grep "^port" $redisconf | tr "[:blank:]" " " | tr -s "[:blank:]"  | cut -d" " -f2
After, with SET2 being specified with the squeeze:

grep "^port" $redisconf | tr -s "[:blank:]" " " | cut -d" " -f2
Output:

6379
For more details covering the nuances of whitespace

Demonstrate where squeeze alone fails when successive mixed characters which fall into the [:blank:] character class are involved:

 /usr/bin/printf '%s \t %s' id myname | tr -s "[:blank:]"  | od -cb
0000000   i   d      \t       m   y   n   a   m   e
        151 144 040 011 040 155 171 156 141 155 145
0000013
Note: My two string fields in the printf format are separated by 1 space, 1 tab, 1 space. After the squeeze this sequence still exists. In the output of the Octal dump this is represented by ascii sequence 040 011 040.

https://stackoverflow.com/questions/4109589/remove-all-whitespaces-in-a-file-linux/4109660#4109660