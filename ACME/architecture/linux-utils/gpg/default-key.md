https://unix.stackexchange.com/questions/339077/set-default-key-in-gpg-for-signing

To choose a default key without having to specify --default-key on the command-line every time, create a configuration file (if it doesn't already exist), ~/.gnupg/gpg.conf, and add a line containing
nvim ~/.gnupg/gpg.conf
default-key 23CE47FCA5F5E530FA54F820858586D4AE7A3E6F

These steps are for EVERY GPG signing. That is, you don’t want to use the tedious —default-key on the CLI anymore.

List your signatures:

gpg --list-signatures
Select your key to be that default. Then set the key default:

echo 'default-key:0:"4148BE367A80A6B7D7CB08A8A9CB7B55FA3C60CA' | gpgconf --change-options gpg
please note that there is only ONE double-quote, which signifies that a text string is about to begin. Also that there is a pair of single-quote surround the entire echo statement.

there are three values separated by two colon symbols.

First is the configuration keyword option “default-key”
Second is pretty much always ‘0’, which means no special flag bit set. ‘16’ means to delete the key from its configuration file. More on special flags
Also for gpgconf, the —change-options requires an argument. That argument indicates a component name that helps chooses which configuration file to make the change with. Component names used are commonly gpg for the ~/.gnupg/gpg.conf file and gpg-agent for ~/.gnupg/gpg-agent.conf file. More on component names here.

Once the setting of default key is done, if you want to use a different key of yours, use the —local-user <your name> on the gpg command line just for that message. Or the easier -u <your name> option instead.

Note that -u or --local-user overrides this —default-key at command line or in gpg.conf setting.

