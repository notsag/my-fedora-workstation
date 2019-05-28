# my-fedora-workstation

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Purpose

This is the script and files I use for my Fedora 30 workstation postinstall steps.

## Usage

Eventually edit the list of packages to add/remove depending on our needs.

```
bash ./bootstrap.sh
```

## What it does

It will setup the following repositories :
 - RPMFusion free
 - RPMFusion nonfree
 - copr:notsag/manuskript
 - daniruiz/flat-remix
 - google-chrome
 - whinehq

It will install packages listed in :
  - packages
  - python-packages (using pip3)

It will setup the dotfiles : 
 - gitconfig
 - vimrc
 - zshrc

It will setup [Ohmyzsh](https://ohmyz.sh/) with : 
 - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
 - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
 - [powerlevel9k](https://github.com/bhilburn/powerlevel9k)

It will install [NERD-Fonts](https://github.com/ryanoasis/nerd-fonts).

It will setup Vim with :
 - [Vundle](https://github.com/VundleVim/Vundle.vim.git)
 - [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
 - [NERDTree](https://github.com/scrooloose/nerdtree)
 - [syntastic](https://github.com/vim-syntastic/syntastic)
 - [tabular](https://github.com/godlygeek/tabular)
 - [vim-yaml-folds](https://github.com/vim-syntastic/syntastic)
 - [vim-markdown](https://github.com/plasticboy/vim-markdown)
 - [ansible-vim](https://github.com/pearofducks/ansible-vim)
 - [vim-surround](https://github.com/tpope/vim-surround)
 - [vim-solarized8](https://github.com/lifepillar/vim-solarized8)
 - [Dockerfile.vim](https://github.com/ekalinin/Dockerfile.vim)
 - [vim-qml](https://github.com/peterhoeg/vim-qml)

 It will load the dconf file in the repo.

 It will setup a docker group and put your user in this group.

 It will eventually clone a S3 bucket (after prompting info/credentials).
