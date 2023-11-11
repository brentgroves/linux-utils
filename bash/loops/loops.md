https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script

Positional parameters, while convenient in many cases, can’t be used when the input size is unknown. The use of a loop construct comes in handy in these situations.

The variable $@ is the array of all the input parameters. Using this variable within a for loop, we can iterate over the input and process all the arguments passed.

Let’s take an example of the script users-loop.sh, which prints all the usernames that have been passed as input:

i=1;
for user in "$@" 
do
    echo "Username - $i: $user";
    i=$((i + 1));
done
Now let’s run the script:

sh users-loop.sh john matt bill 'joe wicks' carol
And we’ll see our output:

Username - 1: john
Username - 2: matt
Username - 3: bill
Username - 4: joe wicks
Username - 5: carol
In the above example, we’re iterating the user variable over the entire array of input parameters. This iteration starts at the first input argument, john, and runs until the last argument, carol, even though the size of the input is unknown.

