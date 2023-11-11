https://go.dev/doc/code
Your first program
To compile and run a simple program, first choose a module path (we'll use example/user/hello) and create a go.mod file that declares it:

cd ~/src/sub_main
go mod init dev.azure.com/MobexGlobal/MobexCloudPlatform/sub_main

$ mkdir hello # Alternatively, clone it if it already exists in version control.
$ cd hello
$ go mod init example/user/hello
go: creating new go.mod: module example/user/hello
$ cat go.mod
module example/user/hello
The first statement in a Go source file must be package name. Executable commands must always use package main.

Next, create a file named hello.go inside that directory containing the following Go code:

package main

import "fmt"

func main() {
    fmt.Println("Hello, world.")
}
Now you can build and install that program with the go tool:

$ go install example/user/hello