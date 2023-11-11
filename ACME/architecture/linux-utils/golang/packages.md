<https://thenewstack.io/understanding-golang-packages/>
Note: these env variables are not in the ZSH env.
go env GOPATH  // add ~/go/bin to .profile or exports.zsh
/home/brent/go  // ~/go/bin is were executables are installed with go install
go env GOROOT
/home/brent/sdk/go1.20
The packages from the standard library are available at the “pkg” subdirectory of the GOROOT directory.  I see an include and tool directory
/home/brent/sdk/go1.20/pkg/tool
└── linux_amd64
    ├── addr2line
    ├── asm
    ├── buildid
    ├── cgo
    ├── compile
    ├── covdata
    ├── cover
    ├── dist
    ├── doc
    ├── fix
    ├── link
    ├── nm
    ├── objdump
    ├── pack
    ├── pprof
    ├── test2json
    ├── trace
    └── vet

<https://livebook.manning.com/book/go-in-action/chapter-8/#:~:text=The%20Go%20standard%20library%20is,download%20packages%20others%20have%20published>.
The Go standard library is a set of core packages that enhance and extend the language. These packages add to the number of different types of programs you can write without the need to build your own packages or download packages others have published.

<https://objectcomputing.com/resources/publications/sett/april-2019-way-to-go-part-3>
Go provides many packages in the "standard library." To see a list of them, browse <https://golang.org/pkg/>.

Go provides many packages in the "standard library." To see a list of them, browse <https://golang.org/pkg/>.

Clicking on the name of a library function in the documentation displays its source code, which is useful for learning how they work and seeing examples of good Go code.

    When you build reusable pieces of code, you will develop a package as a shared library. But when you develop executable programs, you will use the package “main” for making the package as an executable program. 

    The package “main” tells the Go compiler that the package should compile as an executable program instead of a shared library. 

    The main function in the package “main” will be the entry point of our executable program. When you build shared libraries, you will not have any main package and main function in the package.

When you import packages, the Go compiler will look on the locations specified by the environment variable GOROOT and GOPATH.

<https://www.jetbrains.com/help/go/configuring-goroot-and-gopath.html>

Go tools expect a certain layout of the source code. GOROOT and GOPATH are environment variables that define this layout.

GOROOT is a variable that defines where your Go SDK is located. You do not need to change this variable, unless you plan to use different Go versions.
ls ~/sdk/go1.20/bin/:
go  gofmt

GOPATH is a variable that defines the root of your workspace. By default, the workspace directory is a directory that is named go within your user home directory (~/go for Linux and macOS, %USERPROFILE%/go for Windows). GOPATH stores your code base and all the files that are necessary for your development. You can use another directory as your workspace by configuring GOPATH for different scopes. GOPATH is the root of your workspace and contains the following folders:

src/: location of Go source code (for example, .go, .c, .g, .s).
ls: cannot access '/home/brent/go/src': No such file or directory

pkg/: location of compiled package code (for example, .a).
ls /home/brent/go/pkg/mod
cache  github.com  golang.org  gopkg.in  go.starlark.net@v0.0.0-20220816155156-cfacd8902214  honnef.co  mvdan.cc  rsc.io

bin/: location of compiled executable programs built by Go.
ls /home/brent/go/bin
dlv  go1.20  gomodifytags  go-outline  goplay  gopls  gotests  hello  impl  staticcheck

<https://thenewstack.io/understanding-golang-packages/>

# Creating and Reusing Packages

Let’s create a sample program for demonstrating a package. Create a source file “languages.go” for the package “lib” at the location github.com/shijuvar/go-samples-thenewstack/packagedemo/lib” in the GOPATH. Since the “languages.go” belongs to the folder “lib”, the package name will be named “lib”.  All files created inside the lib folder belongs to lib package.

go help environment
GOMOD
                The absolute path to the go.mod of the main module.
                If module-aware mode is enabled, but there is no go.mod, GOMOD will be
                os.DevNull ("/dev/null" on Unix-like systems, "NUL" on Windows).
                If module-aware mode is disabled, GOMOD w

/home/brent/src/reports/volume/go/hello/go.mod
go env GOMOD // this is null outside of vscode env.

 GOWORK
                In module aware mode, use the given go.work file as a workspace file.
                By default or when GOWORK is "auto", the go command searches for a
                file named go.work in the current directory and then containing directories
                until one is found. If a valid go.work file is found, the modules
                specified will collectively be used as the main modules. If GOWORK
                is "off", or a go.work file is not found in "auto" mode, workspace
                mode is disabled.
go env GOWORK
/home/brent/src/reports/go.work
this is empty outside of vscode
go env -w: GOMOD cannot be modified
GOMOD variable is specific to module (project) so it makes sense it is not allowed to be written to default env which is shared for all modules and stored in your os. UserConfigDir()/go/env (e.g. ~/. config/go/env ). You don't need to set GOMOD , go tool will find go.
GOENV="/home/brent/.config/go/env"

GOWORK="/home/brent/src/reports/go.work"
