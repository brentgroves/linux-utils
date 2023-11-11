Note: This may have been done from the cron install.

sudo apt-get update -y
sudo apt-get install -yq msmtp msmtp-mta mailutils bsd-mailx  

smtp server: mobexglobal-com.mail.protection.outlook.com
cd /home/brent/src/linux-utils/email/mail
sudo cp msmtprc /etc/
sudo mv /etc/mail.rc /etc/mailbak.rc
sudo cp mail.rc /etc/
sudo cp aliases /etc/

printf "Test email from Ubuntu 22.04." | mail -s "MCP email test" bgroves@buschegroup.com


