Custom-hooks
https://reactjs.org/docs/hooks-custom.html
Extracting a Custom Hook
When we want to share logic between two JavaScript functions, we extract it to a third function. Both components and Hooks are functions, so this works for them too!

A custom Hook is a JavaScript function whose name starts with ”use” and that may call other Hooks. For example, useFriendStatus below is our first custom Hook:

import { useState, useEffect } from 'react';

function useFriendStatus(friendID) {
  const [isOnline, setIsOnline] = useState(null);

  useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }

    ChatAPI.subscribeToFriendStatus(friendID, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(friendID, handleStatusChange);
    };
  });

  return isOnline;
}
There’s nothing new inside of it — the logic is copied from the components above. Just like in a component, make sure to only call other Hooks unconditionally at the top level of your custom Hook.
There’s nothing new inside of it — the logic is copied from the components above. Just like in a component, make sure to only call other Hooks unconditionally at the top level of your custom Hook.

Unlike a React component, a custom Hook doesn’t need to have a specific signature. We can decide what it takes as arguments, and what, if anything, it should return. In other words, it’s just like a normal function. Its name should always start with use so that you can tell at a glance that the rules of Hooks apply to it.

The purpose of our useFriendStatus Hook is to subscribe us to a friend’s status. This is why it takes friendID as an argument, and returns whether this friend is online:

function useFriendStatus(friendID) {
  const [isOnline, setIsOnline] = useState(null);

  // ...

  return isOnline;
}
Now let’s see how we can use our custom Hook.

Using a Custom Hook
In the beginning, our stated goal was to remove the duplicated logic from the FriendStatus and FriendListItem components. Both of them want to know whether a friend is online.

Now that we’ve extracted this logic to a useFriendStatus hook, we can just use it:

function FriendStatus(props) {
  const isOnline = useFriendStatus(props.friend.id);

  if (isOnline === null) {
    return 'Loading...';
  }
  return isOnline ? 'Online' : 'Offline';
}
function FriendListItem(props) {
  const isOnline = useFriendStatus(props.friend.id);

  return (
    <li style={{ color: isOnline ? 'green' : 'black' }}>
      {props.friend.name}
    </li>
  );
}
Is this code equivalent to the original examples? Yes, it works in exactly the same way. If you look closely, you’ll notice we didn’t make any changes to the behavior. All we did was to extract some common code between two functions into a separate function. Custom Hooks are a convention that naturally follows from the design of Hooks, rather than a React feature.

Do I have to name my custom Hooks starting with “use”? Please do. This convention is very important. Without it, we wouldn’t be able to automatically check for violations of rules of Hooks because we couldn’t tell if a certain function contains calls to Hooks inside of it.

Do two components using the same Hook share state? No. Custom Hooks are a mechanism to reuse stateful logic (such as setting up a subscription and remembering the current value), but every time you use a custom Hook, all state and effects inside of it are fully isolated.

How does a custom Hook get isolated state? Each call to a Hook gets isolated state. Because we call useFriendStatus directly, from React’s point of view our component just calls useState and useEffect. And as we learned earlier, we can call useState and useEffect many times in one component, and they will be completely independent.

Tip: Pass Information Between Hooks
Since Hooks are functions, we can pass information between them.

To illustrate this, we’ll use another component from our hypothetical chat example. This is a chat message recipient picker that displays whether the currently selected friend is online:

