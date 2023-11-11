https://medium.com/swlh/building-a-ms-teams-app-using-react-fluentui-82a78b3a7de7

How does it work?
Firstly, we need to understand (as I originally didn’t) that MS Teams doesn’t ‘host’ an app as such, you simply give it the information it needs to go find your app somewhere else and display it within an iframe.

This information is held in a file called manifest.json and includes things like your application’s name, icon, description and most importantly, the URL to configure your app from when it is being added to a channel.

That’s right — you don’t actually give Teams the URL to the site you want to display, but a configuration page which will then give Teams the real URL for your content. This gives us a bit more flexibility, so that depending on any number of factors (e.g. the tenant, the channel the app is being added to, settings in the configuration page, etc.), you can change where the actual application is pulled from.

Let’s begin — set up the React app:
For this example, we’ll be using the out-of-the-box React/Typescript configuration, so run this command to quickly build our app (I’m using yarn here, but of course this works with npm too):

yarn create react-app <your app name> --template typescript

https://learn.microsoft.com/en-us/microsoftteams/platform/concepts/build-and-test/teams-developer-portal