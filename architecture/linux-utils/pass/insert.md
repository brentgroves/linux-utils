https://www.passwordstore.org/
https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
https://github.com/docker/docker-credential-helpers

We can add existing passwords to the store with insert:

pass insert reports/apcheese-whiz-factory
Enter password for Business/cheese-whiz-factory: omg so much cheese what am i gonna do

This also handles multiline passwords or other data with --multiline or -m, and passwords can be edited in your default text editor using pass edit pass-name.

pass insert api://reports
pass insert reports-aks/reports-mongodb-0
pass api://reports

pass insert --multiline reports/SERVICE_PRINCIPAL_JSON
echo $SERVICE_PRINCIPAL_JSON
{
  "appId": "15cdd566-98bb-4130-8ec5-5c58cffb34bf",
  "displayName": "api://reports",
  "password": "wfE8Q~Zvyg8J15GMrEFuLkbegI9THBP74tkoEbMq",
  "tenant": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
}
pass reports/SERVICE_PRINCIPAL_JSON