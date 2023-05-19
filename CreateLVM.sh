echo 'Be sure to have the thumbdrive you want to use plugged in'
echo
echo 'This utility will use your hard drive and the thumb drive and'
echo 'install the LVM subsystem and create an LVM from both'
echo
sudo apt -q -y install lvm2
#
echo "The following volumes have been found on your system"
while true; do
    sudo fdisk -l | grep /dev/sd
echo
    echo
    echo 'Look for the /dev/sd result(s) from the previous command'
    echo
    read -p -r "How many volumes will be included? " num_volumes
    echo "Thank you!"
    echo
    read -p -r "Then the logical volume created will contain $num_volumes volumes?  (y/n/c) " yn
    case $yn in
        [Yy] ) echo "Excellent!";
            break;;
        [Nn] ) echo "Alright, lets try again";
            echo;
            echo;;
        [Cc] ) echo "Alright, cancelling script.";
            exit;;
    esac
    echo "Re-listing the volumes found"
done
#

for (( c=1; c<=$num_volumes; c++ ))
do
   read -p -r "What is volume #$c? " vol_element[$c]
   echo
   echo "Volume #$c is ${vol_element[$c]}"
   echo
done


read -p -r "What is the name for the Logical Volume?" vol_name
echo
echo "The name of the built volume group is to be $vol_name"
echo