Next:
**[Study Contexts more especially how to stop dependant operaions](https://www.sohamkamani.com/golang/context/)**
Go run TB-test.sh publish success/failure.
<https://www.linkedin.com/pulse/how-upload-file-via-graph-api-sharepoint-satheesh-kumar/>
<https://learn.microsoft.com/en-us/graph/api/chatmessage-post?view=graph-rest-1.0&tabs=http#example-4-send-a-message-with-file-attachment-in-it>
<https://www.techgeeknext.com/react/react-crud-example>

Good morning dear ones,
I hope you and your loved ones had a relaxing and enjoyable weekend and I look forward to working with you all this week.  As always please feel free to contact me at work or at home concerning whatever you like!

- Sincerely yours,

Brent
260-564-4868

# Previous Report System K8s Deployment

- Up-to-date data since it used Web Services not Plex Snapshots
- Ran ETL pipe line at sheduled time using Cron jobs.

## Next Report System K8s Deployment

- Up-to-date data since it used Web Services not Plex Snapshots
- OAuth2 to authenticate users
- Web SPA to get customer report request.
- REST API to update request table.
- GO Report Runner to run requested reports in order.
- Report uploaded to sharepoint and added as Microsoft Teams chat message with attachment
- Report completion message published to Web SPA

## Report System Web SPA

- React.js and TypeScript
- WebSocket to Report System REST API

## Report System REST API

- Node.js and TypeScript
- MySQL request table service

# replib report system library

Created this Go library to hold all of the packages in the report system.
Semantic Version: 0.0.0

## Report system runner

Use Go for this because of it's great threading library.
"Go supports the following repositories for publishing modules: Git, Subversion, Mercurial, Bazaar, and Fossil." The Go package or module manager uses repositories for this.  I think it is pretty cool to be able to publish your go modules only using a repository!
report runner:
main()
  start trial_balance worker thread.

trial_balance()):
while true:
  result,params = calls runner_module.requests_package.get_request()
  if result==0
    call trial_balance params
  sleep 1 minute.

runner_module.requests_package.get_request():
done,current_request=get_current_request()
if done
  return 0,get_next_request()
else
  return 1,current_request

K8s Deployment
MySQL Database Server
MQTT Message Server
Report System Web SPA
Report System REST API

## PKI Info

The only notice in our certificates caught by Googles linter is:
zlint NOTICE Check if certificate has enough embedded SCTs to meet Apple CT Policy

**[Encoding of SCTs in certificates](https://letsencrypt.org/2018/04/04/sct-encoding.html
)**
"Let’s Encrypt recently launched SCT embedding in certificates. This feature allows browsers to check that a certificate was submitted to a Certificate Transparency log.
Certificate Transparency offers three ways to deliver SCTs to a browser: In a TLS extension, in stapled OCSP, or embedded in a certificate."

Note: I have not added this feature to our PKI yet and do not know if an Apple browser will except our certificates without a warning message.

## Go context

Go can cancel all ETL scripts in a pipeline neatly!

**[context](https://www.sohamkamani.com/golang/context/)**
"Consider the case of 2 dependent operations. Here, “dependent” means if one fails, it doesn’t make sense for the other to complete. If we get to know early on that one of the operations failed, we would like to cancel all dependent operations.
"

Go has more support for creating child processes to run other programs or shell scripts than I have ever seen in any other language.
