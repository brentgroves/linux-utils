https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest#az-login

Log in interactively.

Azure CLI

Copy

Try It
az login
Log in with user name and password. This doesn't work with Microsoft accounts or accounts that have two-factor authentication enabled. Use -p=secret if the first character of the password is '-'.

Azure CLI

Copy

Try It
az login -u johndoe@contoso.com -p VerySecret
Log in with a service principal using client secret. Use -p=secret if the first character of the password is '-'.

Azure CLI

Copy

Try It
az login --service-principal -u http://azure-cli-2016-08-05-14-31-15 -p VerySecret --tenant contoso.onmicrosoft.com
Log in with a service principal using client certificate.

Azure CLI

Copy

Try It
az login --service-principal -u http://azure-cli-2016-08-05-14-31-15 -p ~/mycertfile.pem --tenant contoso.onmicrosoft.com