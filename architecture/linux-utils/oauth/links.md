**[OAuth](https://www.oauth.com/)**
The OAuth 2.0 framework explicitly does not provide any information about the user that has authorized an application. OAuth 2.0 is a delegation framework, allowing third-party applications to act on behalf of a user, without the application needing to know the identity of the user.

**[OpenID Connect](https://www.oauth.com/oauth2-servers/openid-connect/)**
This is what the report apps are using to authenticate users to a Azure AD tennant.
OpenID Connect takes the OAuth 2.0 framework and adds an identity layer on top. It provides information about the user, as well as enables clients to establish login sessions.
OpenID Connect’s ID Tokens take the form of a JWT (JSON Web Token), which is a JSON payload that is signed with the private key of the issuer, and can be parsed and verified by the application.  The signing of the payload sounds like the signing and verifying of certificates by a CA and browser.

**[OpenID Connect debugger](https://oidcdebugger.com/)**

**[OAuth Playground]https://www.oauth.com/playground/index.html)**
The OAuth 2.0 Playground will help you understand the OAuth authorization flows and show each step of the process of obtaining an access token.
**[Authorization code with PKCE](https://oauth.net/2/pkce/)**
PKCE (Proof Key for Code Exchange) is an extension to the OAuth 2.0 protocol that prevents authorization code interception attacks. 
1. Create a secret code verifier and code challenge  
2. Build the authorization URL and redirect the user to the authorization server
3. After the user is redirected back to the client, verify the state
4. Exchange the authorization code and code verifier for an access token

The authorization server will check whether the verifier matches the challenge that was used in the authorization request. This ensures that a malicious party that intercepted the authorization code will not be able to use it.

**[Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)**
Noticed microsoft's graph API looks different.  You can sign in to our tennant or explore options using a sample.