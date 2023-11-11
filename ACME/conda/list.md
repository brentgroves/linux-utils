https://docs.conda.io/projects/conda/en/latest/commands/list.html
Examples:

List all packages in the current environment:

conda list
List all packages installed into the environment 'myenv':

conda list -n myenv
List all packages that begin with the letters "py", using regex:

conda list ^py
Save packages for future use:

conda list --export > package-list.txt
Reinstall packages from an export file:

conda create -n myenv --file package-list.txt