#!/bin/bash
#
# Run: nikos@laptop:~$ ./fresh-start.sh
# Do NOT run with sudo
#

# Stop on failure
set -e

sudo apt-get update
sudo apt-get install -y vim git gcc g++ cmake make gedit ssh gdb gdb-multiarch tmux xclip python3 curl wget glibc-doc manpages-posix manpages-posix-dev htop chromium-browser filezilla net-tools perl libc6-dbg ctags yara hydra hydra-gtk tree
sudo apt install imagemagick nautilus-image-converter
sudo apt-get install -y binutils file wget rpm2cpio cpio zstd build-essential
sudo apt-get install -y ruby rubygems build-essential
sudo apt-get install -y php php-cgi php-cli php-common php-mysql mysql-server
sudo apt-get install -y binwalk nmap valgrind


# wireshark
sudo apt-get install -y wireshark # Select that non-superusers should be able to capture packets
sudo adduser $USER wireshark

# Docker
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo docker run hello-world	# Verify that docker is correctly installed
sudo groupadd docker
sudo usermod -aG docker $USER


# Ubuntu specific
sudo apt-get install -y gnome-tweaks gnome-tweak-tool cpu-checker


# Custom binaries
cd ~

mkdir -p bin
cp -r miscellaneous/bin/binaries bin/binaries
cp miscellaneous/vim/.vimrc .
cp miscellaneous/tmux/.tmux.conf.v3.0a .tmux.conf
cp miscellaneous/gdb/.gdbinit .
cp -r miscellaneous/bin/* bin/
ln -s $HOME/bin/binaries/remove-blank-pages.sh $HOME/bin/pdf-rm-blanks

sudo snap install --classic code

echo '' >> .bashrc
echo '##### Automatic nikos installer #####' >> .bashrc

#pdfmerge
echo 'pdfmerge() { gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepre ss -sOutputFile=$@ ; }' >> .bashrc

#urlencode
echo 'alias urlencode='"'"'python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))"'"'" >> .bashrc 

#preferred editor
echo '' >> .bashrc
echo 'export VISUAL=vim' >> .bashrc
echo 'export EDITOR="$VISUAL"' >> .bashrc


#pyenv
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

curl https://pyenv.run | bash

echo '' >> .bashrc
echo '#pyenv' >> .bashrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> .bashrc
echo 'eval "$(pyenv init -)"' >> .bashrc
echo 'eval "$(pyenv init --path)"' >> .bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> .bashrc

echo '' >> .bashrc
echo 'export PATH="$PATH:/home/$USER/bin"' >> .bashrc

source ~/.bashrc
pyenv install 3.8.12
pyenv global  3.8.12
pip install --upgrade pip
pip install ipython pylint rope matplotlib


#pwntools
sudo apt-get -y install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
pip install wheel
pip install --upgrade pwntools

#ropper
pip install capstone filebytes keystone-engine
pip install ropper

# pycryptodome, hashpumpy
pip install pycryptodome hashpumpy

# angr - https://angr.io/
sudo apt-get install -y python3-dev libffi-dev build-essential
pyenv virtualenv angr
pyenv activate angr
pip install angr
pip install angr-management
pip install pylint ipython matplotlib
pip install --upgrade pip
pyenv deactivate

# one_gadget
sudo gem install one_gadget

#gdb-gef
pip install capstone unicorn keystone-engine ropper
wget -q -O "$HOME/bin/binaries/.gdbinit-gef.py" https://github.com/hugsy/gef/raw/master/gef.py

#sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/bin/binaries/sqlmap

#checksec
git clone https://github.com/slimm609/checksec.sh.git ~/bin/binaries/checksec
ln -s $HOME/bin/binaries/checksec/checksec $HOME/bin/checksec

#ghidra
sudo apt-get install -y default-jre default-jdk
# Install ghidra in $HOME/bin/ghidra
#ln -s $HOME/bin/binaries/ghidra_10.1.1_PUBLIC/ghidraRun $HOME/bin/ghidra


## VS Code Settings
#0.) Open Visual Studio Code and install the extension Settings Sync
#1.) Shift + Alt + D
#2.) Paste Gist ID: 48b2d2509bb867a40e3c080a8983823b

#Burp
## See fresh-start.sh






