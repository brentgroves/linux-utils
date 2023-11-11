https://www.geeksforgeeks.org/pointers-in-golang/#

Before we start there are two important operators which we will use in pointers i.e. 

* Operator also termed as the dereferencing operator used to declare pointer variable and access the value stored in the address.
& operator termed as address operator used to returns the address of a variable or to access the address of a variable to a pointer.
Declaring a pointer:

var pointer_name *Data_Type
Example: Below is a pointer of type string which can store only the memory addresses of string variables.
 

var s *string
Initialization of Pointer: To do this you need to initialize a pointer with the memory address of another variable using the address operator as shown in the below example:
 

// normal variable declaration
var a = 45

// Initialization of pointer s with 
// memory address of variable a
var s *int = &a
Example:


// Golang program to demonstrate the declaration
// and initialization of pointers
package main
 
import "fmt"
 
func main() {
 
    // taking a normal variable
    var x int = 5748
     
    // declaration of pointer
    var p *int
     
    // initialization of pointer
    p = &x
 
        // displaying the result
    fmt.Println("Value stored in x = ", x)
    fmt.Println("Address of x = ", &x)
    fmt.Println("Value stored in variable p = ", p)
}

3. If you are specifying the data type along with the pointer declaration then the pointer will be able to handle the memory address of that specified data type variable. For example, if you taking a pointer of string type then the address of the variable that you will give to a pointer will be only of string data type variable, not any other type.

4. To overcome the above mention problem you can use the Type Inference concept of the var keyword. There is no need to specify the data type during the declaration. The type of a pointer variable can also be determined by the compiler like a normal variable. Here we will not use the * operator. It will internally determine by the compiler as we are initializing the variable with the address of another variable.

Example:

// Golang program to demonstrate
// the use of type inference in
// Pointer variables
package main
 
import "fmt"
 
func main() {
 
    // using var keyword
    // we are not defining
    // any type with variable
    var y = 458
     
    // taking a pointer variable using
    // var keyword without specifying
    // the type
    var p = &y
 
    fmt.Println("Value stored in y = ", y)
    fmt.Println("Address of y = ", &y)
    fmt.Println("Value stored in pointer variable p = ", p)
}
Output: 
 

Value stored in y =  458
Address of y =  0x414020
Value stored in pointer variable p =  0x414020
5. You can also use the shorthand (:=) syntax to declare and initialize the pointer variables. The compiler will internally determine the variable is a pointer variable if we are passing the address of the variable using &(address) operator to it.

Example:

// Golang program to demonstrate
// the use of shorthand syntax in
// Pointer variables
package main
 
import "fmt"
 
func main() {
 
    // using := operator to declare
    // and initialize the variable
    y := 458
     
    // taking a pointer variable using
    // := by assigning it with the
    // address of variable y
    p := &y
 
    fmt.Println("Value stored in y = ", y)
    fmt.Println("Address of y = ", &y)
    fmt.Println("Value stored in pointer variable p = ", p)
}
Output:

Value stored in y =  458
Address of y =  0x414020
Value stored in pointer variable p =  0x414020
Dereferencing the Pointer
As we know that * operator is also termed as the dereferencing operator. It is not only used to declare the pointer variable but also used to access the value stored in the variable which the pointer points to which is generally termed as indirecting or dereferencing. * operator is also termed as the value at the address of. Let’s take an example to get a better understandability of this concept:

Example:
 

/ concept of dereferencing a pointer
package main
  
import "fmt"
  
func main() {
  
    // using var keyword
    // we are not defining
    // any type with variable
    var y = 458
      
    // taking a pointer variable using
    // var keyword without specifying
    // the type
    var p = &y
  
    fmt.Println("Value stored in y = ", y)
    fmt.Println("Address of y = ", &y)
    fmt.Println("Value stored in pointer variable p = ", p)
 
    // this is dereferencing a pointer
    // using * operator before a pointer
    // variable to access the value stored
    // at the variable at which it is pointing
    fmt.Println("Value stored in y(*p) = ", *p)
 
}
Output:
 

Value stored in y =  458
Address of y =  0x414020
Value stored in pointer variable p =  0x414020
Value stored in y(*p) =  458
You can also change the value of the pointer or at the memory location instead of assigning a new value to the variable.

Example:
 

// Golang program to illustrate the
// above mentioned concept
package main
  
import "fmt"
  
func main() {
  
    // using var keyword
    // we are not defining
    // any type with variable
    var y = 458
      
    // taking a pointer variable using
    // var keyword without specifying
    // the type
    var p = &y
  
    fmt.Println("Value stored in y before changing = ", y)
    fmt.Println("Address of y = ", &y)
    fmt.Println("Value stored in pointer variable p = ", p)
 
    // this is dereferencing a pointer
    // using * operator before a pointer
    // variable to access the value stored
    // at the variable at which it is pointing
    fmt.Println("Value stored in y(*p) Before Changing = ", *p)
 
    // changing the value of y by assigning
    // the new value to the pointer
    *p = 500
 
     fmt.Println("Value stored in y(*p) after Changing = ",y)
 
}
Output: 

Value stored in y before changing =  458
Address of y =  0x414020
Value stored in pointer variable p =  0x414020
Value stored in y(*p) Before Changing =  458
Value stored in y(*p) after Changing =  500
