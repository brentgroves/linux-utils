sudo apt-get update
sudo apt-get update && apt-get install -yq \
  tzdata \
  ksh \
  apt-utils \
  apt-transport-https \
  ca-certificates \
  neofetch \
  software-properties-common \
  curl \
  wget \
  dnsutils \
  iputils-ping \
  netcat \
  tree \
  curl \
  vim \
  jq \
  msmtp \
  msmtp-mta \
  mailutils \
  bsd-mailx \
  cron 

  A Mail User Agent (MUA), also referred to as an email client, is a computer application that allows you to send and retrieve email

cd ~/src
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/ETL-Pod
cd ETL-Pod
sudo cp ./install/mail/msmtprc /etc/msmtprc
sudo cp ./install/mail/mail.rc /etc/mail.rc
sudo cp ./install/mail/aliases /etc/aliases

test Thank you Father
printf "Pipeline terminated on $script script." | mail -s "MCP Pipeline Failure" bgroves@buschegroup.com

