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
sudo apt-get install -y vim git gcc g++ cmake make gedit ssh gdb gdbserver gdb-multiarch tmux xclip python3 curl wget glibc-doc manpages-posix manpages-posix-dev htop filezilla net-tools perl libc6-dbg yara hydra hydra-gtk tree gimp patchelf
sudo apt-get install -y imagemagick nautilus-image-converter
sudo apt-get install -y binutils file wget rpm2cpio cpio zstd build-essential
sudo apt-get install -y ruby-full ruby-dev rubygems build-essential zlib1g-dev
sudo apt-get install -y gnome-tweaks gnome-tweaks cpu-checker
sudo apt-get install -y php php-cgi php-cli php-common php-mysql mysql-server
sudo apt-get install -y binwalk nmap valgrind
sudo apt-get install -y qemu qemu-user virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

#sticky notes
# http://www.webupd8.org/2012/11/pin-notes-on-your-desktop-with.html
# https://askubuntu.com/questions/245019/what-alternatives-for-sticky-notes-are-available
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install indicator-stickynotes

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
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo docker run hello-world	# Verify that docker is correctly installed
sudo groupadd docker
sudo usermod -aG docker $USER

# miscellaneous
cd ~

mkdir -p bin
cp -r miscellaneous/bin/binaries bin/binaries
cp miscellaneous/vim/.vimrc .
cp miscellaneous/tmux/.tmux.conf.v3.0a .tmux.conf
cp miscellaneous/gdb/.gdbinit .
cp -r miscellaneous/bin/* bin/
ln -s $HOME/bin/binaries/remove-blank-pages.sh $HOME/bin/pdf-rm-blanks

sudo snap install --classic slack
sudo snap install --classic skype
sudo snap install discord
sudo snap install spotify
sudo snap install --classic code
sudo snap install clion --classic
sudo snap install phpstorm --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install pycharm-professional --classic
sudo snap install webstorm --classic

# Configure git to store username and password
git config --global credential.helper store

#numpad that works like windows, i.e. shift+home to select whole line, etc.
# sudoedit /etc/default/keyboard
# Change `XKBOPTIONS=""`
# to `XKBOPTIONS="numpad:microsoft"`
# Then run `sudo dpkg-reconfigure keyboard-configuration` and reboot

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

#ruby gems
echo '# Install Ruby Gems to ~/.gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/.gems"' >> ~/.bashrc
echo 'export PATH="$HOME/.gems/bin:$PATH"' >> ~/.bashrc

#go
# echo '' >> .bashrc
# echo '#go language' >> .bashrc
# echo 'export GOROOT="/home/$USER/bin/binaries/go"' >> .bashrc
# echo 'export GOPATH="/home/$USER/bin/binaries/gows"' >> .bashrc
# echo 'export PATH="$PATH:$GOROOT/bin"' >> .bashrc
# echo 'export PATH="$PATH:$GOPATH/bin"' >> .bashrc

#pyenv
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git

curl https://pyenv.run | bash

echo '' >> .bashrc
echo '#pyenv' >> .bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> .bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> .bashrc
echo 'eval "$(pyenv init -)"' >> .bashrc
# echo 'eval "$(pyenv init --path)"' >> .bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> .bashrc

echo '' >> .bashrc
echo 'export PATH="$PATH:/home/$USER/bin"' >> .bashrc

source ~/.bashrc
pyenv install 3.10.5
pyenv global  3.10.5
pip install --upgrade pip
pip install ipython pylint rope matplotlib tqdm

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
pip install --upgrade pip
pip install angr
pip install angr-management
pip install pylint ipython matplotlib
pyenv deactivate

# one_gadget
gem install one_gadget
gem install jekyll bundler
gem install seccomp-tools

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

#pwninit
cargo install pwninit

#gdb-gef
pip install capstone unicorn keystone-engine ropper
wget -q -O "$HOME/bin/binaries/.gdbinit-gef.py" https://raw.githubusercontent.com/hugsy/gef/main/gef.py

# hyper & hyperpwn
cd ~/Downloads
wget https://releases.hyper.is/download/deb -O hyper.deb
sudo apt-get -y install gconf-service gconf-service-backend gconf2 gconf2-common libappindicator1 libdbusmenu-gtk4 libgconf-2-4
sudo dpkg -i hyper.deb
hyper i hyperinator
hyper i hyperpwn
cd -

#libc-database
git clone https://github.com/niklasb/libc-database.git ~/bin/binaries/libc-database
sudo apt-get install -y binutils file wget rpm2cpio cpio zstd jq
cd ~/bin/binaries/libc-database
./get all
cd -

#sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/bin/binaries/sqlmap

#ghidra
sudo apt-get install -y default-jre default-jdk
echo ''
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> .bashrc
# Install ghidra in $HOME/bin/ghidra
ln -s $HOME/bin/binaries/ghidra_10.1.4_PUBLIC/ghidraRun $HOME/bin/ghidra


## VS Code Settings
#TL;DR: 
#0.) Open Visual Studio Code and install the extension Settings Sync
#1.) Shift + Alt + D
#2.) Paste Gist ID: 48b2d2509bb867a40e3c080a8983823b
#3.) Press Enter
#4.) Ctrl + P ---> ">sync" ---> "Advanced" ---> toggle auto-download and auto-upload

#Burp
sudo apt-get install -y libcanberra-gtk-module
# Download openjdk14+36
cd ~/Downloads
wget https://download.java.net/java/GA/jdk14/076bab302c7b4508975440c56f6cc26a/36/GPL/openjdk-14_linux-x64_bin.tar.gz
tar -xzf openjdk-14_linux-x64_bin.tar.gz
sudo mv jdk-14 /usr/lib/jvm/java-14-openjdk-amd64
cd /usr/lib/jvm
sudo chown -R root:root java-14-openjdk-amd64
sudo ln -s java-14-openjdk-amd64 java-1.14.0-openjdk-amd64
ln -s /usr/lib/jvm/java-1.14.0-openjdk-amd64/bin/java $HOME/bin/java14
cd ~
java14 -version # verify

# Install Burp now
ln -s $HOME/bin/binaries/burpsuite-pro-v2021.8.4/run.sh $HOME/bin/burp
# Export Certificate in DER format: ~/.BurpSuite/burp-ca.der

# FireFox fane-pentest profile
# Addon: FoxyProxy
# Addon: Cookie Quick Manager
# Import CA certificate: ~/.BurpSuite/burp-ca.der

# Also install Chrome


