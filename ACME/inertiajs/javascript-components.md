https://medium.com/@adityaa803/components-in-javascript-1f5c66042fa5#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkOWE1ZWY1YjEyNjIzYzkxNjcxYTcwOTNjYjMyMzMzM2NkMDdkMDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYmYiOjE2ODUzODgzNTEsImF1ZCI6IjIxNjI5NjAzNTgzNC1rMWs2cWUwNjBzMnRwMmEyamFtNGxqZGNtczAwc3R0Zy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjExMzc3MDA0NjA0MzIxMDE1MTI1MiIsImVtYWlsIjoiYnJlbnQuZ3JvdmVzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhenAiOiIyMTYyOTYwMzU4MzQtazFrNnFlMDYwczJ0cDJhMmphbTRsamRjbXMwMHN0dGcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJuYW1lIjoiYnJlbnQgZ3JvdmVzIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBY0hUdGNQWU5OajdVUDlZMUhRX3ZvUk1BYXdfYTJMaHJ5cVJCcEMxY3lNPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6ImJyZW50IiwiZmFtaWx5X25hbWUiOiJncm92ZXMiLCJpYXQiOjE2ODUzODg2NTEsImV4cCI6MTY4NTM5MjI1MSwianRpIjoiODNhNTk5NzgzNDViZGMzMDE0ZDljNWMzNmEyMGZkZDJmMTRkNjE4MSJ9.TXcU587tuK2sYgs4o48iJRMX9SqDpr6i8XDVooJampp6rDSdcTr8TMIktgOqYQRi6EAgSxjk8H_H6vxu88xsksO3QBg9krwryD5CHipVJ16Ag2pluPpvJwMhuWmlZute-6uppb7S3koCL433jyq0H7XWCZjEL4ePTHk_011Gz-o23NxuyI_Yq-CVrV9nfiuQIu7rpfgjc3VbiBnC3IkCTBPMjPVpJgebLFMjpZuoOuOctmsriHUZJfZP1q8D6n2QQ_QUyjVKHGy5Jf7s7DugjCyEbBoGT19gRW6mQo-EH8ztTsxsy_6DiJH6qkIxdCdPJPu1tfwjtX56BBjbxgJXxg

Recently, I struggled to create an app with vanilla javascript following the component methodology. That is —

One component should focus on one section of the UI.
One component shouldn’t access another’s html directly.
The component encapsulates its html, css and javascript.
Each component has some way to interact with others.
This approach has many advantages. It aligns with Single Responsibility Principle, so we have good separation of concerns, which in turn makes debugging easier.

Due to these advantages every major framework or library like React, Vue, Angular uses this.

If we consider React it follows all these rules —

We make class components which are specific to one section of UI.
Direct access to DOM is forbidden.
Each component has a render method which is reponsible for the html of component. No component directly changes another’s html.
We use Redux so that when state of one component changes, then other parts of the app aka components can be updated.
So how do we do all this in vanilla javascript ?

The first three consideration are design related and very easy with es2017. Today I want to focus on the fourth requirement. How do we make the components interact with each other.

es2017
For example, let’s assume we have a Search component and a List component. Their use is self explanatory, the List component shows a list of items and we can filter the items using the Search component.

The filter feature needs us to pass the search term from the Search component to the List component so that the List component shows only those items which matches the search term.

So one way of doing this is that we expose some methods of List component like updateList and call this function from the Search component whenever the user inputs something. But this has a serious problem. We have tightly coupled both the components. If say we make some changes in the updateList method then it may break the search functionality. Thus the responsibility has been divided among the two. And this is a problem. One more thing is that for now we are just talking about two components. Our app will probably have much more components than these and if all our depending on one another debugging the code will become a nightmare. How can we avoid this ?

We can use the pub/sub design pattern to make the components talk in a decoupled fashion. This uses the concepts of events.

One or more components subscribe to an event, so that when a certain event occur from anywhere in the app, a callback is triggered through which the component can handle updates.

The event occurs when one component publishes it. It’s important that the published event is unique to that component. That is only one component can publish a certain event and nobody else.

In our example, we can do this —

The Search component publishes an event say searchComp/search whenever the user submits a search term.
The List component subscribes to this event. So every time the user submits a search term, the List component gets to know about this and so it can update the list.
Let’s see some code to understand how we actually do this.

Note — I’m using es2017 with import statements and object destructuring.

// searchComponent.js
import { publishEvent } from './utilities/eventBus';
const searchInputElem = document.getElementById('searchInput');
const searchSubmitElem = document.getElementById('searchSubmit');
searchSubmitElem.addEventListener('click', function () {
  publishEvent('searchComp/search', {
    query: searchInputElem.value
  })
})
--------------------------------------------------------------------
// listComponent.js
import { subscribeEvent } from './utilities/eventBus';
subscribeEvent('searchComp/search', function ({ query }) {
  console.log(`you entered ${query}`);
  //do something else
})

Merits of this approach —

In the future if new features are added we just have to publish new events and add subscribers to it.
The event publisher doesn’t have to know anything about the components which have subscribed to it.

Implementing the Event Bus
As you can see the previous code snippet, the eventBus utility provides two methods subscribeEvent and publishEvent to handle the events.

Let’s see how this utility is implemented —

// utilities/eventBus
const events = {};
export function subscribeEvent(event, listener) {
  if (!events[event]) {
    events[event] = [];
  }
  if (!events[event].includes(listener)) {
    events[event].push(listener);
  }
}
export function publishEvent(event, payload = {}) {
  const listeners = events[event];
  if (!listeners) {
    return;
  }
  for (let i = 0, l = listeners.length; i < l; i += 1) {
    listeners[i](payload);
  }
}
Explanation —

events is an object whose keys represent an event.
Each key has an array of listeners as it’s value.
When an event occurs, the corresponding key from the events object is selected and then all the listeners are called.

Where to go from here —

You can add an unsubscribeEvent method so that component can stop listening to an event.
You can make preloader component which subscribes to serverAction/start and serverAction/finish event and shows/hides accordingly.
Check out Code Runner, to see a complete project using this pattern.