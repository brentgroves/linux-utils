https://www.hostinger.com/tutorials/how-to-install-anaconda-on-ubuntu/
setw synchronize-panes off

conda env create -f env-reports.yml
AssertionError('Prefix record insertion error: a record with name _libgcc_mutex already exists in the prefix. This is a bug in conda. Please report it at https://github.com/conda/conda/issues')
()

**uninstall**
conda install anaconda-clean

# If you don't want to be asked about each file and directory
conda anaconda-clean --yes

anaconda-clean creates a backup of all files and directories that might be removed in a folder named .anaconda_backup in your home directory. Also note that anaconda-clean leaves your data files in the AnacondaProjects directory untouched.

rm -rf ~/anaconda3

**openssl**
when creating a new environment it looks like conda uses the first openssl library on the $PATH, ie which openssl, and copies it into the environment directory.

https://docs.anaconda.com/anaconda/install/uninstall/
conda update -n base -c defaults conda


https://docs.anaconda.com/anaconda/install/linux/ 

sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 

download installer
https://www.anaconda.com/products/distribution#linux

cd ~/Downloads
make sure the correct version of openssl is in use before installing conda.
# check for latest versions 
curl -LO https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
    wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh

bash ~/Downloads/Anaconda3-2022.05-Linux-x86_64.sh 

Close and open your terminal window for the installation to take effect, or you can enter the command source ~/.bashrc. 

cd ~/src
# update conda did not work on 1/25/23
conda update -n base -c defaults conda
git clone git@github.com:brentgroves/conda-env.git
cd ~/src/conda-env
conda env create -f env-reports.yml 

conda activate reports 

/home/mis1/src/jupyter-notebooks 

jupyter lab --app_dir= /home/mis1/anaconda3/bin/jupyter --preferred_dir /home/mis1/src/jupyter-notebooks 

jupyter lab --app_dir= /home/mis1/src/jupyter-notebooks --preferred_dir /home/mis1/src/jupyter-notebooks 


-L in case the page has moved (3xx response) curl will redirect the request to the new address

https://stackoverflow.com/questions/6881034/curl-to-grab-remote-filename-after-following-location
remote name
-O This option is probably much better known as its short form: -O (upper case letter o). The name is extracted from the given URL. Even if you tell curl to follow redirects, which then may go to URLs using different file names, the selected local file name is the one in the original URL


When downloading a file using curl, how would I follow a link location and use that for the output filename (without knowing the remote filename in advance)?

For example, if one clicks on the link below, you would download a filenamed "pythoncomplete.vim." However using curl's -O and -L options, the filename is simply the original remote-name, a clumsy "download_script.php?src_id=10872."

curl -O -L http://www.vim.org/scripts/download_script.php?src_id=10872

In order to download the file with the correct filename you would have to know the name of the file in advance:

curl -o pythoncomplete.vim -L http://www.vim.org/scripts/download_script.php?src_id=10872

It would be excellent if you could download the file without knowing the name in advance, and if not, is there another way to quickly pull down a redirected file via command line?


The remote side sends the filename using the Content-Disposition header.

curl 7.21.2 or newer does this automatically if you specify --remote-header-name / -J.

curl -O -J -L $url

The expanded version of the arguments would be:

curl --remote-name --remote-header-name --location $url

 