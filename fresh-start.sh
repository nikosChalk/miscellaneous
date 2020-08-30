#!/bin/bash
sudo apt-get update
sudo apt-get install vim git gcc g++ cmake make gedit ssh gdb tmux xclip python3 curl wget
sudo apt-get install gnome-tweaks gnome-tweak-tool

cd ~
git clone https://github.com/nikosChalk/miscellaneous.git

mkdir -p bin/binaries
cp miscellaneous/vim/.vimrc .
cp miscellaneous/tmux/.tmux.conf.v3.0a .tmux.conf
cp miscellaneous/gdb/.gdbinit .
cp miscellaneous/bin/* bin/

sudo snap install --classic code
sudo snap install --classic slack
sudo snap install discord
sudo snap install clion --classic

echo '' >> .bashrc
echo '##### Automatic nikos installer #####' >> .bashrc

#pdfmerge
echo 'pdfmerge() { gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepre ss -sOutputFile=$@ ; }' >> .bashrc

#preferred editor
echo '' >> .bashrc
echo 'export VISUAL=vim' >> .bashrc
echo 'export EDITOR="$VISUAL"' >> .bashrc

#go
echo '' >> .bashrc
echo '#go language' >> .bashrc
echo 'export GOROOT="/home/$USER/bin/binaries/go"' >> .bashrc
echo 'export GOPATH="/home/$USER/bin/binaries/gows"' >> .bashrc
echo 'export PATH="$PATH:$GOROOT/bin"' >> .bashrc
echo 'export PATH="$PATH:$GOPATH/bin"' >> .bashrc

#pyenv
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

curl https://pyenv.run | bash

echo '' >> .bashrc
echo '#pyenv' >> .bashrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> .bashrc
echo 'eval "$(pyenv init -)"' >> .bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> .bashrc

echo '' >> .bashrc
echo 'export PATH="$PATH:/home/$USER/bin"' >> .bashrc

source ~/.bashrc
pyenv install 3.8.5
pyenv global  3.8.5
pip install --upgrade pip

#pwntools
sudo apt-get install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
pip install --upgrade pwntools

#wheel
pip install wheel

#ropper
pip install capstone filebytes keystone-engine
pip install ropper

#gdb-gef
pip install capstone unicorn keystone-engine ropper
wget -q -O "$HOME/bin/binaries/.gdbinit-gef.py" https://github.com/hugsy/gef/raw/master/gef.py

#gdb-peda
git clone https://github.com/longld/peda.git ~/bin/binaries/peda

#gdb-pwndbg
git clone https://github.com/pwndbg/pwndbg ~/bin/binaries/pwndbg
cd ~/bin/binaries/pwndbg
./setup.sh --with-python=$HOME/.pyenv/shims/python
cd -

#sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/bin/binaries/sqlmap

#checksec
git clone https://github.com/slimm609/checksec.sh.git ~/bin/binaries/checksec
ln -s $HOME/bin/binaries/checksec/checksec $HOME/bin/checksec

#ghidra
#ln -s $HOME/bin/binaries/ghidra_9.1.2_PUBLIC/ghidraRun $HOME/bin/ghidra


## VS Code Settings
#TL;DR: 
#0.) Open Visual Studio Code and install the extension Settings Sync
#1.) Shift + Alt + D
#2.) Paste Gist ID: 48b2d2509bb867a40e3c080a8983823b
#3.) Press Enter
#4.) Ctrl + P ---> ">sync" ---> "Advanced" ---> toggle auto-download and auto-upload

