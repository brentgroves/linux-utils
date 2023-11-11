https://go.dev/doc/modules/managing-dependencies#naming_module

Naming a module
When you run go mod init to create a module for tracking dependencies, you specify a module path that serves as the module’s name. The module path becomes the import path prefix for packages in the module. Be sure to specify a module path that won’t conflict with the module path of other modules.

At a minimum, a module path need only indicate something about its origin, such as a company or author or owner name. But the path might also be more descriptive about what the module is or does.

The module path is typically of the following form:

<prefix>/<descriptive-text>
The prefix is typically a string that partially describes the module, such as a string that describes its origin. This might be:

The location of the repository where Go tools can find the module’s source code (required if you’re publishing the module).

For example, it might be github.com/<project-name>/.

Use this best practice if you think you might publish the module for others to use. For more about publishing, see Developing and publishing modules.

A name you control.

If you’re not using a repository name, be sure to choose a prefix that you’re confident won’t be used by others. A good choice is your company’s name. Avoid common terms such as widgets, utilities, or app.

For the descriptive text, a good choice would be a project name. Remember that package names carry most of the weight of describing functionality. The module path creates a namespace for those package names.

https://go.dev/doc/modules/publishing

Publishing steps
Use the following steps to publish a module.

Open a command prompt and change to your module’s root directory in the local repository.

Run go mod tidy, which removes any dependencies the module might have accumulated that are no longer necessary.

$ go mod tidy
Run go test ./... a final time to make sure everything is working.

This runs the unit tests you’ve written to use the Go testing framework.

$ go test ./...
ok      example.com/mymodule       0.015s
Tag the project with a new version number using the git tag command.

For the version number, use a number that signals to users the nature of changes in this release. For more, see Module version numbering.

$ git commit -m "mymodule: changes for v0.1.0"
$ git tag v0.1.0
Push the new tag to the origin repository.

$ git push origin v0.1.0
Make the module available by running the go list command to prompt Go to update its index of modules with information about the module you’re publishing.

Precede the command with a statement to set the GOPROXY environment variable to a Go proxy. This will ensure that your request reaches the proxy.

$ GOPROXY=proxy.golang.org go list -m example.com/mymodule@v0.1.0
Developers interested in your module import a package from it and run the go get command just as they would with any other module. They can run the go get command for latest versions or they can specify a particular version, as in the following example:

$ go get example.com/mymodule@v0.1.0
