https://unix.stackexchange.com/questions/368123/how-to-extract-the-root-ca-and-subordinate-ca-from-a-certificate-chain-in-linux/487546#487546


https://www.baeldung.com/linux/print-lines-between-two-patterns


2. Introduction to the Problem
First of all, let’s see an example input file. It’ll help us understand the problem quickly:

kent$ cat input.txt
XXXX we want to skip this line XXXX
XXXX we want to skip this line XXXX
DATA BEGIN
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
DATA END
XXXX we want to skip this line XXXX
XXXX we want to skip this line XXXX
DATA BEGIN
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
DATA END
XXXX we want to skip this line XXXX
XXXX we want to skip this line XXXX
Copy
As the output above shows, in the input file, we have lines beginning with “[ Block #x ] …“. Those data blocks always sit between two patterns: “DATA BEGIN” and “DATA END.”

Our goal is to walk through the input file and extract all the data blocks between the two patterns.

Apart from printing the data blocks, in the real world, we may have various requirements regarding their boundaries, which are the lines matching the two patterns:

Including both boundaries
Including the “DATA BEGIN” line only
Including the “DATA END” line only
Excluding both boundaries
In this tutorial, we’re going to cover all the above scenarios, and we’ll address how to solve the problem using GNU Sed and GNU Awk.


Using the sed Command
The sed command is a common command-line text processing utility. It supports address ranges.

For example, sed /Pattern1/, /Pattern2/{ commands }… will apply the commands on the range of lines. In this example, the first line in the range is the line matching /Pattern1/, while the last line in the range is the line matching /Pattern2/.

The sed‘s address range can help us to solve our problem. Next, let take a closer look at the solutions.

3.1. Printing the Data Blocks Including Both Boundaries
First, let’s have a look at the sed command solving the problem:

kent$ sed -n '/DATA BEGIN/, /DATA END/p' input.txt
DATA BEGIN
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
DATA END
DATA BEGIN
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
DATA END

As we can see, the output is what we’re expecting. The command looks pretty straightforward.

But let’s quickly understand the -n option and the p command usage since we will use this combination to solve problems in other scenarios.

The sed command will, by default, print the pattern space at the end of each cycle.

However, in this example, we only want to ask sed to print the lines we need. Therefore, we’ve used the -n option to prevent the sed command from printing the pattern space. Instead, we’ll control the output using the p command.


Unlike the sed command, the awk command supports a scripting language with a “C-like” syntax. We can build our awk command/script using many programming language features we’re familiar with, such as declaring variables, logical operations, and functions.

Next, let’s see how to solve our problem using the awk command.


rinting the Data Blocks Including Both Boundaries
Similar to sed, the awk command supports range patterns too. Therefore, we can solve the problem in the same way:

kent$ awk '/DATA BEGIN/, /DATA END/' input.txt 
DATA BEGIN
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
DATA END
DATA BEGIN
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
DATA END

In the awk command above, we didn’t explicitly write print to output. This is because a boolean True will trigger the default action: print the current line.

Apparently, only the lines within the range pattern will result in True. Therefore, we’ve got the expected data in the output.

Moreover, if a variable holds a non-zero value, the awk command will evaluate this variable as True as well.

Therefore, we can declare a variable to turn on and off printing under certain conditions. In this way, we can control the boundaries output more straightforwardly:

Therefore, we can declare a variable to turn on and off printing under certain conditions. In this way, we can control the boundaries output more straightforwardly:

kent$ awk '/DATA BEGIN/{ f = 1 } f; /DATA END/{ f = 0 }' input.txt
DATA BEGIN
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
DATA END
DATA BEGIN
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
DATA END
Copy
This time, we don’t use the range patterns. Instead, we declared a variable f to work as a switch of the awk printer.

We turn it on when a line matches the “BEGIN” of a data block: /DATA BEGIN/{ f = 1 }, and print the BEGIN boundary by “f;”.

Since the switch f has been turned on, we will print all the following lines until the “END” line comes.

When the “END” line arrives, we first print it since the value of the variable f is still 1. Then, we turn off the switch: /DATA END/{f = 0} to prevent outputting the following lines.

We can use this “printer switch” idea to solve the problem in other scenarios.

Next, let’s see them in detail.

Let’s compare this awk command to the one we print data, including both boundary lines:

... '/DATA BEGIN/{ f = 1 } f; /DATA END/{ f = 0 }' ...  <--- Including both boundaries
... '/DATA BEGIN/{ f = 1 } /DATA END/{ f = 0 } f ' ...  <--- Including the BEGIN boundary only
Copy
The only change we’ve made is to move the f after the “END” pattern check.

If the “END” boundary line comes, we turn off the switch. After that, we check the switch and print the output. That is, the “END” boundary lines won’t be printed.

Printing the Data Blocks Including the “END” Boundary Only
Following the same idea, if we move the f before the “BEGIN” pattern check, the “BEGIN” boundary lines won’t appear in the output:

kent$ awk 'f; /DATA BEGIN/{ f = 1 } /DATA END/{ f = 0 }' input.txt
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
DATA END
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
DATA END
Copy
The command isn’t hard to understand. However, let’s quickly explain why we can use the variable f before assigning a value to it.

In awk, if we use a variable that hasn’t been declared or assigned, its value will be an empty string or the number 0. Further, the variable will be evaluated as False. Thus the default action (print) won’t be triggered.
Printing the Data Blocks Including the “END” Boundary Only
Following the same idea, if we move the f before the “BEGIN” pattern check, the “BEGIN” boundary lines won’t appear in the output:

kent$ awk 'f; /DATA BEGIN/{ f = 1 } /DATA END/{ f = 0 }' input.txt
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
DATA END
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
DATA END
Copy
The command isn’t hard to understand. However, let’s quickly explain why we can use the variable f before assigning a value to it.

In awk, if we use a variable that hasn’t been declared or assigned, its value will be an empty string or the number 0. Further, the variable will be evaluated as False. Thus the default action (print) won’t be triggered.

4.4. Printing the Data Blocks Excluding Both Boundaries
Now, let’s have a look at how to exclude all boundary lines in the output:

kent$ awk '/DATA BEGIN/{ f = 1; next } /DATA END/{ f = 0 } f' input.txt
[ Block #1 ] ... 1992-08-08 08:08:08
[ Block #1 ] ... DATA #1 IN BLOCK
[ Block #1 ] ... 2018-03-06 15:33:23
[ Block #2 ] ... 2021-02-01 00:01:00
[ Block #2 ] ... DATA #2 IN BLOCK
[ Block #2 ] ... 2021-02-02 01:00:00
Copy
This time, we cannot solve the problem only by tunning the position of the variable f.

As the example shows, the tricky part is, when the “BEGIN” pattern comes, we turn the output on and execute the next action immediately: ‘/DATA BEGIN/{ f = 1; next }. 

The next action will stop processing the current line and read the next line from the input. Therefore, we only turn on the switch but don’t print the “BEGIN” boundary.

https://www.baeldung.com/linux/print-lines-between-two-patterns#:~:text=Printing%20the%20Data%20Blocks%20Including%20the,above%20shows%2C%20we%E2%80%99ve%20solved%20the%20problem.

https://www.gnu.org/software/gawk/manual/html_node/Ranges.html

7.1.3 Specifying Record Ranges with Patterns
A range pattern is made of two patterns separated by a comma, in the form ‘begpat, endpat’. It is used to match ranges of consecutive input records. The first pattern, begpat, controls where the range begins, while endpat controls where the pattern ends. For example, the following:

awk '$1 == "on", $1 == "off"' myfile
prints every record in myfile between ‘on’/‘off’ pairs, inclusive.

A range pattern starts out by matching begpat against every input record. When a record matches begpat, the range pattern is turned on, and the range pattern matches this record as well. As long as the range pattern stays turned on, it automatically matches every input record read. The range pattern also matches endpat against every input record; when this succeeds, the range pattern is turned off again for the following record. Then the range pattern goes back to checking begpat against each record.

The record that turns on the range pattern and the one that turns it off both match the range pattern. If you don’t want to operate on these records, you can write if statements in the rule’s action to distinguish them from the records you are interested in.

openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

