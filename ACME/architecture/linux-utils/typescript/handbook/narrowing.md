<https://www.typescriptlang.org/docs/handbook/2/narrowing.html>

instanceof
 narrowing
JavaScript has an operator for checking whether or not a value is an “instance” of another value. More specifically, in JavaScript x instanceof Foo checks whether the prototype chain of x contains Foo.prototype. While we won’t dive deep here, and you’ll see more of this when we get into classes, they can still be useful for most values that can be constructed with new. As you might have guessed, instanceof is also a type guard, and TypeScript narrows in branches guarded by instanceofs.

function logValue(x: Date | string) {
  if (x instanceof Date) {
    console.log(x.toUTCString());

(parameter) x: Date
  } else {
    console.log(x.toUpperCase());

(parameter) x: string
  }
}
Try
Assignments
As we mentioned earlier, when we assign to any variable, TypeScript looks at the right side of the assignment and narrows the left side appropriately.

let x = Math.random() < 0.5 ? 10 : "hello world!";

let x: string | number
x = 1;

console.log(x);

let x: number
x = "goodbye!";

console.log(x);

let x: string
Try
Notice that each of these assignments is valid. Even though the observed type of x changed to number after our first assignment, we were still able to assign a string to x. This is because the declared type of x - the type that x started with - is string | number, and assignability is always checked against the declared type.

If we’d assigned a boolean to x, we’d have seen an error since that wasn’t part of the declared type.

let x = Math.random() < 0.5 ? 10 : "hello world!";

let x: string | number
x = 1;

console.log(x);

let x: number
x = true;
Type 'boolean' is not assignable to type 'string | number'.

console.log(x);

let x: string | number
Try
Control flow analysis
Up until this point, we’ve gone through some basic examples of how TypeScript narrows within specific branches. But there’s a bit more going on than just walking up from every variable and looking for type guards in ifs, whiles, conditionals, etc. For example

function padLeft(padding: number | string, input: string) {
  if (typeof padding === "number") {
    return " ".repeat(padding) + input;
  }
  return padding + input;
}
Try
padLeft returns from within its first if block. TypeScript was able to analyze this code and see that the rest of the body (return padding + input;) is unreachable in the case where padding is a number. As a result, it was able to remove number from the type of padding (narrowing from string | number to string) for the rest of the function.

This analysis of code based on reachability is called control flow analysis, and TypeScript uses this flow analysis to narrow types as it encounters type guards and assignments. When a variable is analyzed, control flow can split off and re-merge over and over again, and that variable can be observed to have a different type at each point.

function example() {
  let x: string | number | boolean;

  x = Math.random() < 0.5;

  console.log(x);

let x: boolean

  if (Math.random() < 0.5) {
    x = "hello";
    console.log(x);

let x: string
  } else {
    x = 100;
    console.log(x);

let x: number
  }

  return x;

let x: string | number
}
Try
Using type predicates
We’ve worked with existing JavaScript constructs to handle narrowing so far, however sometimes you want more direct control over how types change throughout your code.

To define a user-defined type guard, we simply need to define a function whose return type is a type predicate:

function isFish(pet: Fish | Bird): pet is Fish {
  return (pet as Fish).swim !== undefined;
}
Try
pet is Fish is our type predicate in this example. A predicate takes the form parameterName is Type, where parameterName must be the name of a parameter from the current function signature.

Any time isFish is called with some variable, TypeScript will narrow that variable to that specific type if the original type is compatible.

// Both calls to 'swim' and 'fly' are now okay.
let pet = getSmallPet();

if (isFish(pet)) {
  pet.swim();
} else {
  pet.fly();
}
Try
Notice that TypeScript not only knows that pet is a Fish in the if branch; it also knows that in the else branch, you don’t have a Fish, so you must have a Bird.

You may use the type guard isFish to filter an array of Fish | Bird and obtain an array of Fish:

const zoo: (Fish | Bird)[] = [getSmallPet(), getSmallPet(), getSmallPet()];
const underWater1: Fish[] = zoo.filter(isFish);
// or, equivalently
const underWater2: Fish[] = zoo.filter(isFish) as Fish[];

// The predicate may need repeating for more complex examples
const underWater3: Fish[] = zoo.filter((pet): pet is Fish => {
  if (pet.name === "sharkey") return false;
  return isFish(pet);
});
Try
In addition, classes can use this is Type to narrow their type.

Assertion functions
Types can also be narrowed using Assertion functions.

Discriminated unions
Most of the examples we’ve looked at so far have focused around narrowing single variables with simple types like string, boolean, and number. While this is common, most of the time in JavaScript we’ll be dealing with slightly more complex structures.

For some motivation, let’s imagine we’re trying to encode shapes like circles and squares. Circles keep track of their radiuses and squares keep track of their side lengths. We’ll use a field called kind to tell which shape we’re dealing with. Here’s a first attempt at defining Shape.

interface Shape {
  kind: "circle" | "square";
  radius?: number;
  sideLength?: number;
}
Try
Notice we’re using a union of string literal types: "circle" and "square" to tell us whether we should treat the shape as a circle or square respectively. By using "circle" | "square" instead of string, we can avoid misspelling issues.

function handleShape(shape: Shape) {
  // oops!
  if (shape.kind === "rect") {
This comparison appears to be unintentional because the types '"circle" | "square"' and '"rect"' have no overlap.
    // ...
  }
}
Try
We can write a getArea function that applies the right logic based on if it’s dealing with a circle or square. We’ll first try dealing with circles.

function getArea(shape: Shape) {
  return Math.PI * shape.radius ** 2;
'shape.radius' is possibly 'undefined'.
}
Try
Under strictNullChecks that gives us an error - which is appropriate since radius might not be defined. But what if we perform the appropriate checks on the kind property?

function getArea(shape: Shape) {
  if (shape.kind === "circle") {
    return Math.PI * shape.radius ** 2;
'shape.radius' is possibly 'undefined'.
  }
}
Try
Hmm, TypeScript still doesn’t know what to do here. We’ve hit a point where we know more about our values than the type checker does. We could try to use a non-null assertion (a ! after shape.radius) to say that radius is definitely present.

function getArea(shape: Shape) {
  if (shape.kind === "circle") {
    return Math.PI * shape.radius! ** 2;
  }
}
Try
But this doesn’t feel ideal. We had to shout a bit at the type-checker with those non-null assertions (!) to convince it that shape.radius was defined, but those assertions are error-prone if we start to move code around. Additionally, outside of strictNullChecks we’re able to accidentally access any of those fields anyway (since optional properties are just assumed to always be present when reading them). We can definitely do better.

The problem with this encoding of Shape is that the type-checker doesn’t have any way to know whether or not radius or sideLength are present based on the kind property. We need to communicate what we know to the type checker. With that in mind, let’s take another swing at defining Shape.

interface Circle {
  kind: "circle";
  radius: number;
}

interface Square {
  kind: "square";
  sideLength: number;
}

type Shape = Circle | Square;
Try
Here, we’ve properly separated Shape out into two types with different values for the kind property, but radius and sideLength are declared as required properties in their respective types.

Let’s see what happens here when we try to access the radius of a Shape.

function getArea(shape: Shape) {
  return Math.PI * shape.radius ** 2;
Property 'radius' does not exist on type 'Shape'.
  Property 'radius' does not exist on type 'Square'.
}
Try
Like with our first definition of Shape, this is still an error. When radius was optional, we got an error (with strictNullChecks enabled) because TypeScript couldn’t tell whether the property was present. Now that Shape is a union, TypeScript is telling us that shape might be a Square, and Squares don’t have radius defined on them! Both interpretations are correct, but only the union encoding of Shape will cause an error regardless of how strictNullChecks is configured.

But what if we tried checking the kind property again?

function getArea(shape: Shape) {
  if (shape.kind === "circle") {
    return Math.PI * shape.radius ** 2;

(parameter) shape: Circle
  }
}
Try
That got rid of the error! When every type in a union contains a common property with literal types, TypeScript considers that to be a discriminated union, and can narrow out the members of the union.

In this case, kind was that common property (which is what’s considered a discriminant property of Shape). Checking whether the kind property was "circle" got rid of every type in Shape that didn’t have a kind property with the type "circle". That narrowed shape down to the type Circle.

The same checking works with switch statements as well. Now we can try to write our complete getArea without any pesky ! non-null assertions.

function getArea(shape: Shape) {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;

(parameter) shape: Circle
    case "square":
      return shape.sideLength ** 2;

(parameter) shape: Square
  }
}
Try
The important thing here was the encoding of Shape. Communicating the right information to TypeScript - that Circle and Square were really two separate types with specific kind fields - was crucial. Doing that lets us write type-safe TypeScript code that looks no different than the JavaScript we would’ve written otherwise. From there, the type system was able to do the “right” thing and figure out the types in each branch of our switch statement.

As an aside, try playing around with the above example and remove some of the return keywords. You’ll see that type-checking can help avoid bugs when accidentally falling through different clauses in a switch statement.

Discriminated unions are useful for more than just talking about circles and squares. They’re good for representing any sort of messaging scheme in JavaScript, like when sending messages over the network (client/server communication), or encoding mutations in a state management framework.

The
never
 type
When narrowing, you can reduce the options of a union to a point where you have removed all possibilities and have nothing left. In those cases, TypeScript will use a never type to represent a state which shouldn’t exist.

Exhaustiveness checking
The never type is assignable to every type; however, no type is assignable to never (except never itself). This means you can use narrowing and rely on never turning up to do exhaustive checking in a switch statement.

For example, adding a default to our getArea function which tries to assign the shape to never will not raise an error when every possible case has been handled.

type Shape = Circle | Square;

function getArea(shape: Shape) {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius **2;
    case "square":
      return shape.sideLength** 2;
    default:
      const _exhaustiveCheck: never = shape;
      return_exhaustiveCheck;
  }
}
Try
Adding a new member to the Shape union, will cause a TypeScript error:

interface Triangle {
  kind: "triangle";
  sideLength: number;
}

type Shape = Circle | Square | Triangle;

function getArea(shape: Shape) {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius **2;
    case "square":
      return shape.sideLength** 2;
    default:
      const _exhaustiveCheck: never = shape;
Type 'Triangle' is not assignable to type 'never'.
      return_exhaustiveCheck;
  }
}
Try
On this page
typeof type guards
Truthiness narrowing
Equality narrowing
The in operator narrowing
instanceof narrowing
Assignments
Control flow analysis
Using type predicates
Assertion functions
Discriminated unions
The never type
Exhaustiveness checking
Is this page helpful?
YesNo
Previous
Everyday Types
The language primitives.
