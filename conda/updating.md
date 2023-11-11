https://www.hostinger.com/tutorials/how-to-install-anaconda-on-ubuntu/
https://github.com/conda/conda/issues/11795

Updating Anaconda
This did not work for me. 
conda update -n base -c defaults conda
it always says 4.12.0 
In case you ever need to update Anaconda, start by updating the conda package manager first:

conda update conda
Then, update the actual Anaconda distribution:

conda update anaconda
Wait a few minutes until the installer successfully completes the Anaconda installation process, type “y” and press Enter.

Uninstalling Anaconda

In order to uninstall Anaconda, install the following anaconda-clean package:

conda install anaconda-clean
Lastly, remove all Anaconda-related files and directories:

anaconda-clean