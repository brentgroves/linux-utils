<https://stackoverflow.com/questions/63069515/typescript-generics-new-keyword-in-generics-extends>

Was reading the TS docs about decorators and came across the following syntax:

   function classDecorator<T extends {new(...args:any[]):{}}>(constructor:T) {
        return class extends constructor {
            newProperty = "new property";
            hello = "override";
        }
    }
I don't understand fully the following generics being used

<T extends {new(...args:any[]):{}}>
I do understand generics in general and also the extends keyword inside the generics. However I would like to now the meaning of the following syntax {new(...args:any[]):{}} and especially the use of the new, spread ... operator and object literal syntax {} inside the generic expression.

Its basically a class check (an object with a constructor)

{new ... }

These opening and closing curly braces indicate we are working inside an object. Like: {num: number}

new(...args: any[])
the new keyword here highlights that we are looking for something that has a constructor. The ...args: any[] just state that this type doesn't care about the parameters of this constructor.

More specifically, ...args with the three dots state there can be any number of parameters while any[] mean that these parameters can have the any type, meaning they can be absolutely anything.

Then:

: {}
This states that the constructor should return an object, which it most likely will if its for a class.

I've never seen it written like this, normally, its enough to just do this:

<T extends new (...args: any[])=>Object>
The reason the original one needed to be wrapped in {...} is because the usage of a colon : instead of an arrow => confuses typescript, as it doesn't expect a colon outside of an object or type definition.

All in all, it makes sense you have this type, as it ensures this decorator can only be applied to a class, and types it as so within the decorator itself.
