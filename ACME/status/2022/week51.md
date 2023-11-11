Find away to notify the client of the user name that has just been authenticated in the auth-callback so that the client can call the client.authenticate method.
noticed I was overwriting res at axios.post() so I changed the variable name to res2. no wonder I could not call redirect on the axios.post() call because it now is assigned to a promise and not the (req,res) of the routing function.
so goto auth-callback() and look at your notes.

https://teddy-error.gitbooks.io/feathersjs/content/api/authentication/local.html
https://teddy-error.gitbooks.io/feathersjs/content/

If you are not using the feathers-authentication-client and you have registered this module server side then you can simply make a POST request to /authentication with the following payload:

// POST /authentication the Content-Type header set to application/json
{
  "strategy": "local",
  "email": "your email",
  "password": "your password"
}
Here is what that looks like with curl:

curl -H "Content-Type: application/json" -X POST -d '{"strategy":"local","email":"your email","pas

https://teddy-error.gitbooks.io/feathersjs/content/api/authentication/server.html
Run a trial balance report using ERS v1.

https://blog.bitsrc.io/the-power-of-axios-cf45e085d924
The default timeout is 0 set a longer timeout for the access_token request.
axios
  .post('http://mysite.com/user', { name: 'John' }, { timeout: 2 })
  .then(response => {
     console.log(response);
  })
  .catch(error => {
     console.log(error);
  });

Issue identified by Brad:
There has been a topic brought up alot here at Fruitport between accounting and quality managers. The accounting group uses the SCAR plex screen to get their scrap count while quality uses the scrap summary by part. These two tables never have the same result. 
Idea:
Make a 'Scrap' flow chart describing the path from when a part is scrapped to when it shows up as cost activity.
How:
Use the test server.
Diff the records in each table of importance.
1. Method 1
    + Write a simple query in the Plex SDE. 
    + run an SSIS script to Pipe data to a before table.
    + go to a Plex Scrap screen in question and do a transaction 
    + run an SSIS script to Pipe data to a after table.
    + run a query that joins the before and after tables and shows records with different values. 
2. Method 2
    + Write a more complex query in the Plex SDE 
        + Send data to a before temp table.
        + Sleep for 1 minute.
        + go to a Plex Scrap screen in question and do a transaction 
        + Send data to a after temp table.
        + run a query that joins the before and after temp tables and shows records with different values. 

Enhanced Reporting System (ERS):
- Added support for OAuth authentication of the reports-feathers Azure application.
    + Used the Axios http client library to complete the OAuth process flow.
    + Uses the users normal Azure AD login process to authenticate
- uses Azure API
    + send email with attachment to customers without using our eSMTP server.
    + copies excel files into Microsoft teams group folders
    + adds tasks to Azure planner app
    + changed our existing Azure API calling process to use MSAL OAth library. 
- Azure API news     
    + Microsoft is switching authentication libraries to MSAL which uses the industry standard OAuth authentication method. Once your app is registered with your Azure tenant you can use code or a browser and curl to retrieve a JWT access token which can be used to identify the user and call the Azure graph API to do about anything in your tenant. A couple of years ago alls that was needed for an app to use the Azure API was an app secret/password, now you must add a JWT access token as a header to all Azure API requests. These access tokens have an expiration time so the Azure app must ask for a new one every configurable time period making the whole Azure API calling process reliant on tokens instead of app passwords checked all the time.


https://docs.feathersjs.com/api/authentication/service.html#to-authenticate-an-external-request
https://docs.feathersjs.com/cookbook/authentication/stateless.html#configuration
https://docs.feathersjs.com/api/authentication/service.html#customization

# Add code or write procedure oauth authentication working for an Microsoft Azure.
I tried to change default.json file to use an app I registered in a free Microsoft developer account without success. I believe it would be possible using the following articles:   
https://learn.microsoft.com/en-us/azure/databricks/dev-tools/api/latest/aad/app-aad-token
https://learn.microsoft.com/en-us/azure/active-directory/develop/tutorial-v2-javascript-auth-code
https://stackoverflow.com/questions/54868974/getting-security-groups-in-jwt-access-token
this article has a sample using postman.
make roles in app and assign users to roles instead of groups

use /authenticate link to set token like in local strategy
use azure example to sign out.
then call client.logout to end session.