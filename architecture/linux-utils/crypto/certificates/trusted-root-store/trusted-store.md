https://thomas-leister.de/en/how-to-import-ca-root-certificate/

sudo mkdir /usr/local/share/ca-certificates/extra
sudo cp root.cert.pem /usr/local/share/ca-certificates/extra/root.cert.crt
sudo cp mobexroot.crt /usr/local/share/ca-certificates/extra/mobexroot.crt
sudo update-ca-certificates