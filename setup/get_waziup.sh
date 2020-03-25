#!/bin/bash
# This script downloads and installs the Wazigate 

WAZIUP_VERSION="V1.1"

#--------------------------------#

#Packages
sudo apt-get update
sudo apt-get install -y git

#--------------------------------#

#Downloading wazigate stuff
#Using HTTP makes us to clone without needing persmission via ssh-keys
git clone -b v1 https://github.com/Waziup/waziup-gateway.git waziup-gateway
cd waziup-gateway

sudo chmod a+x setup/install.sh

#--------------------------------#

sudo sed -i "s/^WAZIUP_VERSION=.*/WAZIUP_VERSION=$WAZIUP_VERSION/g" .env

#--------------------------------#

bash ./setup/install.sh

#--------------------------------#

sudo sed -i 's/^DEVMODE.*/DEVMODE=0/g' start.sh

#--------------------------------#

echo "Downloading the docker images..."
cd $WAZIUP_ROOT/
sudo docker-compose pull
echo "Done"

for i in {10..01}; do
	echo -ne "Rebooting in $i seconds... \033[0K\r"
	sleep 1
done
sudo reboot

exit 0
