<https://blog.bitsrc.io/type-vs-interface-in-typescript-cf3c00bc04ae>

Other Types
The type alias can be used for additional types like primitives, unions, and tuples, unlike an interface.

// primitive
type Name = string;

// object
type PersonName = { name: string; };
type PersonAge = { y: number; };

// union
type PartialPoint = PersonName | PersonAge;

// tuple
type Data = [number, string];
In TypeScript, we can only use types to specify above mentioned “additional types,” not interfaces.

However, we may still use those inside an interface, as in the following example:

interface Person {
  name: string
  obj: {}
  union: string | number
  tuple: [string, number]
}
What should We Use?
Use interfaces when:

A new object or an object method needs to be defined.
You wish to benefit from declaration merging.
Use types when:

You need to define a primitive-type alias
Defining tuple types
Defining a union
You must create functions and attempt to overload them in object types through composition.
Requiring the use of mapped types
In the end, you should carefully consider and assess the situation before deciding whether to use a type alias or an interface.

Types are better for working with functions, complex types, etc.

Interfaces work better with objects and method objects.
