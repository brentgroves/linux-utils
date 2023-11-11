We include the asterisk to allow any Go module in the distribution url.

We can also add the GOPRIVATE environment variable directly in the bashrc or zshrc file, but I’ll leave that to you to investigate further, or simply run the instructions below to add the GOPRIVATE environment variable.

export GOPRIVATE='github.com/username/*'
env | grep GOPRIVATE