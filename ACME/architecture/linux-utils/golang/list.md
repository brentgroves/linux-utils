https://subscription.packtpub.com/book/programming/9781789805789/14/ch14lvl1sec80/go-list#:~:text=go%20list%20performs%20the%20action,build%20flags%5D%20%5Bpackages%5D%20.

Go list
go list performs the action of listing named packages and modules, as well as displaying important build information about files, imports, and dependencies. The invocation stanza for go list is usage: go list [-f format] [-json] [-m] [list flags] [build flags] [packages].

Having access to the data structures that are the main pieces of the build process is powerful. We can use go list to find out a lot about the programs that we are building. For example, take the following simple program, which prints a message and computes a square root for the end user:

package main


import (
    "fmt"
    "math"
)


func main() {
    fmt.Println("Hello Gophers")
    fmt.Println(math.Sqrt(64))
}

Copy
If we want to find out about all the dependencies that we have for our particular project, we can invoke the go list -f '{{.Deps}}' command.

The go list data structure can be found here: https://golang.org/cmd/go/#hdr-List_packages_or_modules. It has many different parameters. One of the other popular outputs from the go list program is the JSON formatted output. In the following screenshot, you can see the output from executing go list -json for our listExample.go:

