https://go.dev/ref/spec#Short_variable_declarations

Function declarations
A function declaration binds an identifier, the function name, to a function.

FunctionDecl = "func" FunctionName [ TypeParameters ] Signature [ FunctionBody ] .
FunctionName = identifier .
FunctionBody = Block .
If the function's signature declares result parameters, the function body's statement list must end in a terminating statement.

func IndexRune(s string, r rune) int {
	for i, c := range s {
		if c == r {
			return i
		}
	}
	// invalid: missing return statement
}

If the function declaration specifies type parameters, the function name denotes a generic function. A generic function must be instantiated before it can be called or used as a value.

func min[T ~int|~float64](x, y T) T {
	if x < y {
		return x
	}
	return y
}
A function declaration without type parameters may omit the body. Such a declaration provides the signature for a function implemented outside Go, such as an assembly routine.

func flushICache(begin, end uintptr)  // implemented externally