https://go.dev/doc/tutorial/getting-started
go version go1.20 linux/amd64
cd ~/src
mkdir hello
cd hello
# enable dependancy tracking
go mod init example/hello
# create a file hello.go in which to write your code.
Paste the following code into your hello.go file and save the file.

package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
This is your Go code. In this code, you:

Declare a main package (a package is a way to group functions, and it's made up of all the files in the same directory).
Import the popular fmt package, which contains functions for formatting text, including printing to the console. This package is one of the standard library packages you got when you installed Go.
Implement a main function to print a message to the console. A main function executes by default when you run the main package.
Run your code to see the greeting.

$ go run .
Hello, World!

# Call code in an external package
Make your printed message a little more interesting with a function from an external module.
Visit pkg.go.dev and search for a "quote" package.
Locate and click the rsc.io/quote package in search results (if you see rsc.io/quote/v3, ignore it for now).
In the Documentation section, under Index, note the list of functions you can call from your code. You'll use the Go function.
At the top of this page, note that package quote is included in the rsc.io/quote module.
You can use the pkg.go.dev site to find published modules whose packages have functions you can use in your own code. Packages are published in modules -- like rsc.io/quote -- where others can use them. Modules are improved with new versions over time, and you can 

# upgrade your code to use the improved versions.

package main

import "fmt"

import "rsc.io/quote"

func main() {
    fmt.Println(quote.Go())
}

# Add new module requirements and sums.
Go will add the quote module as a requirement, as well as a go.sum file for use in authenticating the module. For more, see Authenticating modules in the Go Modules Reference.

$ go mod tidy
go: finding module for package rsc.io/quote
go: found rsc.io/quote in rsc.io/quote v1.5.2

# Run your code to see the message generated by the function you're calling.
$ go run .
Don't communicate by sharing memory, share memory by communicating.
Notice that your code calls the Go function, printing a clever message about communication.

When you ran go mod tidy, it located and downloaded the rsc.io/quote module that contains the package you imported. By default, it downloaded the latest version -- v1.5.2.
