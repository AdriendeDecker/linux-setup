#!/bin/bash

# Run this script as normal user NOT SUDO

# Install essential packages
cd ~
sudo apt update -qq

sudo apt install -yy gdebi \
  bleachbit \
  apt-transport-https \
  curl \
  wget \
  snapd \
  lsb-release \
  ca-certificates \
  gnupg \
  vlc

# Install dev tools
sudo apt install -yy git default-jre default-jdk
sudo apt install nodejs -yy
sudo snap install code --classic
sudo snap install discord
sudo snap install eclipse --classic
sudo snap install postman
sudo snap install flutter --classic
sudo snap install spotify

# Install Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -qq
sudo apt install brave-browser -yy

# Install Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# Fix timedate issues for dualboot (windows change hour after reboot from linux)
sudo timedatectl set-local-rtc 1

# Install new shell
# WARN: might need some user validations
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Install Howdy (windows hello for linux)
#sudo add-apt-repository ppa:boltgolt/howdy
#sudo apt update -qq
#sudo apt install howdy -yy

# Install Docker and Docker-Compose
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq
sudo apt-get install docker-ce docker-ce-cli containerd.io -yy
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER

# Install Steam
sudo add-apt-repository multiverse
sudo apt update -qq
sudo apt install steam -yy

# Install OBS
sudo apt install ffmpeg -yy
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update -qq
sudo apt install obs-studio -yy

# Add shorcuts in .bachrc
echo "alias gss='git status --short'" >> /home/adrien/.bashrc
echo "alias gcm='git commit -m'" >> .bashrc
echo "alias gpl='git pull'" >> .bashrc
echo "alias gph='git push'" >> .bashrc
echo "alias gaa='git add --all'" >> .bashrc
echo "alias nrd='npm run dev'" >> .bashrc
echo "alias ns='npm start'" >> .bashrc
echo "alias nrt='npm run test'" >> .bashrc

green=`tput setaf 2`
echo "${green}---------------------"
echo "${green}| Install completed |"
echo "${green}---------------------"
echo "\n don't forget to restart after install"
