#!/bin/bash

# This is for practicing the art of asking Y / N / C questions.
# Easily, consistently, usefully.


echo
echo '###>===---'
echo '######>======------'
echo '############>============------------'
echo '###|'
echo '###|   Security practice: Add new user with sudo privileges.'
echo "###|   Please enter password and sundry info when asked:"
echo "###|"
echo
    read -p "Do you wish to add a non-root admin user? Yn " yn
    if [[ "$yn" != "n" ]]
    then
        echo
        echo "Creating the new user."
        echo
        read -p "What is the username of the non-root admin user? " newusername
        read -p "What is teh password of the non-root admin user? " newuserpass
        echo
        echo "Setting up $newusername as a new non-root admin user."
        echo "Using $newuserpass as a password"
        sudo useradd -p "$newuserpass" "$newusername"
        sudo usermod -aG sudo $newusername
        echo
    else
        echo;
        echo "Very well, no user will be created";
        echo;
    fi
echo
echo "down to the main execution level now"
echo
