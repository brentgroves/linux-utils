https://www.oauth.com/playground/

Great! A new OAuth 2.0 client was created for you along with a user account. You can see the registration info below. This information is stored in a cookie in your browser. Save the user login and password, since you'll need those in order to authenticate as that user during the OAuth flow!

Client Registration
client_id: rRxNovP4nq7eZc4dipxI9hHc
client_secret: 3cW4r4Cyj9r8Znkaiv6z7nbTuqPbAMHhR64U352s1EXsvJcG
User Account
login: elated-seal@example.com
password: Hurt-Shrew-47


https://www.oauth.com/playground/authorization-code-with-pkce.html

Create a Code Verifier and Challenge

Before redirecting the user to the authorization server, the client first generates a secret code verifier and challenge.

The code verifier is a cryptographically random string using the characters A-Z, a-z, 0-9, and the punctuation characters -._~ (hyphen, period, underscore, and tilde), between 43 and 128 characters long.

Once the client has generated the code verifier, it uses that to create the code challenge. For devices that can perform a SHA256 hash, the code challenge is a BASE64-URL-encoded string of the SHA256 hash of the code verifier. Otherwise, the same verifier string is used as the challenge.


code verifier: h4Beq2htM-OAdd8bV1ssN9wtGJ7z90d_ER5AudqqICEef2Q3
code challenge: QKUlaq6mABxoMn7ncY8sOwhzfwceAcPC6kmHYNImbEE

Build the Authorization URL

The client then needs to generate a random string to use for the state parameter, and needs to store it to be used in the next step.

https://authorization-server.com/authorize?
  response_type=code
  &client_id=rRxNovP4nq7eZc4dipxI9hHc
  &redirect_uri=https://www.oauth.com/playground/authorization-code-with-pkce.html
  &scope=photo+offline_access
  &state=0hJBVASnSX9RyYEN
  &code_challenge=QKUlaq6mABxoMn7ncY8sOwhzfwceAcPC6kmHYNImbEE
  &code_challenge_method=S256

Verify the state parameter

The user was redirected back to the client with a few additional query parameters in the URL:

?state=0hJBVASnSX9RyYEN&code=PY5VgU9D2c44wAg2j6U2Dq9JedLK8w3e7zClYuhuoo2Lk10k
The state value isn't strictly necessary here since the PKCE parameters provide CSRF protection themselves. In practice, if you're sure the OAuth server supports PKCE, you can use the state parameter for application state instead of using it for CSRF protection.

Does the state stored by the client (0hJBVASnSX9RyYEN) match the state in the redirect (0hJBVASnSX9RyYEN)?  

Exchange the Authorization Code

Now you're ready to exchange the authorization code for an access token.

The client will build a POST request to the token endpoint with the following parameters:

POST https://authorization-server.com/token

grant_type=authorization_code
&client_id=rRxNovP4nq7eZc4dipxI9hHc
&client_secret=3cW4r4Cyj9r8Znkaiv6z7nbTuqPbAMHhR64U352s1EXsvJcG
&redirect_uri=https://www.oauth.com/playground/authorization-code-with-pkce.html
&code=PY5VgU9D2c44wAg2j6U2Dq9JedLK8w3e7zClYuhuoo2Lk10k
&code_verifier=h4Beq2htM-OAdd8bV1ssN9wtGJ7z90d_ER5AudqqICEef2Q3

Token Endpoint Response

Here's the response from the token endpoint! The response includes the access token and refresh token.

{
  "token_type": "Bearer",
  "expires_in": 86400,
  "access_token": "Qwb_1367k6FwQ__lDJnucKPQHNuFCmDbm42igJ2JdW7PJ0PSnKKzGRMEfi14laFabXHJwCmk",
  "scope": "photo offline_access",
  "refresh_token": "TSWsLkPeUvO2cc4QcvzTVc00"
}
Great! Now your application has an access token, and can use it to make API requests on behalf of the user.


Authorization code with PKCE
1. Create a secret code verifier and code challenge  
2. Build the authorization URL and redirect the user to the authorization server
3. After the user is redirected back to the client, verify the state
4. Exchange the authorization code and code verifier for an access token

The authorization server will check whether the verifier matches the challenge that was used in the authorization request. This ensures that a malicious party that intercepted the authorization code will not be able to use it.