#!/bin/bash
#
# Run: nikos@laptop:~$ ./fresh-start.sh
# Do NOT run with sudo
#

# Stop on failure
set -e

# Fix dual boot time issue: https://askubuntu.com/questions/169376/clock-time-is-off-on-dual-boot
sudo timedatectl set-local-rtc 1

sudo apt-get update
sudo apt-get install -y vim git gcc g++ cmake make gedit ssh gdb gdb-multiarch tmux xclip python3 curl wget glibc-doc manpages-posix manpages-posix-dev htop chromium-browser filezilla net-tools perl libc6-dbg ctags yara hydra hydra-gtk
sudo apt-get install -y binutils file wget rpm2cpio cpio zstd build-essential
sudo apt-get install -y ruby rubygems build-essential
sudo apt-get install -y gnome-tweaks gnome-tweak-tool cpu-checker
sudo apt-get install -y php php-cgi php-cli php-common php-mysql mysql-server
sudo apt-get install -y binwalk nmap valgrind
sudo apt-get install -y qemu virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

#kvm
#FIXME: Ensure that `kvm-ok` outputs: "INFO: /dev/kvm exists\nKVM acceleration can be used"
sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo adduser `id -un` libvirt
sudo adduser `id -un` kvm
virsh list --all #FIXME: Verify the output of this command which indicates if everything was successful
sudo apt-get install -y virt-manager

# wireshark
sudo apt-get install -y wireshark # Select that non-superusers should be able to capture packets
sudo adduser $USER wireshark

# Docker
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo 'Expected fingerprint: 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88'
sudo apt-key fingerprint 0EBFCD88
echo 'Press ENTER to continue or ^C to break'
read
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world	# Verify that docker is correctly installed

# miscellaneous
cd ~
git clone https://github.com/nikosChalk/miscellaneous.git

mkdir -p bin
cp miscellaneous/bin/binaries bin/binaries
cp miscellaneous/vim/.vimrc .
cp miscellaneous/tmux/.tmux.conf.v3.0a .tmux.conf
cp miscellaneous/gdb/.gdbinit .
cp miscellaneous/bin/* bin/
ln -s $HOME/bin/binaries/remove-blank-pages.sh $HOME/bin/pdf-rm-blanks

sudo snap install --classic slack
sudo snap install --classic skype
sudo snap install discord
sudo snap install --classic code
sudo snap install clion --classic
sudo snap install phpstorm --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install pycharm-professional --classic
sudo snap install webstorm --classic

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
pip install ipython pylint rope
pip install matplotlib

#pwntools
sudo apt-get -y install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
pip install --upgrade pwntools

#wheel
pip install wheel

#ropper
pip install capstone filebytes keystone-engine
pip install ropper

# pycryptodome, hashpumpy
pip install pycryptodome hashpumpy

# angr - https://angr.io/
pyenv virtualenv angr
pyenv activate angr
pip install angr
pip install angr-management
pip install pylint
pip install --upgrade pip
pyenv deactivate

# one_gadget
gem install one_gadget

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

# hyper & hyperpwn
cd ~/Downloads
wget https://releases.hyper.is/download/deb hyper.deb
sudo apt-get -y install gconf-service gconf-service-backend gconf2 gconf2-common libappindicator1 libdbusmenu-gtk4 libgconf-2-4
sudo dpkg -i hyper.deb
hyper i hyperinator
hyper i hyperpwn
cd -

#libc-database
git clone https://github.com/niklasb/libc-database.git ~/bin/binaries/libc-database
cd ~/bin/binaries/libc-database
./get all
cd -

#sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/bin/binaries/sqlmap

#checksec
git clone https://github.com/slimm609/checksec.sh.git ~/bin/binaries/checksec
ln -s $HOME/bin/binaries/checksec/checksec $HOME/bin/checksec

#ghidra
sudo apt-get install -y default-jre default-jdk
# Install ghidra in $HOME/bin/ghidra
#ln -s $HOME/bin/binaries/ghidra_9.1.2_PUBLIC/ghidraRun $HOME/bin/ghidra


## VS Code Settings
#TL;DR: 
#0.) Open Visual Studio Code and install the extension Settings Sync
#1.) Shift + Alt + D
#2.) Paste Gist ID: 48b2d2509bb867a40e3c080a8983823b
#3.) Press Enter
#4.) Ctrl + P ---> ">sync" ---> "Advanced" ---> toggle auto-download and auto-upload

#Burp
sudo apt-get install -y libcanberra-gtk-module
# Install Burp now
# Export Certificate in DER format: ~/.BurpSuite/burp-ca.der

# FireFox pen-tester profile
# Addon: FoxyProxy
# Addon: Cookie Quick Manager
# Import CA certificate: ~/.BurpSuite/burp-ca.der 
