# Install NeoVim

## Add universe repo for appimage to work

```bash
<https://github.com/AppImage/AppImageKit/wiki/FUSE>
sudo add-apt-repository universe

sudo apt-get install build-essential xclip libfuse2 xsel

Needed for copy/paste to system clipboard using “+y in nvim
Neovim
<https://github.com/neovim/neovim/wiki/Installing-Neovim>
The version in ubuntu is way to old.
```

```bash
cd ~/Downloads
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo install -m 755 nvim.appimage /usr/bin/nvim
or
mv nvim.appimage nvim
chmod 755 nvim
sudo mv nvim /usr/local/bin

mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim
echo 'so /home/brent/dotfiles/nvim/init.vim' > ~/.config/nvim/init.vim
# echo 'so ~/dotfiles/nvim/init.vim' > ~/.config/nvim/init.vim

-- Install vim plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Start nvim you will see errors.
:checkhealth
:PlugInstall
install could take a while but be patient it is hard to tell that it is actually installing stuff.
Rerun nvim
:checkhealth
Everything ok now.

<https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim>

pip3 install --user neovim
```
