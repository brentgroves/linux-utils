https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script

Shift operator in bash (syntactically shift n, where n is the number of positions to move) shifts the position of the command line arguments. The default value for n is one if not specified.

The shift operator causes the indexing of the input to start from the shifted position. In other words, when this operator is used on an array input, the positional parameter $1 changes to the argument reached by shifting n positions to the right from the current argument bound to positional parameter $1.

Consider an example script that determines whether the input is odd or even:

sh parityCheck.sh 13 18 27 35 44 52 61 79 93
From the above discussion on the positional parameter, we now know that $1 refers to the first argument, which is 13. Using the shift operator with input 1 (shift 1) causes the indexing to start from the second argument. That is, $1 now refers to the second argument (18). Similarly, calling shift 2 will then cause the indexing to start from the fourth argument (35).

Let’s again take a look at the example of users script discussed above. Instead of using the $@ variable and iterating over it, we’ll now use the shift operator. The $# variable returns the input size:

i=1;
j=$#;
while [ $i -le $j ] 
do
    echo "Username - $i: $1";
    i=$((i + 1));
    shift 1;
done
Let’s run the script with the same input as above:

sh users-shift-operator.sh john matt bill 'joe wicks' carol
The output will be the same as before:

Username - 1: john
Username - 2: matt
Username - 3: bill
Username - 4: joe wicks
Username - 5: carol
In this example, we’re shifting the positional parameter in each iteration by one until we reach the end of the input. Therefore, $1 refers to the next element in the input each time.

