GO111MODULE with Go 1.18
If you still need to use go get to install a binary, you will need to set GO111MODULE=off. The recommended way is to switch to using go install instead. Without GO111MODULE=off, go get will only update your go.mod. Otherwise, it won’t do anything. All the READMEs on the Internet have to be updated; if they don’t, people will get confused by not seeing the binary being installed.
Why was GO111MODULE everywhere? (Go 1.15 and below)
Now that we know that GO111MODULE was very useful with Go 1.15 and below for enabling the Go Modules behavior, here is the answer: that’s because GO111MODULE=on allows you to select a version. Without Go Modules, go get fetches the latest commit from master. With Go Modules, you can select a specific version based on git tags.

Before Go 1.16 got released, I used to use GO111MODULE=on very often when I wanted to switch between the latest version and the HEAD version of gopls (the Go Language Server):

# With Go 1.15.
GO111MODULE=on go get golang.org/x/tools/gopls@latest
GO111MODULE=on go get golang.org/x/tools/gopls@master
GO111MODULE=on go get golang.org/x/tools/gopls@v0.1
GO111MODULE=on go get golang.org/x/tools/gopls@v0.1.8
GO111MODULE="on" go get sigs.k8s.io/kind@v0.7.0
This became much easier with Go 1.16 though. I could do the same thing with:

# With Go 1.16.
go install golang.org/x/tools/gopls@latest

https://maelvls.dev/go111module-everywhere/
You might have noticed that GO111MODULE=on is flourishing everywhere. Many readmes have that:

GO111MODULE=on go get golang.org/x/tools/gopls@latest
Note that go get has been deprecated for installing binaries since Go 1.17 and will be become impossible in Go 1.18. If you are using Go 1.16 or above, you should use instead:

go install golang.org/x/tools/gopls@latest
In this short post, I will explain why GO111MODULE was introduced in Go 1.11, its caveats and interesting bits that you need to know when dealing with Go Modules.

From GOPATH to GO111MODULE
First off, let’s talk about GOPATH. When Go was first introduced in 2009, it was not shipped with a package manager. Instead, go get would fetch all the sources by using their import paths and store them in $GOPATH/src. There was no versioning and the ‘master’ branch would represent a stable version of the package.

Go Modules (previously called vgo – versioned Go) were introduced with Go 1.11. Instead of using the GOPATH for storing a single git checkout of every package, Go Modules stores tagged versions with go.mod keeping track of each package’s version.

Since then, the interaction between the ‘GOPATH behavior’ and the ‘Go Modules behavior’ has become one of the biggest gotchas of Go. One environment variable is responsible for 95% of this pain: GO111MODULE.

The GO111MODULE environment variable
GO111MODULE is an environment variable that can be set when using go for changing how Go imports packages. One of the first pain-points is that depending on the Go version, its semantics change.

GO111MODULE can be set in two different ways:

The environment variable in your shell, e.g.: export GO111MODULE=on.
The “hidden” global configuration only known by go env using go env -w GO111MODULE=on (only available since Go 1.12).
If Go seems to behave the way you think it should, it is recommended to check whether, in the past, you have set the global configuration using go env -w GO111MODULE=on (or off):

go env GO111MODULE
Note that the environment variable takes precedence over the value that was stored using go env -w GO111MODULE.

To unset the global configuration, you can do:

go env -u GO111MODULE
GO111MODULE with Go 1.11 and 1.12
GO111MODULE=on will force using Go modules even if the project is in your GOPATH. Requires go.mod to work.
GO111MODULE=off forces Go to behave the GOPATH way, even outside of GOPATH.
GO111MODULE=auto is the default mode. In this mode, Go will behave
similarly to GO111MODULE=on when you are outside of GOPATH,
similarly to GO111MODULE=off when you are inside the GOPATH even if a go.mod is present.
Whenever you are in your GOPATH and you want to do an operation that requires Go modules (e.g., go get a specific version of a binary), you need to do:

GO111MODULE=on go get github.com/golang/mock/tree/master/mockgen@v1.3.1

# where go stores packages
ls ~/go/pkg/mod/github.com/brentgroves/greetings@v0.1.1
