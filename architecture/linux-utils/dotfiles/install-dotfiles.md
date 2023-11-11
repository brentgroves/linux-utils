# Install dotfiles

```bash
cd ~
git clone git@github.com:brentgroves/dotfiles.git
sudo apt-get install zsh-antigen neofetch fzf fonts-powerline
# do not install tmux or nvim now
cd ~/dotfiles
./deploy
# dont install tmux or vim now
# restart terminal
cd ~/dotfiles
rm ~/.zshrc
cp .zshrc-miniconda ~/.zshrc
# logout and login

# prompt does not appear but you can still type
# Theme Error on first start
# Uncomment robbyrussel theme In dotfiles/zsh/.antigenrc
# Comment out the agnoster  theme
# Open command prompt
# Uncomment theme agnoster theme In dotfiles/zsh/.antigenrc
# Reopen command prompt  
```
