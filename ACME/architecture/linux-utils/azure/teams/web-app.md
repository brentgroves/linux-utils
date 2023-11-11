# Can we create a web app accessible from a teams tab?
https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/what-are-tabs

Tabs are Teams-aware webpages embedded in Microsoft Teams. They're simple HTML <iframe/> tags that point to domains declared in the app manifest and can be added as part of a channel inside a team, group chat, or personal app for an individual user. You can include custom tabs with your app to embed your own web content in Teams or add Teams-specific functionality to your web content. For more information, see Teams JavaScript client library.

There are few prerequisites that you must go through before working on tabs.

There are two types of tabs available in Teams, personal and channel or group. Personal tabs, along with personal-scoped bots, are part of personal apps and are scoped to a single user. They can be pinned to the left navigation bar for easy access. Channel or group tabs deliver content to channels and group chats, and are a great way to create collaborative spaces around dedicated web-based content.

You can build tabs with Adaptive Cards and centralize all Teams app capabilities by eliminating the need for a different backend for your bots and tabs. Stage View is a new UI component that allows you to render the content opened in full screen in Teams and pinned as a tab. The existing link unfurling service is updated, so that it's used to turn URLs into a tab using an Adaptive Card and Chat Services. You can create conversational tabs using conversational sub-entities that allow users to have conversations about sub-entities in your tab, such as specific task, patient, and sales opportunity, instead of discussing the entire tab. You can make changes to tab margins to enhance the developer's experience when building apps. You can drag the tab and place it in the desired position to interchange the tab positions within your personal apps and channel or group chats.
Tabs user scenarios
Scenario: Bring an existing web-based resource inside Teams.
Example: You create a personal tab in your Teams app that presents an informational corporate website to users.

Scenario: Add support pages to a Teams bot or messaging extension.
Example: You create personal tabs that provide about and help webpage content to users.

Scenario: Provide access to items that your users interact with regularly for cooperative dialogue and collaboration.
Example: You create a channel or group tab with deep linking to individual items.

Declare custom tab in app manifest
A custom tab is declared in the app manifest of your app package. For each webpage you want included as a tab in your app, you define a URL and a scope. Additionally, you can add the Teams JavaScript client library to your page, and call microsoftTeams.initialize() after your page loads. Teams displays your page and provides access to Teams-specific information, for example, the Teams client is running the dark theme.

Whether you choose to expose your tab within the channel or group, or personal scope, you must present an <iframe> HTML content page in your tab. For personal tabs, the content URL is set directly in your Teams app manifest by the contentUrl property in the staticTabs array. Your tab's content is the same for all users.

Teams app doesn't recognize sub iframes. Therefore, it'll not load if there is an iframe within the tab app.

For channel or group tabs, you can also create an extra configuration page. This page allows you to configure content page URL, typically by using URL query string parameters to load the appropriate content for that context. This is because your channel or group tab can be added to multiple teams or group chats. On each subsequent install, your users can configure the tab, allowing you to tailor the experience as required. When users add or configure a tab, a URL is associated with the tab that is presented in the Teams user interface (UI). Configuring a tab simply adds more parameters to that URL. For example, when you add the Azure Boards tab, the configuration page allows you to choose, which board the tab loads. The configuration page URL is specified by the configurationUrl property in the configurableTabs array in your app manifest.

You can have multiple channels or group tabs, and up to 16 personal tabs per app.

Login pages don't render in iFrames, as a safeguard against clickjacking. Your authentication logic needs to use a method other than redirect. For example, use token-based or cookie-based authentication.

Within your content page, add a reference to Microsoft Teams JavaScript client library using script tags. After your page loads, make a call to app.initialize(), otherwise your page won't be displayed.

Microsoft Teams tab doesn't support the ability to load intranet websites that use self-signed certificates.
