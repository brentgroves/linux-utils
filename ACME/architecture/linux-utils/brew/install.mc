https://www.how2shout.com/linux/install-brew-on-ubuntu-22-04-lts-jammy-linux/
sudo apt install build-essential git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install gcc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"