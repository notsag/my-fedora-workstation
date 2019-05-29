#!/usr/bin/bash
echo -e "###################"
echo -e "##     REPOS     ##"
echo -e "###################\n"

echo "Install RPMFusion"
sudo dnf install -y \
    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-30.noarch.rpm \
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-30.noarch.rpm \
    fedora-workstation-repositories \
    dnf-plugins-core >/dev/null

echo "Enable copr"
sudo dnf copr enable -y notsag/manuskript > /dev/null
sudo dnf copr enable -y daniruiz/flat-remix > /dev/null

echo "Enable google-chrome repo"
sudo dnf config-manager --set-enabled google-chrome > /dev/null
echo "Enable google-chrome repo"
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/30/winehq.repo > /dev/null

echo -e "\n###################"
echo -e "##      PKG      ##"
echo -e "###################\n"

echo "Install all RPMs listed in packages"
sudo dnf install -y $(cat packages) > /dev/null
echo "Upgrade pip"
sudo python3 -m pip install --upgrade pip > /dev/null
echo "Install all python packages listed in python-packages"
sudo python3 -m pip install --upgrade -r python-packages > /dev/null

echo -e "\n###################"
echo -e "##      GIT      ##"
echo -e "###################\n"

echo "Copy gitconfig"
cp dotfiles/gitconfig ~/.gitconfig > /dev/null

echo -e "\n###################"
echo -e "##      ZSH      ##"
echo -e "###################\n"

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh| sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')" > /dev/null

echo "Copy zshrc"
chsh -s /bin/zsh
cp dotfiles/zshrc ~/.zshrc > /dev/null

echo "Install zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > /dev/null
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k > /dev/null

echo "Install NERD-Fonts"
mkdir -p ~/.local/share/fonts > /dev/null
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/.local/share/fonts/nerd-fonts > /dev/null
/bin/sh ~/.local/share/fonts/nerd-fonts/install.sh Hack > /dev/null

echo -e "\n###################"
echo -e "##      VIM      ##"
echo -e "###################\n"

echo "Copy vimrc"
cp dotflies/vimrc ~/.vimrc > /dev/null

echo "Install Vundle"
mkdir -p  ~/.vim/bundle > /dev/null
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null

echo "Install vim plugins"
vim -E -s +PluginInstall +qall > /dev/null

echo "Copy python autocompletion script"
mkdir -p ~/.config > /dev/null
cp config/global_extra_conf.py ~/.config/ > /dev/null

echo -e "\n###################"
echo -e "##     DCONF     ##"
echo -e "###################\n"

echo "Load global gnome configuration"
dconf load / < dotfiles/my-gnome.dconf > /dev/null

echo -e "\n###################"
echo -e "##     DOCKER    ##"
echo -e "###################\n"

echo "Put user in docker group"
groupadd docker
usermod $(whoami) -G docker

echo -e "\n###################"
echo -e "##       S3      ##"
echo -e "###################\n"

read -p "Do you want to configure an S3 bucket? [yN]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "What is the bucket name?"
	read bucketname
	aws configure
	mkdir -p $bucketname
	aws s3 sync s3://$bucketname $bucketname
fi
