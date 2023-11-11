<https://www.w3schools.com/typescript/typescript_basic_generics.php>

Functions
Generics with functions help make more generalized methods which more accurately represent the types used and returned.

ExampleGet your own TypeScript Server
function createPair<S, T>(v1: S, v2: T): [S, T] {
  return [v1, v2];
}
console.log(createPair<string, number>('hello', 42)); // ['hello', 42]
