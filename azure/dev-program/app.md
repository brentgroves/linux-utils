1hkt5t.onmicrosoft.com
app registrations
Mobex Report Testing
multi-tenant
web
https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback
Add any scope you want
app id:04369ad5-63ff-4c32-b1f1-77a9342423f8
add the client application id
04369ad5-63ff-4c32-b1f1-77a9342423f8
api permissions
directory.readAll
email
user.read

create client secret

goto
auth0.com
brent.groves@gmail.com

create connection
domain:1hkt5t.onmicrosoft.com
clientid:04369ad5-63ff-4c32-b1f1-77a9342423f8

secretid:27b776c2-9507-445f-9a68-2d20a4e070f1
value:HEZ8Q~NiA7WAHbJAKeyONVOt43SJjSvnuPPY8csn

token configuration:
optional claim: email

brentgroves@1hkt5t.onmicrosoft.com
AlexW@1hkt5t.onmicrosoft.com
EAxejwisiakJip3

auth0.com
create an application
regular web application
enable the connection

If yes, please go to Azure AD > App registrations > select an Application > Token configuration and enable UPN and Email claims for the ID token.

map upn to email:
https://community.auth0.com/t/user-profile-has-no-email-when-created-via-azure-ad-connection/88924
user.email = user.email || user.upn;