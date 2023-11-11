Thank you Father for my existance and for giving me courage to not worry about anything!
Thank you Father for teaching me that you love me and I am never alone.
Thank you for teaching me to enjoy whatever you have me doing and helping me not to worry about the future?
Thank you for teaching me to enjoy the struggle of trying to get things to work Abba!
Thank you Abba for giving me courage to do my work today?
After a user is returned in the access token and app.service(user).create() is called.
The client could subscribe to a current-user.create service event and the client.authorize() could be called from the browser.
https://docs.feathersjs.com/api/authentication/service.html#configuration

To create a new JWT
For any strategy allowed in authStrategies, a user can call app.service('/authentication').create(data) or POST /authentication with data as { strategy: name, ...loginData }. Internally authentication will then

Call the strategy .authenticate method with data
Create a JWT for the entity returned by the strategy
Return the JWT (accessToken) and the additional information from the strategy
For local strategy, the user has to be created before doing auth, otherwise, a 401 NotAuthenticated error will be send.

// https://docs.feathersjs.com/api/authentication/service.html#configuration    
app.service('/authentication')
.create({
strategy: 'local',
email,
password:'passwordless'
}).then(() => {
    logger.info('now try to logout');
}).catch((err) => { 
    logger.info('%o', err);
})

#

steps:
02 sensor - $450 
exhaust leak
catalitic converter
https://www.youtube.com/watch?v=qTsqpYz5cGE

https://docs.feathersjs.com/api/authentication/service.html#to-authenticate-an-external-request
https://docs.feathersjs.com/api/authentication/service.html#customization
https://docs.feathersjs.com/cookbook/authentication/stateless.html#configuration
try to delete that web token in local storage using the feathers api.
https://learn.microsoft.com/en-us/azure/active-directory/develop/tutorial-v2-javascript-auth-code
git clone https://github.com/Azure-Samples/ms-identity-javascript-v2
git@github.com:brentgroves/ms-identity-javascript-v2.git
https://morphatic.com/2019/04/15/authorizing-feathers-api-requests-for-vue-react-angular-apps-using-auth0/
https://auth0.com/pricing
https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/webservices/authenticate-web-services-using-oauth
https://learn.microsoft.com/en-us/azure/active-directory/develop/msal-acquire-cache-tokens
https://learn.microsoft.com/en-us/azure/active-directory/develop/msal-js-sso

https://learn.microsoft.com/en-us/azure/active-directory/develop/msal-node-migration
https://manage.auth0.com/dashboard/us/dev-gfcd1ld5m2jtz0m0/connections/enterprise/waad/create
https://codesandbox.io/examples/package/@feathersjs/authentication
https://docs.feathersjs.com/api/authentication/oauth.html
https://docs.feathersjs.com/cookbook/authentication/auth0.html#strategy

Next: https://auth0.com/docs/api/authentication#logout
Abba willing find out how to delete the token in the browser so you can test login with different user name.
app.authentication.removeAccessToken()
getAccessToken()
https://docs.feathersjs.com/api/authentication/client.html#configuration
https://docs.feathersjs.com/api/authentication/oauth.html#configuration
try:
after or instead of sign out call /oath/ login link to bring up the auth0 login page.


Study OATH feathers example.
How does Oath work in feathers?
Is there a way to use oath with Azure?
Will redirection work to reports31?
https://bailer.gitbooks.io/feathersjs/content/authentication/oauth2.html

Swap memory sessions to redis https://docs.feathersjs.com/api/authentication/oauth.html#setup-express
https://docs.feathersjs.com/cookbook/authentication/auth0.html#strategy
How to resolve cross origin issues?
without the crossorigin link the web server would not retrieve the css from a different site. 
https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/crossorigin
<link crossorigin="anonymous" rel="stylesheet" href="//cdn.rawgit.com/feathersjs/feathers-chat/v0.2.0/public/base.css">

https://stackoverflow.com/questions/44145619/nodejs-express-cors-issue-with-access-control-allow-origin/44146038#44146038
https://www.npmjs.com/package/cors
app.use(cors({ origin: 'http://localhost:3000' , credentials :  true,  methods: 'GET,PUT,POST,OPTIONS', allowedHeaders: 'Content-Type,Authorization' }));
app.use(cors({ origin: 'http://example.com' , credentials :  true}));

Thank you Father for the peace of mind you give me!
Next: Test Auth0 from feathers
Next: Test microsoft directly from feathers


NEXT: open Reports/build_deploy/high-level-notes.md
NEXT web app: debug feather-react-chat which was moved to reports-react from reports-feathers.
Thank you Father for your direction!
ver 3
The web app is small. It only authenticates the user and runs the Trial Balance report. It accepts the report params, inserts a report job into the queue, and waits for the report runner to finish the job and publish to the reports31 topic.

https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7

Create cron job to backup database.
Research:
Can we create a ClusterIP service instead of a nodeport type service for k8s objects internal access and then change the nodeport to an ingress object so that we can easily use tls certificates to securely access MongoDB using an ingress path to map to the ClusterIP running on the 30331 port?

First attempt to deploy the reports-cron and reports-api and reports-runner

Create script on reports-volume to tove Trial Balance data to mongo
https://hevodata.com/learn/mysql-to-mongodb/

The goal is to get a connection to mongodb from outside the k8s cluster.
Test the mongodb docker image we created.
