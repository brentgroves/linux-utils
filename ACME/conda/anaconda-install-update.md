https://docs.anaconda.com/free/anaconda/install/linux/
apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
Installation
For x86 systems.
In your browser, download the Anaconda installer for Linux.
Search for “terminal” in your applications and click to open.
(Recommended) Verify the installer’s data integrity with SHA-256. For more information on hash verification, see cryptographic hash validation.
In the terminal, run the following:
shasum -a 256 /PATH/FILENAME
# Replace /PATH/FILENAME with your installation's path and filename.
Install for Python 3.7 or 2.7 in the terminal:
For Python 3.7, enter the following:
# Include the bash command regardless of whether or not you are using the Bash shell
bash ~/Downloads/Anaconda3-2020.05-Linux-x86_64.sh
# Replace ~/Downloads with your actual path
# Replace the .sh file name with the name of the file you downloaded

# Verify install
https://docs.anaconda.com/free/anaconda/install/verify-install/
After opening Anaconda Prompt or the terminal, choose any of the following methods to verify:
Enter conda list. If Anaconda is installed and working, this will display a list of installed packages and their versions.
Enter the command python. This command runs the Python shell, also known as the REPL. If Anaconda is installed and working, the version information it displays when it starts up will include “Anaconda”. To exit the Python shell, enter the command quit().

Open Anaconda Navigator with the command anaconda-navigator. If Anaconda is installed properly, Anaconda Navigator will open.


https://docs.anaconda.com/free/anaconda/install/update-version/
To update to the latest version of Anaconda, enter these commands:

#update the conda package manager to the latest version
conda update conda
#use conda to update Anaconda to the latest version
conda update anaconda

conda update --all will unpin everything. This updates all packages in the current environment to the latest version. In doing so, it drops all the version constraints from the history and tries to make everything as new as it can.

Removing packages has the same behavior. If any packages are orphaned by an update, they are removed. conda update --all may not be able to make everything the latest versions because you may have conflicting constraints in your environment.

With Anaconda 2019.07’s newer Anaconda metapackage, conda update --all will make the metapackage go to the custom version in order to update other specs.

conda update --all will only update the selected environment. If you have other environments you’d like to update, update them in the command line with the following:

conda update -n myenv --all
When you use conda update pkgName or conda install pkgName, conda may not be able to update or install that package without changing something else you specified in the past.

In the case of the Anaconda metapackage, when you enter conda update ipython but you have Anaconda 2019.03 currently installed, conda can and should “downgrade” Anaconda to the “custom” version so that iPython can be updated.

When conda cannot fulfill the request for the latest package available, it usually means that newer packages exist for your spec but are in conflict. To force the change, try conda install <PACKAGE_NAME>=<NEW_VERSION>.