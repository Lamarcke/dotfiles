# dotfiles/.config/nvim

<a href="https://dotfyle.com/Lamarcke/dotfiles-config-nvim"><img src="https://dotfyle.com/Lamarcke/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/Lamarcke/dotfiles-config-nvim"><img src="https://dotfyle.com/Lamarcke/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/Lamarcke/dotfiles-config-nvim"><img src="https://dotfyle.com/Lamarcke/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>

## Preview
![image](https://github.com/Lamarcke/dotfiles/assets/23425058/c1fd506e-a17f-4bee-8fb5-9cf246d199a2)

## Dependencies
Must be installed before this config:
- git
- make
- python + pip
- node + npm
- ripgrep
- lazygit (optional, for <leader> + gg)

## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:Lamarcke/dotfiles ~/.config/Lamarcke/dotfiles
NVIM_APPNAME=Lamarcke/dotfiles/.config/nvim nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=Lamarcke/dotfiles/.config/nvim nvim
```

