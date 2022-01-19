# Ubuntu OS
#install GIT CURL unzip  
apt-get install git curl unzip -y 
apt-get install -y build-essential gcc make perl dkms g++
# install the libtool dependencies
apt install libtool libltdl-dev

#Install Docker and Docker-compose
cd ~
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_17.12.1~ce-0~debian_amd64.deb
dpkg -i docker-ce_17.12.1~ce-0~debian_amd64.deb

groupadd docker
usermod -aG docker blockchain

curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
cd /usr/local/bin
chmod +777 docker-compose

#Install Node and npm 
https://nodejs.org/en/blog/release/v14.17.6/
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
apt-get install -y nodejs

#Install GO
wget https://dl.google.com/go/go1.12.linux-amd64.tar.gz
tar -xvf go1.12.linux-amd64.tar.gz
mv go /usr/local

#Install Fabric samples and Docker Images 
cd ~
curl -sSL http://bit.ly/2ysbOFE | bash -s -- 2.2.3 1.4.1 0.4.15
#reboot VM
reboot
# Install VS code 
https://code.visualstudio.com/updates/v1_61
# Install IBM Blockchain Platform plugin 
https://marketplace.visualstudio.com/items?itemName=IBMBlockchain.ibm-blockchain-platform


# Functions to and lines be added to .bashrc file under ~/.bashrc
export GOROOT=/usr/lib/go
export GOPATH=/home/blockchain/go
export PATH=$PATH:$GOROOT/bin


function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

function docker-rm()
{
docker rm -f $(docker ps -aq)
docker system prune -f
docker volume rm $(docker volume ls -q)
docker rm $(docker ps -aq)
}
