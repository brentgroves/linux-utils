Next: React.js based CRUD
https://www.techgeeknext.com/react/react-crud-example

Good morning dear ones,
I hope you are doing ok today!  I enjoy working with each of you and if you need anything please call or text me anytime.
-Sincerely yours,
Brent 
260-564-4868

Go reports utilitiy:
Create Go Lang utility to share an excel report file in Microsoft Teams Chat.
1. upload to sharepoint.
**[upload to sharepoint](https://www.linkedin.com/pulse/how-upload-file-via-graph-api-sharepoint-satheesh-kumar/
)**
2. chat message with attachment
**[chat message with attachment](https://learn.microsoft.com/en-us/graph/api/chatmessage-post?view=graph-rest-1.0&tabs=http#example-4-send-a-message-with-file-attachment-in-it
)**

Report System Features:
Schema driven development
Is a great way to have the data models and how data is modified in a single place.
When the schema changes both the API and client are aware of the changes.
Named Migrations 
are a best practice for SQL databases to roll out and undo changes to the data model.

End-To-End Type Safety
**[Type Safety](https://sabinadams.hashnode.dev/end-to-end-type-safety-what-why-and-how)**
With end-to-end type safety, the goal is to have a single source of truth for your types across all layers of your application. Ideally this would occur in an automated fashion as your database schema changes.
Making changes to our database should automatically update the type definitions in the API and Client layers.

Research Activities:
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

share an excel report file in Microsoft Teams Chat:
https://buschecnc-my.sharepoint.com/:x:/g/personal/bgroves_mobexglobal_com/EVf_QQUflgRPrKPYiO8EqCEBkH3xlPRnLWWBLP35_WcWag?e=IA8R26
https://www.linkedin.com/pulse/how-upload-file-via-graph-api-sharepoint-satheesh-kumar/
https://learn.microsoft.com/en-us/graph/api/chatmessage-post?view=graph-rest-1.0&tabs=http#example-4-send-a-message-with-file-attachment-in-it
