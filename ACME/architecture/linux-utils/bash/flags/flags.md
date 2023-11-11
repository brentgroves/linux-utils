https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script

Using flags is a common way of passing input to a script. When passing input to the script, there’s a flag (usually a single letter) starting with a hyphen (-) before each argument.

Let’s take a look at the userReg-flags.sh script, which takes three arguments: username (-u), age (-a), and full name (-f).

We’ll modify the earlier script to use flags instead of relying on positional parameters. The getopts function reads the flags in the input, and OPTARG refers to the corresponding values:

while getopts u:a:f: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        a) age=${OPTARG};;
        f) fullname=${OPTARG};;
    esac
done
echo "Username: $username";
echo "Age: $age";
echo "Full Name: $fullname";
Let’s run this script with the same input as before, only this time, we’ll add flags to the input:

sh userReg-flags.sh -f 'John Smith' -a 25 -u john
The output is the same as before, though we have shifted the positions of the username and full name arguments:

Username : john
Age: 25
Full Name: John Smith
Here we’re using the getopts function to parse the flags provided as input, and the case block to assign the value specified to the corresponding variable.

