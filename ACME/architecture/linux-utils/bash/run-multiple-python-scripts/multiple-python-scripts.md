This works for me:

Create a new shell file job. So let's say: touch job.sh and add command to run python script (you can even add command line arguments to that python, I usually predefine my command line arguments).

chmod +x job.sh

Inside job.sh add the following py files, let's say:

python_file.py argument1 argument2 argument3 >> testpy-output.txt && echo "Done with python_file.py"

python_file1.py argument1 argument2 argument3 >> testpy-output.txt && echo "Done with python_file1.py"

Output of job.sh should look like this:
Done with python_file.py

Done with python_file1.py

I use this usually when I have to run multiple python files with different arguments, pre defined.

Note: Just a quick heads up on what's going on here:

python_file.py argument1 argument2 argument3 >> testpy-output.txt && echo "completed with python_file.py" . 
Here shell script will run the file python_file.py and add multiple command-line arguments at run time to the python file.
This does not necessarily means, you have to pass command line arguments as well.
You can just use it like: python python_file.py, plain and simple. Next up, the >> will print and store the output of this .py file in the testpy-output.txt file.
&& is a logical operator that will run only after the above is executed successfully and as an optional echo "completed with python_file.py" will be echoed on to your cli/terminal at run time.