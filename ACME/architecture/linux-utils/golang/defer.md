<https://yourbasic.org/golang/defer/>

Defer statement basics
A defer statement postpones the execution of a function until the surrounding function returns, either normally or through a panic.

func main() {
 defer fmt.Println("World")
 fmt.Println("Hello")
}
Hello
World

Deferred calls are executed even when the function panics:

func main() {
 defer fmt.Println("World")
 panic("Stop")
 fmt.Println("Hello")
}
World
panic: Stop

goroutine 1 [running]:
main.main()
 ../main.go:3 +0xa0
Order of execution
The deferred call’s arguments are evaluated immediately, even though the function call is not executed until the surrounding function returns.

If there are several deferred function calls, they are executed in last-in-first-out order.

func main() {
 fmt.Println("Hello")
 for i := 1; i <= 3; i++ {
  defer fmt.Println(i)
 }
 fmt.Println("World")
}

Hello
World
3
2
1

Use func to return a value
Deferred anonymous functions may access and modify the surrounding function’s named return parameters.

In this example, the foo function returns “Change World”.

func foo() (result string) {
 defer func() {
  result = "Change World" // change value at the very last moment
 }()
 return "Hello World"
}

Common applications
Defer is often used to perform clean-up actions, such as closing a file or unlocking a mutex. Such actions should be performed both when the function returns normally and when it panics.

Close a file
In this example, defer statements are used to ensure that all files are closed before leaving the CopyFile function, whichever way that happens.

func CopyFile(dstName, srcName string) (written int64, err error) {
 src, err := os.Open(srcName)
 if err != nil {
  return
 }
 defer src.Close()

 dst, err := os.Create(dstName)
 if err != nil {
  return
 }
 defer dst.Close()

 return io.Copy(dst, src)
}

The built-in recover function can be used to regain control of a panicking goroutine and resume normal execution.

A call to recover stops the unwinding and returns the argument passed to panic.
If the goroutine is not panicking, recover returns nil.
Because the only code that runs while unwinding is inside deferred functions, recover is only useful inside such functions.

Panic handler example
func main() {
 n := foo()
 fmt.Println("main received", n)
}

func foo() int {
 defer func() {
  if err := recover(); err != nil {
   fmt.Println(err)
  }
 }()
 m := 1
 panic("foo: fail")
 m = 2
 return m
}

foo: fail
main received 0

Since the panic occurred before foo returned a value, n still has its initial zero value.

Return a value
To return a value during a panic, you must use a named return value.

func main() {
 n := foo()
 fmt.Println("main received", n)
}

func foo() (m int) {
 defer func() {
  if err := recover(); err != nil {
   fmt.Println(err)
   m = 2
  }
 }()
 m = 1
 panic("foo: fail")
 m = 3
 return m
}

foo: fail
main received 2

In this example, we use reflection to check if a list of interface variables have types corre­sponding to the para­meters of a given function. If so, we call the function with those para­meters to check if there is a panic.
