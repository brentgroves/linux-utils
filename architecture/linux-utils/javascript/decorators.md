<https://www.sitepoint.com/javascript-decorators-what-they-are/>

Decorators are actually nothing more than functions that return another function, and that are called with the appropriate details of the item being decorated. These decorator functions are evaluated once when the program first runs, and the decorated code is replaced with the return value.

Why Use Decorators?
Whilst functional composition is already possible in JavaScript, it’s significantly more difficult — or even impossible — to apply the same techniques to other pieces of code (e.g. classes and class properties).

The decorator proposal adds support for class and property decorators that can be used to resolve these issues, and future JavaScript versions will probably add decorator support for other troublesome areas of code.

Decorators also allow for a cleaner syntax for applying these wrappers around your code, resulting in something that detracts less from the actual intention of what you’re writing.

<https://blog.logrocket.com/practical-guide-typescript-decorators/>

Until TypeScript 5.0, we had to explicitly set a flag, experimentalDecorators, to use decorators in our code. With TypeScript 5.0, this is no longer the case. While such a flag is likely to stay around for the foreseeable future, we can use new-style decorators without it. As a matter of fact, the old-style decorators modeled a different version of the proposal (Stage 2). We can use both styles in our code because the type rules are different, but it’s not advisable to do so.

Remember to configure your working environment to use at least TypeScript 5. Otherwise, the code in this article won’t compile.

We’ll use ES6 as a target for TypeScript because it’s supported by all modern browsers:

{
  "compilerOptions": {
    "target": "ES6"
  }
}
Next, we’ll create a simple TypeScript file to test the project out:

console.log("Hello, world!");

$ npm run build
$ node index.js
Hello, world!
Instead of repeating this command over and over, we can simplify the compilation and execution process by using a package called ts-node. It’s a community package that enables us to run TypeScript code directly without compiling it first.

Let’s install it as a development dependency:

$ npm install -D ts-node
Next, add a start script to the package.json file:

{
  "scripts": {
    "build": "tsc",
    "start": "ts-node index.ts"
  }
}
Simply run npm start to run your code:

$ npm start
Hello, world!
For reference, I have all the source code on this article published on my GitHub. You can clone it onto your computer using the command below:

$ git clone <git@github.com>:mdipirro/typescript-decorators.git
New TypeScript decorators
In TypeScript, decorators are functions that can be attached to classes and their members, such as methods and properties.

In this section, we’re going to look at new-style decorators. First, the new Decorator type is defined as follows:

type Decorator = (target: Input, context: {
  kind: string;
  name: string | symbol;
  access: {
    get?(): unknown;
    set?(value: unknown): void;
  };
  private?: boolean;
  static?: boolean;
  addInitializer?(initializer: () => void): void;
}) => Output | void;
The type definition above looks complex, so let’s break it down one piece at a time:

target represents the element we’re decorating, whose type is Input
context contains metadata about how the decorated method was declared, namely:
kind: the type of decorated value. As we’ll see, this can be either class, method, getter, setter, field, or accessor
name: the name of the decorated object
access: an object with references to a getter and setter method to access the decorated object
private: whether the decorated object is a private class member
static: whether the decorated object is a static class member
addInitializer: a way to add custom initialization logic at the beginning of the constructor (or when the class is defined)
Output represents the type of value returned by the Decorator function
In the next section, we’ll take a look at the types of decorators. Interestingly, while old-style decorators let us decorate function parameters, new-style ones don’t, at least for the time being. As a matter of fact, parameter decorators are waiting for a follow-on proposal to reach Stage 3.

Types of decorators
Now that we know how the Decorator type is defined, we’ll take a look at the various types of decorators.

Class decorators
When you attach a function to a class as a decorator, you’ll receive the class constructor as the first parameter:

type ClassDecorator = (value: Function, context: {
  kind: "class"
  name: string | undefined
  addInitializer(initializer: () => void): void
}) => Function | void
For example, let’s assume we want to use a decorator to add two properties, fuel and isEmpty(), to a Rocket class. In this case, we could write the following function:

function WithFuel(target: typeof Rocket, context): typeof Rocket {
  if (context.kind === "class") {
    return class extends target {
      fuel: number = 50
      isEmpty(): boolean {
        return this.fuel == 0
      }
    }
  }
}
After making sure the kind of the decorated element is indeed class, we return a new class with two additional properties. Alternatively, we could have used prototype objects to dynamically add new methods:

function WithFuel(target: typeof Rocket, context): typeof Rocket {
  if (context.kind === "class") {
    target.prototype.fuel = 50
    target.prototype.isEmpty = (): boolean => {
      return this.fuel == 0
    }
  }
}
We can use WithFuel as follows:

@WithFuel
class Rocket {}

const rocket = new Rocket()
console.log((rocket as any).fuel)
console.log(`Is the rocket empty? ${(rocket as any).isEmpty()}`)
/*Prints:
50
Is the rocket empty? false
*/
You might have noticed that we had to cast rocket to any to access the new properties. That’s because decorators can’t influence the structure of the type.

If the original class defines a property that is later decorated, the decorator overrides the original value. For example, if Rocket has a fuel property with a different value, WithFuel would override such a value:

function WithFuel(target: typeof Rocket, context): typeof Rocket {
  if (context.kind === "class") {
    return class extends target {
      fuel: number = 50
      isEmpty(): boolean {
        return this.fuel == 0
      }
    }
  }
}
@WithFuel
class Rocket {
  fuel: number = 75
}

const rocket = new Rocket()
console.log((rocket as any).fuel)
// prints 50
