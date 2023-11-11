https://www.oauth.com/playground/

Great! A new OAuth 2.0 client was created for you along with a user account. You can see the registration info below. This information is stored in a cookie in your browser. Save the user login and password, since you'll need those in order to authenticate as that user during the OAuth flow!

Client Registration
client_id: rRxNovP4nq7eZc4dipxI9hHc
client_secret: 3cW4r4Cyj9r8Znkaiv6z7nbTuqPbAMHhR64U352s1EXsvJcG
User Account
login: elated-seal@example.com
password: Hurt-Shrew-47

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