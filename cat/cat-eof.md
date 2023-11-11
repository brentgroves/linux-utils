https://linuxhint.com/what-is-cat-eof-bash-script/

CAT is a command of Bash in the Linux operating system. CAT is the abbreviation of concentrate. In the Linux operating system, the cat command is used to display the file, read a file, or concentrate the content of the file as the name explains. It takes a file, reads its content or data, and then outputs the content of the files. It also helps us with the creation of files. This command comes with many options that help us to perform the actions with the file according to our needs.

In CAT command, there is a term which is known as EOF. EOF means the end of the file. EOF indicates that the file that is read, created, or concentrated by the CAT command has ended. The cat<<eof uses “here-document”. A here-document is a code block in Linux. It passes a form of Input/Output redirection to commands like cat. In the cat command, it passes the redirection operations “<<” and “<<-” to the command. Both these operations allow the redirection of subsequent lines that are read, created, or concentrated by Bash. The following format is used by here-document:

cat << delimeter
     here-document
delimiter

Example:
In this example, we first print the content of the file and then copy the content to another one. To do so, we first create a Bash script in which we store some content which is then copied to the other file. Let us first create a new Bash file. We can simply create the Bash file by writing the command or by simply using the notepad. In this example, we create a new Bash file using the command.

To create the new file, we write the following command:

linux@linux-Virtualbox:~$ nano bash.sh
 
In the previously-mentioned command, we create and open the “bash.sh” file using the “nano” text editor. As we can see in the following illustration, the file named “bash.sh” is opened while pressing enter. After we add some content to the file, we then print it to the other file. In this file, the content is added between the “cat<<EOF” and “EOF” commands which tell the compiler to print the content from the “cat<<EOF” command at the end until “EOF” is reached.

As we can see in the following snippet, our file is successfully created and saved in our home directory. One thing to remember is when we don’t add the path while creating a new file, it is automatically saved in the home directory. If we want to store it in the desired location, we can pass the path along with it. The Bash file always contains the “.sh” extension but the file name can be of your choice.


Now, let us display the data from the file that we added to it. To print the data, we simply write the following command:

linux@linux-Virtualbox:~$ bash bash.sh
 
The Bash command along with the file having the “.sh” extension is passed to it. It means that it prints the content of the Bash file. After running this command by pressing “enter”, we get the following output in which the content that is written inside the “cat<<EOF” and “EOF” commands.


Now, we try to see what happens if we add “EOF” between the paragraphs, whether it prints the whole file or not. In the following snippet, we add the “EOF” command after the first line. Now, using the Bash command, we print the Bash file again.

linux@linux-Virtualbox:~$ bash bash.sh
 

As we can see, it just displays the first line which is the “ this is my first EOF” command. It did not display the content that was written after that command. Instead, it displays the error message that the “command is not found”. This means that when we try to print the content from one file to the other, it only adds the content that is inside the “cat EOF” command. The other content is ignored.

linux@linux-Virtualbox:~$ bash bash.sh
 

Now, let us print the same file to the other file. For that, we first create a variable inside the Bash file that we created named “bash.sh”. We assign the path to this variable where the new file is created to which the content and the name of the file are copied. Let’s suppose we named it “bashcopy.txt”. This means that we want to copy the content of the Bash in which we declare as a variable named “myvar”. By assigning it, we create the path and the name of the file with a text file with “.txt” extension. Then, after writing the “cat<<EOF” command, we pass the variable along with the dollar sign.


