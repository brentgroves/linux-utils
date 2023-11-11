https://phoenixnap.com/kb/bash-case-statement

Example 5: Check Character Type
The following example shows how to use the case statement to check which character type the user has entered.

Follow the steps below:

1. Create the script:

vi character.sh

2. Add the following lines and save the script:

#!/bin/bash
echo "Enter a character:"
read var
case $var in
  [[:lower:]) echo "You entered a lowercase character.";;
  [[:upper:]]) echo "You entered an uppercase character.";;
  [0-9]) echo "You entered a digit.";;
  ?) echo "You entered a special character.";;
  *) echo "You entered multiple characters.";;
esac


In the above example:

The $var control variable stores the input.
Instead of typing all possible combinations to match against, use the square brackets [] to denote a character range. Use double square brackets [[]] for POSIX ranges. if-else requires entering each character condition individually.
The ? character covers characters that aren't lowercase, uppercase, or digits. It substitutes only one character, as opposed to * which replaces everything else not covered by the conditions above.
Note: Although it is possible to use [a-z] to denote a lowercase character range, uppercase characters are trapped as well on some Linux distributions.

shopt -s nocasematch

#!/bin/bash
echo "Which color do you like best?"
echo "1 - Blue"
echo "2 - Red"
echo "3 - Yellow"
echo "4 - Green"
echo "5 - Orange"
read color;
case $color in
  1) echo "Blue is a primary color.";;
  2) echo "Red is a primary color.";;
  3) echo "Yellow is a primary color.";;
  4) echo "Green is a secondary color.";;
  5) echo "Orange is a secondary color.";;
  *) echo "This color is not available. Please choose a different one.";; 
esac

#!/bin/bash
shopt -s nocasematch
echo "Enter the name of a month."
read month
case $month in
  February)
 
echo "There are 28/29 days in $month.";;
  April | June | September | November)
echo "There are 30 days in $month.";;
  January | March | May | July | August | October | December)
echo "There are 31 days in $month.";;
  *)
echo "Unknown month. Please check if you entered the correct month name: $month";;
esac

#!/bin/bash

echo -n "Enter the name of a country: "
read COUNTRY

echo -n "The official language of $COUNTRY is "

case $COUNTRY in

  Lithuania)
    echo -n "Lithuanian"
    ;;

  Romania | Moldova)
    echo -n "Romanian"
    ;;

  Italy | "San Marino" | Switzerland | "Vatican City")
    echo -n "Italian"
    ;;

  *)
    echo -n "unknown"
    ;;
esac

Example 3: for Loops
Use a for loop in case statements when there are many expressions to process. The following script returns all types of files from a directory.

Follow the steps below:

1. Create the shell script:

vi filelist.sh

2. Enter the following lines and then save the script:

#!/bin/bash
for file in $(ls)
do
Extension=${file##*.}
case "$Extension" in
  sh) echo "Shell script: $file";;
  md) echo "A markdown file: $file";;
  png) echo "PNG image file: $file";;
  txt) echo "A text file: $file";;
  zip) echo "An archive: $file";;
  conf) echo "A configuration file: $file";;
  py) echo "A Python script: $file";;
  *) echo "Unknown file type: $file";;
esac
done
case Statement Syntax #
The Bash case statement takes the following form:

case EXPRESSION in

  PATTERN_1)
    STATEMENTS
    ;;

  PATTERN_2)
    STATEMENTS
    ;;

  PATTERN_N)
    STATEMENTS
    ;;

  *)
    STATEMENTS
    ;;
esac
Copy
Each case statement starts with the case keyword, followed by the case expression and the in keyword. The statement ends with the esac keyword.
You can use multiple patterns separated by the | operator. The ) operator terminates a pattern list.
A pattern can have special characters .
A pattern and its associated commands are known as a clause.
Each clause must be terminated with ;;.
The commands corresponding to the first pattern that matches the expression are executed.
It is a common practice to use the wildcard asterisk symbol (*) as a final pattern to define the default case. This pattern will always match.
If no pattern is matched, the return status is zero. Otherwise, the return status is the exit status of the executed commands.

https://phoenixnap.com/kb/bash-case-statement
Bash case Statement Syntax
The bash case statement takes the following syntax:

case $variable in
pattern-1)
  commands;;
pattern-2)
  commands;;
pattern-3)
  commands;;
pattern-N)
  commands;;
*)
  commands;;
esac

The case statement starts with the case keyword followed by the $variable and the in keyword. The statement ends with the case keyword backwards - esac.

$variable

The script compares the input $variable against the patterns in each clause until it finds a match.
Patterns

A pattern and its commands make a clause, which ends with ;;.
Patterns support special characters.
The ) operator terminates a pattern list.
The | operator separates multiple patterns.
The script executes the commands corresponding to the first pattern matching the input $variable.
The asterisk * symbol defines the default case, usually in the final pattern.
Exit Status

The script has two exit statuses:

0. The return status when the input matches no pattern.
Executed command status. If the command matches the input variable to a pattern, the executed command exit status is returned.
