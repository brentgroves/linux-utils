https://pkg.go.dev/golang.org/x/exp/constraints
Package constraints defines a set of useful constraints to be used with type parameters.
Index ¶
type Complex
type Float
type Integer
type Ordered
type Signed
type Unsigned

Types ¶
type Complex ¶
type Complex interface {
	~complex64 | ~complex128
}
Complex is a constraint that permits any complex numeric type. If future releases of Go add new predeclared complex numeric types, this constraint will be modified to include them.

type Float ¶
type Float interface {
	~float32 | ~float64
}
Float is a constraint that permits any floating-point type. If future releases of Go add new predeclared floating-point types, this constraint will be modified to include them.

type Integer ¶
type Integer interface {
	Signed | Unsigned
}
Integer is a constraint that permits any integer type. If future releases of Go add new predeclared integer types, this constraint will be modified to include them.

type Ordered ¶
type Ordered interface {
	Integer | Float | ~string
}
Ordered is a constraint that permits any ordered type: any type that supports the operators < <= >= >. If future releases of Go add new ordered types, this constraint will be modified to include them.

type Signed ¶
type Signed interface {
	~int | ~int8 | ~int16 | ~int32 | ~int64
}
Signed is a constraint that permits any signed integer type. If future releases of Go add new predeclared signed integer types, this constraint will be modified to include them.

type Unsigned ¶
type Unsigned interface {
	~uint | ~uint8 | ~uint16 | ~uint32 | ~uint64 | ~uintptr
}
Unsigned is a constraint that permits any unsigned integer type. If future releases of Go add new predeclared unsigned integer types, this constraint will be modified to include them.