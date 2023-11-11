https://go.dev/ref/spec#Type_parameter_declarations

Type parameter declarations
A type parameter list declares the type parameters of a generic function or type declaration. The type parameter list looks like an ordinary function parameter list except that the type parameter names must all be present and the list is enclosed in square brackets rather than parentheses.

TypeParameters  = "[" TypeParamList [ "," ] "]" .
TypeParamList   = TypeParamDecl { "," TypeParamDecl } .
TypeParamDecl   = IdentifierList TypeConstraint .
All non-blank names in the list must be unique. Each name declares a type parameter, which is a new and different named type that acts as a place holder for an (as of yet) unknown type in the declaration. The type parameter is replaced with a type argument upon instantiation of the generic function or type.

[P any]
[S interface{ ~[]byte|string }]
[S ~[]E, E any]
[P Constraint[int]]
[_ any]