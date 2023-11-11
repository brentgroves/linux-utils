#!/miniconda/bin/python
#!/usr/bin/python
# https://www.tutorialspoint.com/python/python_sending_email.htm
# https://www.ionos.com/digitalguide/e-mail/technical-matters/smtp/
import smtplib
from smtplib import SMTPException

sender = 'mcp@mobexglobal.com'
receivers = ['bgroves@buschegroup.com']

message = """From: Mobex Computing Platform <mcp@mobexglobal.com>
To: Brent Groves <bgroves@buschegroup.com>
MIME-Version: 1.0
Content-type: text/html
Subject: SMTP e-mail test

This is an e-mail message to be sent in HTML format

<b>This is HTML message.</b>
<h1>This is headline.</h1>
"""

# try:
#    smtpObj = smtplib.SMTP('mobexglobal-com.mail.protection.outlook.com')
#    smtpObj.sendmail(sender, receivers, message)         
#    print("Successfully sent email")
# except Exception:
#    print("Error: unable to send email")

try:
   smtpObj = smtplib.SMTP('mobexglobal-com.mail.protection.outlook.com')
   smtpObj.sendmail(sender, receivers, message)         
   print("Successfully sent email")
except SMTPException:
   print("Error: unable to send email")   