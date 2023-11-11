https://containers.dev/implementors/templates/
https://github.com/devcontainers/templates
git@github.com:brentgroves/templates.git

Next, we need to tell the devcontainer CLI to use this folder. If you haven’t previously created a config file, run devcontainer config write to save a config file and then open ~/.devcontainer-cli/devcontainer-cli.json in your favourite editor.

The starting configuration will look something like:

{
  "templatepaths": []
}
Update to include the path to the containers folder in the vscode-dev-containers repo you just cloned:

{
  "templatepaths": ["$HOME/source/vscode-dev-containers/containers"]
}
Listing templates
Running devcontainer template list will show the templates that devcontainer discovered

Adding a devcontainer definition
To add the files for a devcontainer definition to your project, change directory to the folder you want to add the devcontainer to and then run:

# Add the go template
devcontainer template add go
This will copy in the template files for you to modify as you wish.

