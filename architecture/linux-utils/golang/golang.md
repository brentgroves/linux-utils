https://go.dev/doc/tutorial/getting-started

Install Go
sudo apt update
sudo apt upgrade
sudo snap install --classic go  # version 1.20.2, or
sudo apt  install golang-go  # version 2:1.18~0ubuntu2
sudo apt  install gccgo-go   # version 2:1.18~0ubuntu2
See 'snap info go' for additional versions.

# install the go delve debugger
go install github.com/go-delve/delve/cmd/dlv@latest

# install the language server
sudo snap install gopls --classic


cd ~/src
git clone git@github.com:brentgroves/gotest.git

olang, alias Go is a cross-platform and open-source programming language that can be set up on several operating systems like Linux, Windows, and macOS. The language is well-built to be used by professionals for application development purposes. Go is simple to build and manage, making it an ideal programming language for creating efficient software. It is reliable, builds fast, and has efficient software that scales fast.

Go code syntax resembles C’s, but the language provides enhanced features, including memory safety, structural typing, garbage college, and much more. This open-source language was designed by Google’s engineers, Robert Griesemer, Ken Thompson, and Rob Pike. Go is statistically typed and produces compiled machine code binaries, making it well-known among developers because they don’t need source code compilation to create an executable file.

Another great thing about Go is the concurrency mechanisms that make writing programs that fully capitalize on multicore and networked PCs stress-free. At the same time, its novel-typed systems allow flexible and modular program constructions.


Create a hello directory for your first Go source code.
For example, use the following commands:

mkdir ~/src/gotest
cd ~/src/test


Enable dependency tracking for your code.
When your code imports packages contained in other modules, you manage those dependencies through your code's own module. That module is defined by a go.mod file that tracks the modules that provide those packages. That go.mod file stays with your code, including in your source code repository.

To enable dependency tracking for your code by creating a go.mod file, run the go mod init command, giving it the name of the module your code will be in. The name is the module's module path.

In actual development, the module path will typically be the repository location where your source code will be kept. For example, the module path might be github.com/mymodule. If you plan to publish your module for others to use, the module path must be a location from which Go tools can download your module. For more about naming a module with a module path, see Managing dependencies.


For the purposes of this tutorial, just use example/gotest.

go mod init example/gotest
go: creating new go.mod: module example/hello

Call code in an external package
When you need your code to do something that might have been implemented by someone else, you can look for a package that has functions you can use in your code.

Make your printed message a little more interesting with a function from an external module.
Visit pkg.go.dev and search for a "quote" package.
Locate and click the rsc.io/quote package in search results (if you see rsc.io/quote/v3, ignore it for now).
In the Documentation section, under Index, note the list of functions you can call from your code. You'll use the Go function.
At the top of this page, note that package quote is included in the rsc.io/quote module.
You can use the pkg.go.dev site to find published modules whose packages have functions you can use in your own code. Packages are published in modules -- like rsc.io/quote -- where others can use them. Modules are improved with new versions over time, and you can upgrade your code to use the improved versions.

In your Go code, import the rsc.io/quote package and add a call to its Go function.
After adding the highlighted lines, your code should include the following:

package main

import "fmt"

import "rsc.io/quote"

func main() {
    fmt.Println(quote.Go())
}


Run your code to see the greeting.

$ go run .
Hello, World!

Add new module requirements and sums.
Go will add the quote module as a requirement, as well as a go.sum file for use in authenticating the module. For more, see Authenticating modules in the Go Modules Reference.

$ go mod tidy
go: finding module for package rsc.io/quote
go: found rsc.io/quote in rsc.io/quote v1.5.2

From the command line in the hello directory, run the go build command to compile the code into an executable.
$ go build
./gotest

code .
https://github.com/golang/vscode-go/issues/1411
Install GoNightly

Run Preferences: Open Settings UI
goto extensions
search for alternateTools
and choose edit in json

    "go.alternateTools": {
        "go": "/snap/go/current/bin/go"
    },

Run Preferences: Open Settings (JSON) command to open your settings.json file.