https://stackoverflow.com/questions/42691705/what-does-mean-in-go

8

I usually see ./... in golang
for example go test ./...or go fmt ./...

only know the meaning of one or two dots

12

It means perform the action on all packages under a directory. So for example go test ./... runs go test on the current dir + all subdirectories.

The Go tool documentation is here:

https://golang.org/doc/cmd

./... means a recursive action ( ... ) from your current directory ( ./ )

An import path beginning with ./ or ../ is called a relative path. The toolchain supports relative import paths as a shortcut in two ways.

First, a relative path can be used as a shorthand on the command line. If you are working in the directory containing the code imported as "unicode" and want to run the tests for "unicode/utf8", you can type "go test ./utf8" instead of needing to specify the full path. Similarly, in the reverse situation, "go test .." will test "unicode" from the "unicode/utf8" directory. Relative patterns are also allowed, like "go test ./..." to test all subdirectories. See 'go help packages' for details on the pattern syntax.

Second, if you are compiling a Go program not in a work space, you can use a relative path in an import statement in that program to refer to nearby code also not in a work space. This makes it easy to experiment with small multipackage programs outside of the usual work spaces, but such programs cannot be installed with "go install" (there is no work space in which to install them), so they are rebuilt from scratch each time they are built. To avoid ambiguity, Go programs cannot use relative import paths within a work space.

Run go help importpath or see the docs here https://pkg.go.dev/cmd/go#hdr-Relative_import_paths