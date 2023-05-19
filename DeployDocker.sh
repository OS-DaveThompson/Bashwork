!#/bin/bash
#
echo
    read -p -r "Run update/upgrade cycle?  (Yy/Nn) " yn
    case $yn in
        [Yy] ) echo "Excellent!";
            apt update;
            apt upgrade -y;;
        [Nn] ) echo "Alright, lets try again";
            echo;
            echo;;
    esac






    #!/bin/bash

#----------------------------------------------------------------
#---    Script explanation
#---
echo "Olympic Softworks script to prepair Ubuntu 22.04 server for Docker deployment use."
echo
echo "You will be given an opportunity to update/upgrade and reboot if needed before"
echo "installation of the docker foundation is deployed."
echo
echo "Begin Script"
echo
echo

#----------------------------------------------------------------
#--- Update/Upgrade cycle?  Reboot?
#---
read -p -r "Run update/upgrade cycle?  (Yy/Nn) " yn
    case $yn in
        [Yy] ) echo "Updating!";
            apt update;
            apt upgrade -y;;
        [Nn] ) echo "Alright, no updates!";
            echo;
            echo;;
    esac
read -p -r "Reboot?  (Yy/Nn) " yn
    case $yn in
        [Yy] ) echo "Rebooting!";
            shutdown -r now;;
        [Nn] ) echo "Alright, not rebooting!";
            echo;;
    esac
#---

#----------------------------------------------------------------
#---    Start with installing from vendor repos
#---
#---
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release

#----------------------------------------------------------------
#---    Set up secure docker repositories
#---
#---
sudo apt-get -y remove docker docker-engine docker.io containerd runc

sudo apt-get update
sudo apt-get -y install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


