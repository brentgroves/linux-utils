useState
https://reactjs.org/docs/hooks-state.html

You use it when you want the computation of that initial state to happen only once. Because if you use an expression instead say:

const [state, setState] = useState(compute())
The compute runs on other renders too, just its value is ignored after first* render.

So if you do:

const [state, setState] = useState(() => compute())
Now, compute will run only once.

From the docs:

const [state, setState] = useState(initialState);
The initialState argument is the state used during the initial render. In subsequent renders, it is disregarded. If the initial state is the result of an expensive computation, you may provide a function instead, which will be executed only on the initial render

const [state, setState] = useState(() => {
      const initialState = someExpensiveComputation(props);
      return initialState;
});
* Well if it is strict mode then it could be the value of first render gets ignored too due to double invoking the render method. But this is not important for this answer. Because the value would now be ignored after second render.


const Example = (props) => {
  // You can use Hooks here!
  return <div />;
}

import React, { useState } from 'react';

function Example() {
  // Declare a new state variable, which we'll call "count"
  const [count, setCount] = useState(0);
This is a way to “preserve” some values between the function calls — useState is a new way to use the exact same capabilities that this.state provides in a class. Normally, variables “disappear” when the function exits but state variables are preserved by React.

We declare a state variable called count, and set it to 0. React will remember its current value between re-renders, and provide the most recent one to our function. If we want to update the current count, we can call setCount.

 1:  import React, { useState } from 'react';
 2:
 3:  function Example() {
 4:    const [count, setCount] = useState(0);
 5:
 6:    return (
 7:      <div>
 8:        <p>You clicked {count} times</p>
 9:        <button onClick={() => setCount(count + 1)}>
10:         Click me
11:        </button>
12:      </div>
13:    );
14:  }

Line 1: We import the useState Hook from React. It lets us keep local state in a function component.
Line 4: Inside the Example component, we declare a new state variable by calling the useState Hook. It returns a pair of values, to which we give names. We’re calling our variable count because it holds the number of button clicks. We initialize it to zero by passing 0 as the only useState argument. The second returned item is itself a function. It lets us update the count so we’ll name it setCount.
Line 9: When the user clicks, we call setCount with a new value. React will then re-render the Example component, passing the new count value to it.

 const [fruit, setFruit] = useState('banana');
This JavaScript syntax is called “array destructuring”. It means that we’re making two new variables fruit and setFruit, where fruit is set to the first value returned by useState, and setFruit is the second. It is equivalent to this code:

function ExampleWithManyStates() {
  // Declare multiple state variables!
  const [age, setAge] = useState(42);
  const [fruit, setFruit] = useState('banana');
  const [todos, setTodos] = useState([{ text: 'Learn Hooks' }]);

You don’t have to use many state variables. State variables can hold objects and arrays just fine, so you can still group related data together. However, unlike this.setState in a class, updating a state variable always replaces it instead of merging it.


