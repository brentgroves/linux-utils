# summary
Used the Microsoft developer account to test.
Was able to return an email address but not a security group using an auth0 saml connection and the AzureViaSaml enterprise application.
The users you want to login with AzureViaSaml must be added to the app user section.

# the microsoft account used
https://developer.microsoft.com/
main account: brentgroves@1hkt5t.onmicrosoft.com
AlexW@1hkt5t.onmicrosoft.com
EAxejwisiakJip3
domain:1hkt5t.onmicrosoft.com

# the auth0 account used
brent.groves@gmail.com
Could only get the email to return using an Auth0 SAML account.
SAML connection: urn:auth0:dev-gfcd1ld5m2jtz0m0.us.auth0.com:AzureViaSaml
urn:auth0:dev-gfcd1ld5m2jtz0m0:AzureViaSaml
https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback?connection=AzureViaSaml
https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/saml2

urn:auth0:dev-gfcd1ld5m2jtz0m0.us.auth0.com:AzureViaSaml
# optional claims
https://learn.microsoft.com/en-us/azure/active-directory/develop/active-directory-optional-claims
This value is included by default if the user is a guest in the tenant. For managed users (the users inside the tenant), it must be requested through this optional claim or, on v2.0 only, with the OpenID scope. This value isn't guaranteed to be correct, and is mutable over time - never use it for authorization or to save data for a user. For more information, see Validate the user has permission to access this data. If you require an addressable email address in your app, request this data from the user directly, using this claim as a suggestion or pre-fill in your UX.
https://learn.microsoft.com/en-us/azure/active-directory/develop/access-tokens
https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/choose-a-connection-type-for-azure-ad
# how to implement signout using oath
# test auth0 from feathers
# test azure authentication from feathers.
# try adding group support
https://www.sitepoint.com/crud-app-node-react-feathersjs/
https://github.com/simov/grant
auth0.com
# azure connection
mobex-test-report
Azure domain
mobextest.onmicrosoft.com
https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2
https://community.auth0.com/t/setting-up-azure-ad-as-saml-enterprise-connection/87829
Identifier (Entity ID) set up identifier as per this example: urn:auth0:your-auth0-domain:connection-name
urn:auth0:dev-gfcd1ld5m2jtz0m0.us.auth0.com:AzureViaSaml
urn:auth0:dev-gfcd1ld5m2jtz0m0:AzureViaSaml
https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback?connection=AzureViaSaml
https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/saml2

urn:auth0:dev-gfcd1ld5m2jtz0m0.us.auth0.com:AzureViaSaml

https://community.auth0.com/t/setting-up-azure-ad-as-saml-enterprise-connection/87829
https://www.mckennaconsultants.com/integrating-auth0-with-azure-active-directory/9/


https://login.microsoftonline.com/1hkt5t.onmicrosoft.com/oauth2/v2.0/authorize?
client_id=c8cba2df-fddf-4610-924f-48e7d552be4a
&response_type=code
&redirect_uri=https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback?connection=AzureViaSaml
&response_mode=query
&scope=offline_access%20user.read%20directory.read.all
&state=12345



# feathers redirect
EAxejwisiakJip3
http://localhost:3030/oauth/github/callback
http://localhost:3030/oauth/auth0/callback
https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app

grovesbrent@outlook.com
moto@mobextest.onmicrosoft.com
Basdlkfj1!

# make a free account
https://azure.microsoft.com/en-us/free/
# create a tenant
https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-access-create-new-tenant
# review feather cookbook
https://docs.feathersjs.com/cookbook/authentication/auth0.html#strategy
# oath organization
mobex-test
dev-gfcd1ld5m2jtz0m0.us.auth0.com
https://mobex-test.us.auth0.com/authorize?client_id=15psN0K2xuwp3OUzW5Ldt567mBllSCHJ&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A3030%2Foauth%2Fauth0%2Fcallback&scope=openid%20profile%20email

https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/authorize?client_id=15psN0K2xuwp3OUzW5Ldt567mBllSCHJ&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A3030%2Foauth%2Fauth0%2Fcallback&scope=openid%20profile%20email
https://dev-gfcd1ld5m2jtz0m0.auth0.com/authorize?client_id=15psN0K2xuwp3OUzW5Ldt567mBllSCHJ&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A3030%2Foauth%2Fauth0%2Fcallback&scope=openid%20profile%20email

gTvl3BroTbwekvK1gR1u1kVb5hmwLh6qB_yU2BLbnuZdWQZ37ENmnGhf3vTCrwE4
      "auth0": {
        "key": "15psN0K2xuwp3OUzW5Ldt567mBllSCHJ",
        "secret": "gTvl3BroTbwekvK1gR1u1kVb5hmwLh6qB_yU2BLbnuZdWQZ37ENmnGhf3vTCrwE4",
        "subdomain": "dev-gfcd1ld5m2jtz0m0",
        "scope": ["openid", "profile", "email"]
      }  
https://github.com/simov/grant/blob/master/config/oauth.json
# register an app
https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app
grovesbrent@outlook.com
moto@mobextest.onmicrosoft.com
Basdlkfj1!
https://community.auth0.com/t/microsoft-azure-ad-user-created-with-no-email/52261
https://auth0.com/docs/troubleshoot/authentication-issues/troubleshoot-saml-configurations
# returned by auth0
{
  "sub": "waad|MwDn8JxKXRANG4m1xrRp6U4V3ZXeWbw4Z1T152yktDU",
  "nickname": "moto",
  "name": "moto",
  "picture": "https://cdn.auth0.com/avatars/mo.png",
  "updated_at": "2022-12-08T20:22:18.884Z"
}
https://stackoverflow.com/questions/58643873/microsoft-azure-doesnt-return-email-via-oauth2-flow
https://login.microsoftonline.com/1hkt5t.onmicrosoft.com/oauth2/v2.0/authorize?client_id=c8cba2df-fddf-4610-924f-48e7d552be4a&response_type=code&redirect_uri=https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback?connection=AzureViaSaml&response_mode=query&scope=profile openid email https://graph.microsoft.com/User.Read&state=12345


https://login.microsoftonline.com/1hkt5t.onmicrosoft.com.onmicrosoft.com/oauth2/v2.0/authorize?
client_id=c8cba2df-fddf-4610-924f-48e7d552be4a
c8cba2df-fddf-4610-924f-48e7d552be4a
&response_type=code
&redirect_uri=http://localhost
&response_mode=query
&scope=profile openid email https://graph.microsoft.com/User.Read
&state=12345

signout:
https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/logout

c8cba2df-fddf-4610-924f-48e7d552be4a

{
  "sub": "waad|MwDn8JxKXRANG4m1xrRp6U4V3ZXeWbw4Z1T152yktDU",
  "nickname": "moto",
  "name": "moto",
  "picture": "https://cdn.auth0.com/avatars/mo.png",
  "updated_at": "2022-12-07T00:19:06.189Z"
}

// "auth0": {
//   "key": "15psN0K2xuwp3OUzW5Ldt567mBllSCHJ",
//   "secret": "gTvl3BroTbwekvK1gR1u1kVb5hmwLh6qB_yU2BLbnuZdWQZ37ENmnGhf3vTCrwE4",
//   "subdomain": "dev-gfcd1ld5m2jtz0m0.us",
//   "scope": ["AllAccess","openid", "profile", "email"]
// },
180 OAuth providers (Google, Facebook, GitHub etc.) using grant (opens new window), an OAuth middleware module for NodeJS.
https://github.com/simov/grant

https://stackoverflow.com/questions/64692600/aadsts9002325-proof-key-for-code-exchange-is-required-for-cross-origin-authoriz
Error Code: 9002325
Message: Proof Key for Code Exchange is required for cross-origin authorization code redemption.
Fix: Change from a SPA to a web app and it works.

abcd1234!
sparklers1!
user1@mobextest.onmicrosoft.com
Messiah1!
Organization name: mobextest
mobextest.onmicrosoft.com
MT
Mobex Test Reports
object_id:a7ce698a-3cda-4242-bdaf-2c51d923fdea
application_id:c0c4ed97-13a2-431c-b4f1-22edfad6fa70

To register the app in Azure Portal
Mobex Test Reports
Redirect URI (optional)
Add a redirect URI
# not sure about which domain to use
https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback
https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/logout

A redirect URI is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication.
There are some restrictions on the format of the redirect URIs you add to an app registration. For details about these restrictions, see Redirect URI (reply URL) restrictions and limitations.

# get a client id
https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2


# create a client secret
https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app#add-credentials
secret id:426b17de-77c4-46b3-9853-03a401f1955d
value:YBr8Q~aAc_thuFW8LIv3.92g6nYx5HaK7VfqIbDH

# expose an api
api://c0c4ed97-13a2-431c-b4f1-22edfad6fa70
# add a scope
api://c0c4ed97-13a2-431c-b4f1-22edfad6fa70/Write.All

auth0 connection:
name: mobex-test-report
domain:mobextest.onmicrosoft.com
application id:c0c4ed97-13a2-431c-b4f1-22edfad6fa70
https://docs.feathersjs.com/guides/basics/authentication.html#github-login-oauth
http://localhost:3030/oauth/github/callback

https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app
to use auth0 and Azure 
https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2

auth0 and google
create a social connection
google-oauth2
https://manage.auth0.com/dashboard/us/dev-gfcd1ld5m2jtz0m0/connections/social
sign up for a google developer account
$300 of free credit

