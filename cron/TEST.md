# start a container and watch tail /var/log/cron.log
# as it populates.
docker run --name cron-test -d brentgroves/cron-test:7

# you may have to remove the container manually
docker container rm --force 3fc31553840d

# start a container in the background
docker run --name cron-test -d brentgroves/cron-test:7

# Next, execute a command on the container.
docker exec -it cron-test pwd
docker exec -it cron-test pgrep cron
docker exec -it cron-test tail /var/log/cron.log

# Next, execute a command on the container but cant see results.
docker exec -d cron-test chmod 666 /var/log/cron.log && cat /dev/null > /var/log/cron.log

# Next, execute an interactive bash shell on the container.
docker exec -it cron-test bash

# view the cron log
cat /var/log/cron.log
# empy the cron log
cat /dev/null > /var/log/cron.log

# activate the email job.
crontab -l
crontab /etc/cron.d/email-cron
crontab -l


# activate the log-email job.
crontab /etc/cron.d/log-email-cron

# deactivate them log email job
crontab -r

# verify no cron jobs are active
crontab -l

# clean up
docker container rm --force 13fce4d91185

# Test on K8s
# create pod
kubectl apply -f cron-hostnetwork-pod.yaml

# verify pod was created 
kubectl get pods -o wide

# shell to pod
kubectl exec --stdin --tty cron-hostnetwork-pod -- /bin/bash
# is cron running? YES
pgrep cron

# view the cron log
cat /var/log/cron.log
# empy the cron log
cat /dev/null > /var/log/cron.log

# can we see the mobex mail server? 
dig mobexglobal-com.mail.protection.outlook.com
# can we send an email?
echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail from cron-test pod" bgroves@buschegroup.com

# activate the email job.
crontab /etc/cron.d/email-cron
crontab -l
# a# wait to see if email is sent

#activate the log-email job.
crontab /etc/cron.d/log-email-cron
crontab -l
# a# wait to see if /var/log/cron.log is being populate and email is sent

# deactivate them email job
crontab -r
crontab -l



https://gist.github.com/movd/7a9e3db63d076f85d16c7dcde62fe401
mobexglobal-com.mail.protection.outlook.com
https://marlam.de/msmtp/
http://manpages.ubuntu.com/manpages/bionic/en/man1/msmtp.1.html

Check that default account is pointing to mobexglobal smtp server. 
vim /etc/msmtprc

Make sure alias root has been added and the mail transfer agent points to msmtp
vim /etc/mail.rc
set mta=/usr/bin/msmtp
alias root root<bgroves@buschegroup.com>

Set these aliases.
# Send root to Jane
root: bgroves@buschegroup.com
   
# Send everything else to admin
default: bgroves@buschegroup.com
vim /etc/aliases

can we see the mobex mail server?
dig mobexglobal-com.mail.protection.outlook.com
can we send an email?
echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail 2 from py-etl-training pod" bgroves@buschegroup.com

send email from python script
python send_email.py

Test web service etl script 
python ws_to_cm_test.py
python ws_to_dw_test.py