Add to favorites 
[Desktop Entry] 
Type=Application 
Encoding=UTF-8 
Name=Notebooks 
Comment=Jupyter Notebooks 
Exec=notebooks 
Icon=my_application.png 
Terminal=false 

Conda 
https://docs.anaconda.com/anaconda/install/linux/ 
apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 
bash ~/Downloads/Anaconda3-2020.02-Linux-x86_64.sh 
Close and open your terminal window for the installation to take effect, or you can enter the command source ~/.bashrc. 
conda env create -f environment.yml 
conda activate reports 
/home/mis1/src/jupyter-notebooks 
jupyter lab --app_dir= /home/mis1/anaconda3/bin/jupyter --preferred_dir /home/mis1/src/jupyter-notebooks 
jupyter lab --app_dir= /home/mis1/src/jupyter-notebooks --preferred_dir /home/mis1/src/jupyter-notebooks 