# dotfiles

These are my dotfiles. I use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) shell and [stow](http://www.gnu.org/software/stow/) to manage symlinks.


## installation

All installation is done via the `install.sh` script. Comment/uncomment the sections relevant to you:

```
cd ~
git clone https://github.com/2korzhik/dotfiles.git
cd dotfiles
source install.sh
```

To install specific configs, you can use the `stow` command with the folder name as the only argument.

To install the *zsh* configs:

```
stow zsh
```

This will symlink everything in `~/dotfiles/zsh` to the correct place in `$HOME`.
