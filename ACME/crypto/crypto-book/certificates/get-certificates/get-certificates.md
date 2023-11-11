https://stackoverflow.com/questions/39356413/how-to-add-a-custom-ca-root-certificate-to-the-ca-store-used-by-pip-in-windows

Set the configuration in pip and conda so that it knows where this CA store resides with our extra self-signed CA.

# Windows
pip config set global.cert %USERPROFILE%\certs\ca-bundle.crt
conda config --set ssl_verify %USERPROFILE%\certs\ca-bundle.crt
OR

# Linux / macOS
pip config set global.cert $HOME/certs/ca-bundle.crt
conda config --set ssl_verify $HOME/certs/ca-bundle.crt
THEN

pip config list
conda config --show ssl_verify

# Hot tip: use -v to show where your pip config file is...
pip config list -v
# Example output for macOS and homebrew installed python
For variant 'global', will try loading '/Library/Application Support/pip/pip.conf'
For variant 'user', will try loading '/Users/jpeak/.pip/pip.conf'
For variant 'user', will try loading '/Users/jpeak/.config/pip/pip.conf'
For variant 'site', will try loading '/usr/local/Cellar/python/3.7.4/Frameworks/Python.framework/Versions/3.7/pip.conf'