https://go.dev/doc/tutorial/create-module

Create a greetings directory for your Go module source code.
For example, from your home directory use the following commands:

mkdir greetings
cd greetings
Start your module using the go mod init command.
Run the go mod init command, giving it your module path -- here, use example.com/greetings. If you publish a module, this must be a path from which your module can be downloaded by Go tools. That would be your code's repository.

For more on naming your module with a module path, see Managing dependencies.

$ go mod init example.com/greetings
go: creating new go.mod: module example.com/greetings
The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.

Adding a dependency
Once you’re importing packages from a published module, you can add that module to manage as a dependency by using the go get command.

The command does the following:

If needed, it adds require directives to your go.mod file for modules needed to build packages named on the command line. A require directive tracks the minimum version of a module that your module depends on. See the go.mod reference for more.

If needed, it downloads module source code so you can compile packages that depend on them. It can download modules from a module proxy like proxy.golang.org or directly from version control repositories. The source is cached locally.

You can set the location from which Go tools download modules. For more, see Specifying a module proxy server.

The following describes a few examples.

To add all dependencies for a package in your module, run a command like the one below ("." refers to the package in the current directory):
git submodule add <url> volume/go/create-go-module/filter_main
git submodule add git@github.com:brentgroves/filter_main.git volume/go/create-go-module/filter_main

git@github.com:brentgroves/filter_private.git
$ go get .
To add a specific dependency, specify its module path as an argument to the command.

$ go get example.com/theirmodule
The command also authenticates each module it downloads. This ensures that it’s unchanged from when the module was published. If the module has changed since it was published – for example, the developer changed the contents of the commit – Go tools will present a security error. This authentication check protects you from modules that might have been tampered with.
