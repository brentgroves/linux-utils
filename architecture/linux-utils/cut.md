https://www.geeksforgeeks.org/cut-command-linux-examples/
The cut command in UNIX is a command for cutting out the sections from each line of files and writing the result to standard output. It can be used to cut parts of a line by byte position, character and field. Basically the cut command slices a line and extracts the text. It is necessary to specify option with command otherwise it gives error. If more than one file name is provided then data from each file is not precedes by its file name.

$ cat state.txt
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh

1. -b(byte): To extract the specific bytes, you need to follow -b option with the list of byte numbers separated by comma. Range of bytes can also be specified using the hyphen(-). It is necessary to specify list of byte numbers otherwise it gives error. Tabs and backspaces are treated like as a character of 1 byte.

List without ranges
$ cut -b 1,2,3 state.txt
And
Aru
Ass
Bih
Chh


List with ranges
$ cut -b 1-3,5-7 state.txt
Andra
Aruach
Assm
Bihr
Chhtti