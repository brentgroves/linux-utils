https://www.geeksforgeeks.org/file-command-in-linux-with-examples/

ile command is used to determine the type of a file. .file type may be of human-readable(e.g. ‘ASCII text’) or MIME type(e.g. ‘text/plain; charset=us-ascii’). This command tests each argument in an attempt to categorize it.

It has three sets of tests as follows:

filesystem test: This test is based on the result which returns from a stat system call. The program verifies that if the file is empty, or if it’s some sort of special file. This test causes the file type to be printed.
magic test: These tests are used to check for files with data in particular fixed formats.
language test: This test search for particular strings which can appear anywhere in the first few blocks of a file.
Syntax:

file [option] [filename]
