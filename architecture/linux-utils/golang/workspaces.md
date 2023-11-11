Workspaces in Go 1.18 let you work on multiple modules simultaneously without having to edit go.mod files for each module. Each module within a workspace is treated as a main module when resolving dependencies.

Previously, to add a feature to one module and use it in another module, you needed to either publish the changes to the first module, or edit the go.mod file of the dependent module with a replace directive for your local, unpublished module changes. In order to publish without errors, you had to remove the replace directive from the dependent module’s go.mod file after you published the local changes to the first module.

<https://go.dev/blog/get-familiar-with-workspaces>
With Go workspaces, you control all your dependencies using a go.work file in the root of your workspace directory. The go.work file has use and replace directives that override the individual go.mod files, so there is no need to edit each go.mod file individually.

You create a workspace by running go work init with a list of module directories as space-separated arguments. The workspace doesn’t need to contain the modules you’re working with. The init command creates a go.work file that lists modules in the workspace. If you run go work init without arguments, the command creates an empty workspace.

To add modules to the workspace, run go work use [moddir] or manually edit the go.work file. Run go work use -r . to recursively add directories in the argument directory with a go.mod file to your workspace. If a directory doesn’t have a go.mod file, or no longer exists, the use directive for that directory is removed from your go.work file.

The syntax of a go.work file is similar to a go.mod file and contains the following directives:

go: the go toolchain version e.g. go 1.18
use: adds a module on disk to the set of main modules in a workspace. Its argument is a relative path to the directory containing the module’s go.mod file. A use directive doesn’t add modules in subdirectories of the specified directory.
replace: Similar to a replace directive in a go.mod file, a replace directive in a go.work file replaces the contents of a specific version of a module, or all versions of a module, with contents found elsewhere.

The main module is the module containing the directory where the go command is invoked. Each package within a module is a collection of source files in the same ...

A module is identified by a module path, which is declared in a go.mod file, together with information about the module’s dependencies. The module root directory is the directory that contains the go.mod file. The main module is the module containing the directory where the go command is invoked.

Each package within a module is a collection of source files in the same directory that are compiled together. A package path is the module path joined with the subdirectory containing the package (relative to the module root). For example, the module "golang.org/x/net" contains a package in the directory "html". That package’s path is "golang.org/x/net/html".
