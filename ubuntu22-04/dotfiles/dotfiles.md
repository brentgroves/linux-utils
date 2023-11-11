# Install dotfiles

- The dotfiles change add some exports, aliases, and zsh.

```bash
cd ~
git clone git@github.com:brentgroves/dotfiles.git
sudo apt-get install zsh-antigen neofetch fzf fonts-powerline
cd ~/dotfiles
# When prompted choose not to install tmux or nvim
./deploy
# restart terminal
cd ~/dotfiles
rm ~/.zshrc
# use miniconda for the server
cp .zshrc-miniconda ~/.zshrc
or
# dont use anaconda unless you are on a desktop and want the complete GUI
cp .zshrc-anaconda ~/.zshrc

# logout and login
If the prompt does not appear do the following:
1. vi ~/dotfiles/zsh/.antigenrc
2. Uncomment robbyrussel theme in ~/dotfiles/zsh/.antigenrc and comment out the agnoster  theme
3. logout and log back in
4. Open command prompt
You should now see the prompt from the robbyrussel theme.
5. vi ~/dotfiles/zsh/.antigenrc
6. Comment out the robbyrussel theme in ~/dotfiles/zsh/.antigenrc and uncomment the agnoster  theme.
7. Reopen command prompt  

```
