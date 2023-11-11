https://www.digitalocean.com/community/tutorials/how-to-use-a-private-go-module-in-your-own-project
Configuring Go to Access Private Modules
While Go modules are commonly distributed from their source code repositories, the Go team also runs a few central Go module services to aid ensure modules continue to exist if something happens to the original repository. By default, Go is configured to use these services, but they can cause problems when you try to download a private module because they don’t have access to those modules. To tell Go that some import paths are private and that it shouldn’t try to use the central Go services, you can use the GOPRIVATE environment variable. The GOPRIVATE environment variable is a comma-separated list of import path prefixes where, when encountered, the Go tools will try to access them directly instead of going through the central services. One such example would be the private module you just created.

In order to use the private module, you will tell Go which path to consider private by setting it in the GOPRIVATE variable. There are a few choices you can make when setting your GOPRIVATE variable values. One option is to set GOPRIVATE to github.com. This might not be what you’re looking for, though, because this would tell Go not to use the central services for any module hosted on github.com, including the ones that aren’t yours.

The next option would be to set GOPRIVATE to only your own user path, such as github.com/your_github_username. This solves the problem of considering all of GitHub private, but at some point you may have public modules you’ve created that you’d like to download through the Go module mirror. Doing this wouldn’t cause any problems and would be a perfectly reasonable option, but you also have the option of getting even more specific.

The most specific option would be setting GOPRIVATE to match the path of your module exactly, such as: github.com/your_github_username/mysecret. This solves both of the issues from the previous options, but also introduces the issue that you need to add each of your private repositories to GOPRIVATE individually, such as shown here:

GOPRIVATE=github.com/your_github_username/mysecret,github.com/your_github_username/othersecret
Choosing the best option for youself is a matter of weighing the pros and cons in your situation.

Since you only have a single private module now, we’ll use the full repository name for the value. To set the GOPRIVATE=github.com/your_github_username/mysecret environment variable in your current terminal, use the export command:

export GOPRIVATE='github.com/brentgroves/*'
export GOPRIVATE=dev.azure.com

export GOPRIVATE=github.com/your_github_username/mysecret
If you’d like to double-check that it’s set, you can use the env command along with grep to check for the GOPRIVATE name:

env | grep GOPRIVATE
Output
GOPRIVATE=github.com/your_github_username/mysecret
Even though Go now knows your module is private, it’s still not quite enough to use the module yet. If you try to go get your private module into another module, you’ll likely see an error similar to:

go get github.com/your_github_username/mysecret
got get 'github.com/brentgroves/filter-private'
Output
go get: module github.com/your_github_username/mysecret: git ls-remote -q origin in /Users/your_github_username/go/pkg/mod/cache/vcs/2f8c...b9ea: exit status 128:
	fatal: could not read Username for 'https://github.com': terminal prompts disabled
Confirm the import path was entered correctly.
If this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
This error message says Go tried to download your module, but it encountered something it still doesn’t have access to. Since Git is being used to download the module, it would usually ask you to enter your credentials. However, in this case, Go is calling Git for you and can’t prompt for them. At this point, to access your module you’ll need to provide a way for Git to retrieve your credentials without your immediate input.

familiar with this file as it’s also where your commit email address and name are configured as well. To edit the file, use nano, or your favorite text editor, and open the ~/.gitconfig file in your home directory:

nano ~/.gitconfig
Once you have the file open, edit it to include a url section for ssh://git@github.com/ as in the example below:

~/.gitconfig
[user]
	email = your_github_username@example.com
	name = Sammy the Shark
	
[url "ssh://git@github.com/"]
	insteadOf = https://github.com/
The order of the url section relative to the user section doesn’t matter, and you also don’t need to worry if there’s nothing else in the file except for the url section you just added. The order of the email and name fields inside the user section also does not matter.

This new section tells Git that any URL you use that starts with https://github.com/ should have that prefixed replaced with ssh://git@github.com/ instead. Since Go uses HTTPS by default, this also affects your go get commands. Using your private module as an example, this means Go turns the github.com/your_github_username/mysecret import path into the URL https://github.com/your_github_username/mysecret. When Git encounters this URL it will see the URL matches the https://github.com/ prefix referenced by insteadOf and will turn the resulting URL into ssh://git@github.com/your_github_username/mysecret.

This same pattern can be used for domains other than GitHub as long as the ssh://git@ URL works for that host as well.

In this section, you configured Git to use SSH to download Go modules by updating your .gitconfig file and adding a url section. Now that authentication for your private module is set up, you can access it for use in your Go programs.


https://medium.com/the-godev-corner/how-to-create-a-go-private-module-with-docker-b705e4d195c4

The good news is that relatively speaking, public packages aren’t that much more difficult to create than private ones, and vice versa. But they are a bit different.

👉 Note: I’ll be using the terms Go package and Go module interchangeably throughout this article

Nevertheless, working with private Go module distributions on private platforms such as bitbucket, Gitlab, or Github is an invaluable skill to have whether you’re creating a personal project or want to keep proprietary logic “in-house.” So I figured it would be worthwhile to guide a few people through it.

As an added bonus, I’ll also be showing you how to develop a Go application using a Docker image — so buckle up, sit tight, and let’s get started.

The GoDev Corner paragraph separator
Short Preface
By the end of this article, you’ll be able to:
[Feel free to skip ahead to a specific section]

Create a GitHub private repository (for your Go private module)
Setup and configure your Go private module
Use it locally and with Docker
Set authentication credentials for it
Establish a secure connection (using SSH) for it
Configure Docker (and securely download it)
And build application Docker images for it
Prerequisites
Go module knowledge
(Note: if you’re new to Go modules, I recommend you start with the official documentation)
Go 1.16+ installed
Familiarity with Git


The environmental variable GOPRIVATE enables us to distribute Go private modules, and we can use this command to set the GOPRIVATE values:

go env -w GOPRIVATE="github.com/brentgroves/*"
To set a Go environment variable, use go env -w. The preceding command informs Go of modules distribution source other than the Go public packages distribution. github.com/username/* corresponds to your organization’s or personal private Go module distribution, which can also be Gitlab, Bitbucket, or other similar services.

But what if we have multiple private modules?

In that case, we can use a comma to separate the module’s distribution source, as shown below.

go env -w GOPRIVATE=github.com/username/*,gitlab.com/username/*
👉 We include the asterisk to allow any Go module in the distribution url.

We can also add the GOPRIVATE environment variable directly in the bashrc or zshrc file, but I’ll leave that to you to investigate further, or simply run the instructions below to add the GOPRIVATE environment variable.

👉 Setting GOPRIVATE does not interfere with the distribution of Go public modules.

To confirm that GOPRIVATE environment variable is set, run this command:

env | grep GOPRIVATE