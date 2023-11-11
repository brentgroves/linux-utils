<https://docs.nestjs.com/pipes>

Pipes
A pipe is a class annotated with the @Injectable() decorator, which implements the PipeTransform interface.

Pipes have two typical use cases:

transformation: transform input data to the desired form (e.g., from string to integer)
validation: evaluate input data and if valid, simply pass it through unchanged; otherwise, throw an exception
In both cases, pipes operate on the arguments being processed by a controller route handler. Nest interposes a pipe just before a method is invoked, and the pipe receives the arguments destined for the method and operates on them. Any transformation or validation operation takes place at that time, after which the route handler is invoked with any (potentially) transformed arguments.

Nest comes with a number of built-in pipes that you can use out-of-the-box. You can also build your own custom pipes. In this chapter, we'll introduce the built-in pipes and show how to bind them to route handlers. We'll then examine several custom-built pipes to show how you can build one from scratch.

<https://www.typescriptlang.org/docs/handbook/2/conditional-types.html>
