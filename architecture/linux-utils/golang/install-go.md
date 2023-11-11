# install on ubuntu

<https://us.ovhcloud.com/community/tutorials/how-to-install-go-ubuntu/>
Installation of Go
To install Go on Ubuntu, the easiest way is to use apt-get command:

sudo apt-get update && sudo apt-get -y install golang-go
go version
go version go1.18.1 linux/amd64
Go allow you to manage multiple installed versions. For example, to install the version 1.17:
go install golang.org/dl/go1.20@latest
https://go.dev/dl/go1.20.8.linux-386.tar.gz
Output should be like this:
go install golang.org/dl/go1.20@latest
go: downloading golang.org/dl v0.0.0-20220510203206-88ea6714b1d9
The go command download the binary
go1.29
in the folder
~/go/bin
.
Next, you can use this binary to install the version 1.20:
~/go/bin/go1.20 download
Output should be like this:
$ ~/go/bin/go1.20 download
Downloaded   0.0% (    16384 / 134787877 bytes) ...
Downloaded  37.7% ( 50822784 / 134787877 bytes) ...
Downloaded  82.8% (111606960 / 134787877 bytes) ...
Downloaded 100.0% (134787877 / 134787877 bytes)
Unpacking /home/ubuntu/sdk/go1.20/go1.20.linux-amd64.tar.gz ...
Success. You may now run 'go1.20'
Your fresh installation of Go is in the folder ~/sdk/go1.20.
You can update your path environment variable if you want to use this version:
Output should be like this:
update .profile or exports.zsh
export PATH=$HOME/.local/bin:$HOME/sdk/go1.20/bin/:$HOME/go/bin/:$PATH
To find the binary’s install path,
go list -f ‘{{.Target}}’
go version
go version go1.20 linux/amd64

<https://github.com/dominikh/go-tools#installation>

# install go linter

go install honnef.co/go/tools/cmd/staticcheck@latest

# install debugger

go install github.com/go-delve/delve/cmd/dlv@latest

# language server (I think vscode handles this install)

go install golang.org/x/tools/gopls@latest
<https://github.com/golang/vscode-go/blob/master/README.md>
Welcome! 👋🏻
Whether you are new to Go or an experienced Go developer, we hope this extension fits your needs and enhances your development experience.
Install Go 1.14 or newer if you haven't already.
Install the VS Code Go extension.
Open any directory or workspace containing Go code to automatically activate the extension. The Go status bar appears in the bottom left corner of the window and displays your Go version.
The extension depends on go, gopls, dlv and other optional tools. If any of the dependencies are missing, the ⚠️ Analysis Tools Missing warning is displayed. Click on the warning to download dependencies.
See the tools documentation for a complete list of tools the extension depends on.

# install vscode go extension

<https://marketplace.visualstudio.com/items?itemName=golang.go>
Installation
Launch VS Code Quick Open (Ctrl+P), paste the following command, and press enter.
ext install golang.Go

~/go
or

# VSCode

The extension depends on go, gopls, dlv and other optional tools. If any of the dependencies are missing, the ⚠️ Analysis Tools Missing warning is displayed. Click on the warning to download dependencies.
