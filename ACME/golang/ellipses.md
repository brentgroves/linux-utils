https://go.dev/ref/spec#Passing_arguments_to_..._parameters
Passing arguments to ... parameters
If f is variadic with a final parameter p of type ...T, then within f the type of p is equivalent to type []T. If f is invoked with no actual arguments for p, the value passed to p is nil. Otherwise, the value passed is a new slice of type []T with a new underlying array whose successive elements are the actual arguments, which all must be assignable to T. The length and capacity of the slice is therefore the number of arguments bound to p and may differ for each call site.

Given the function and calls

func Greeting(prefix string, who ...string)
Greeting("nobody")
Greeting("hello:", "Joe", "Anna", "Eileen")
within Greeting, who will have the value nil in the first call, and []string{"Joe", "Anna", "Eileen"} in the second.

If the final argument is assignable to a slice type []T and is followed by ..., it is passed unchanged as the value for a ...T parameter. In this case no new slice is created.

Given the slice s and call

s := []string{"James", "Jasmine"}
Greeting("goodbye:", s...)
within Greeting, who will have the same value as s with the same underlying array.

Instantiations
A generic function or type is instantiated by substituting type arguments for the type parameters. Instantiation proceeds in two steps:

Each type argument is substituted for its corresponding type parameter in the generic declaration. This substitution happens across the entire function or type declaration, including the type parameter list itself and any types in that list.
After substitution, each type argument must satisfy the constraint (instantiated, if necessary) of the corresponding type parameter. Otherwise instantiation fails.
Instantiating a type results in a new non-generic named type; instantiating a function produces a new non-generic function.

type parameter list    type arguments    after substitution

[P any]                int               int satisfies any
[S ~[]E, E any]        []int, int        []int satisfies ~[]int, int satisfies any
[P io.Writer]          string            illegal: string doesn't satisfy io.Writer
[P comparable]         any               any satisfies (but does not implement) comparable
https://stackoverflow.com/questions/28512432/what-is-the-meaning-of-type-in-go

The code in builtin.go serves as documentation. The code is not compiled.

The ... specifies that the final parameter of the function is variadic. Variadic functions are documented in the Go Language specification. In short, variadic functions can be called with any number of arguments for the final parameter.

The Type part is a stand-in for any Go type.

Share
Edit
Follow
cFlag
