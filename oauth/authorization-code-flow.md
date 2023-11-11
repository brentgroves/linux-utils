https://www.oauth.com/playground/authorization-code.html

Build the Authorization URL

Before authorization begins, it first generates a random string to use for the state parameter. The client will need to store this to be used in the next step.

https://authorization-server.com/authorize?
  response_type=code
  &client_id=rRxNovP4nq7eZc4dipxI9hHc
  &redirect_uri=https://www.oauth.com/playground/authorization-code.html
  &scope=photo+offline_access
  &state=fRd1XmjzyQgKOnpO
For this demo, we've gone ahead and generated a random state parameter (shown above) and saved it in a cookie.

Click "Authorize" below to be taken to the authorization server. You'll need to enter the username and password that was generated for you.