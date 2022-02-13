#!/bin/bash

# Install docker

sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Add user to docker group

sudo usermod -aG docker ${USER}

# Configure docker daemon to listen external port

DOCKER_IP=`awk '/inet / && $2 != "127.0.0.1"{print $2}' <(ifconfig wlan0)`

echo \
"[Service]" \
"ExecStart=" \
"ExecStart=/usr/bin/dockerd" | sudo tee /etc/systemd/system/docker.service.d/docker.conf

echo \
"{" \
"    \"hosts\": [\"unix:///var/run/docker.sock\", \"tcp://${DOCKER_IP}:2375\"]"
"}" | sudo tee /etc/docker/daemon.json

# Enable docker system service

sudo systemctl enable docker
