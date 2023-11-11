#!/home/bgroves@BUSCHE-CNC.COM/anaconda3/envs/etl/bin/python
# https://www.justintodata.com/send-email-using-python-tutorial/
# https://medium.com/@neonforge/how-to-send-emails-with-attachments-with-python-by-using-microsoft-outlook-or-office365-smtp-b20405c9e63a
# Import modules
import smtplib
## email.mime subclasses
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
### Add new subclass for adding attachments
##############################################################
from email.mime.application import MIMEApplication
##############################################################
## The pandas library is only for generating the current date, which is not necessary for sending emails
import pandas as pd
import os.path

# Define the HTML document
html = '''
    <html>
        <body>
            <h1>Daily S&P 500 prices report</h1>
            <p>Hello, welcome to your report!</p>
        </body>
    </html>
    '''

# Define a function to attach files as MIMEApplication to the email
##############################################################
def attach_file_to_email(email_message, filename):
    # Open the attachment file for reading in binary mode, and make it a MIMEApplication class
    with open(filename, "rb") as f:
        file_attachment = MIMEApplication(f.read())
    filename_only = os.path.basename(filename)    
    # Add header/name to the attachments    
    file_attachment.add_header(
        "Content-Disposition",
        f"attachment; filename= {filename_only}",
    )
    # Attach the file to the message
    email_message.attach(file_attachment)
##############################################################    

# Set up the email addresses and password. Please replace below with your email address and password
email_from = 'mcp@buschegroup.com'
email_to = 'bgroves@buschegroup.com'

# Generate today's date to be included in the email Subject
date_str = pd.Timestamp.today().strftime('%Y-%m-%d')

# Create a MIMEMultipart class, and set up the From, To, Subject fields
email_message = MIMEMultipart()
email_message['From'] = email_from
email_message['To'] = email_to
email_message['Subject'] = f'Report email - {date_str}'

# Attach the html doc defined earlier, as a MIMEText html content type to the MIME message
email_message.attach(MIMEText(html, "html"))

# Attach more (documents)
##############################################################
attach_file_to_email(email_message, '/home/bgroves@BUSCHE-CNC.COM/src/python-train/how_to/smtp/github.png')
attach_file_to_email(email_message, '/home/bgroves@BUSCHE-CNC.COM/src/python-train/how_to/smtp/TrialBalanceLinked.xlsx')
attach_file_to_email(email_message, '/home/bgroves@BUSCHE-CNC.COM/src/python-train/how_to/smtp/dsp.pdf')
##############################################################
# Convert it as a string
email_string = email_message.as_string()

with smtplib.SMTP('mobexglobal-com.mail.protection.outlook.com') as server:
    server.sendmail(email_from, email_to, email_string) 
