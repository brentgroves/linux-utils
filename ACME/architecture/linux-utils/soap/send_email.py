#!/miniconda/bin/python
#!/usr/bin/python
# https://www.tutorialspoint.com/python/python_sending_email.htm

import smtplib

sender = 'mcp@mobexglobal.com'
receivers = ['bgroves@buschegroup.com']

message = """From: Mobex Computing Platform <mcp@mobexglobal.com>
To: Brent Groves <bgroves@buschegroup.com>
Subject: SMTP e-mail test

This is a test e-mail message.
"""

try:
   smtpObj = smtplib.SMTP('mobexglobal-com.mail.protection.outlook.com')
   smtpObj.sendmail(sender, receivers, message)         
   print("Successfully sent email")
except Exception:
   print("Error: unable to send email")