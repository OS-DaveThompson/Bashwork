#!/bin/bash

#----------------------------------------------------------------
#--- Script explanation
#---
echo "|---------------------------------------------------------------------------------"
echo "Olympic Softworks script to prepair Ubuntu 22.04 server for Docker deployment use."
echo 
echo "You will be given an opportunity to update/upgrade and reboot if needed before"
echo "installation of the docker foundation is deployed."
echo
echo "Begin Script"
echo "---"
echo "---"
echo "---"
#================================================================

#----------------------------------------------------------------
#--- Update/Upgrade cycle?
#---
read -p "Run update/upgrade cycle?  (y/N) " yN
    case $yN in
        [Yy] ) echo;
            echo "Selected: Perform update";
            echo;
            apt update;
            apt upgrade -y;;
         * ) echo;
            echo "Selected: No update";
            echo;;
    esac
#================================================================

#----------------------------------------------------------------
#--- Reboot?
#---
read -p "Does the machine neet to reboot?  (y/N) " yN
    case $yN in
        [Yy] ) echo;
            echo "Selected: Rebooting";
            echo;
            shutdown -r now;;
         * ) echo; 
            echo "Selected: No reboot";
            echo;;
    esac
#================================================================

#----------------------------------------------------------------
#--- Start by removing any previous installed docker components
#---
echo
echo "#================================================================"
echo "# 1) Remove prior docker and related components"
echo "# 2) Perform Update to refresh app-cache"
echo "# 3) Install latest secure transport crypto and related functions"
echo "#================================================================"
echo
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
#================================================================

#----------------------------------------------------------------
#--- Set up secure docker repositories
#---
echo
echo "#================================================================"
echo "# 1) Install crypto keyring"
echo "# 2) Download docker key and put it into the keyring"
echo "# 3) Secure permissions on docker key"
echo "# 4) Create repository referense"
echo "#================================================================"
echo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#================================================================

#----------------------------------------------------------------
#--- Install docker and related components
#---
echo
echo "#================================================================"
echo "# 1) Perform update to refresh app-cache"
echo "# 2) APT install docker and components"
echo "#================================================================"
echo
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin
#================================================================

#----------------------------------------------------------------
#--- Provide version of docker installed 
#---
echo
echo "#================================================================"
echo "# The following is the version of docker installed is"
echo "#"
echo -n "# "
docker --version
echo "#================================================================"
echo
#================================================================

#----------------------------------------------------------------
#--- For security and workflow, add non-admin access to docker
#---
echo
echo
echo
echo "Please give a username to add to the docker group, so the"
echo "user can give docker commands without needing admin privilege."
echo
read -p "Username to become docker admin " dkr
usermod -aG docker $dkr

