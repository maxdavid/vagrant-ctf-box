#!/bin/bash

HOMEDIR=/home/$USER

# Updates
sudo apt -y update

sudo apt -y install python3-pip
sudo apt -y install tmux
sudo apt -y install gdb gdb-multiarch
sudo apt -y install unzip
sudo apt -y install foremost
sudo apt -y install ipython
sudo apt -y install python2.7 python-pip python-dev git libssl-dev libffi-dev
sudo apt -y install vim curl 

# Ptrace enable
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope

# Install virtualenvwrapper
pip install virtualenvwrapper
export WORKON_HOME=$HOMEDIR/.virtualenvs
export PROJECT_HOME=$HOMEDIR/Devel
source /usr/local/bin/virtualenvwrapper.sh

# Switch to tools dir for installation
cd $HOMEDIR
mkdir -p tools
cd tools

# Install pwndbg
mkvirtualenv pwn
pip install --upgrade pwntools
deactivate

# Install pwndbg
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

# Install radare2
cd ~
git clone https://github.com/radare/radare2
cd radare2
./sys/install.sh

# Install binwalk
cd ~
git clone https://github.com/devttys0/binwalk
cd binwalk
sudo python setup.py install
sudo apt -y install squashfs-tools
sudo apt -y install python-lzma

# Install Firmware-Mod-Kit
sudo apt -y install git build-essential zlib1g-dev liblzma-dev python-magic
cd ~/tools
wget https://firmware-mod-kit.googlecode.com/files/fmk_099.tar.gz
tar xvf fmk_099.tar.gz
rm fmk_099.tar.gz
cd fmk_099/src
./configure
make

# Install american-fuzzy-lop
sudo apt -y install clang llvm
cd $HOMEDIR/tools
wget --quiet http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz
tar -xzvf afl-latest.tgz
rm afl-latest.tgz
wget --quiet http://llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
xz -d clang*
tar xvf clang*
cd clang*
cd bin
export PATH=$PWD:$PATH
cd ../..
(
  cd afl-*
  make
  # build clang-fast
  (
    cd llvm_mode
    make
  )
  sudo make install

  # build qemu-support
  sudo apt -y install libtool automake bison libglib2.0-dev
  ./build_qemu_support.sh
)

# Install 32 bit libs
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt -y install libc6-dev-i386

# Install r2pipe
pip install r2pipe

# Install ROPGadget
git clone https://github.com/JonathanSalwan/ROPgadget
cd ROPgadget
sudo python setup.py install

# Forensics tools
sudo apt -y install p7zip-full vbindiff
sudo apt -y install imagemagick
sudo apt -y install zbar-tools

