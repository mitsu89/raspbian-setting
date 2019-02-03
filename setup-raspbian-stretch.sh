#!/bin/bash

# update package and firmware
update_package(){
	# update package
	sudo apt-get update
	sudo apt-get -y upgrade

	# update firmware
	sudo rpi-update
}

# install apt-get package
apt_get_install(){
	# setup JAPANESE environment
	sudo apt-get install -y fonts-vlgothic
	#sudo apt-get install -y ibus-mozc

	#sudo apt-get install -y tightvncserver

	# install editor
	sudo apt-get install -y vim
	sudo apt-get install -y vim-gtk

	# install gnome-terminal
	sudo apt-get install -y gnome-terminal

	# install partition setup tool
	sudo apt-get install -y gparted

    # install camera package
	sudo apt-get install -y python-picamera
	sudo apt-get install -y python3-picamera

	# install virtual terminal
	sudo apt-get install -y screen

	# install screen capture tool
	sudo apt-get install -y scrot
}

# setup dotfiles
setup_dotfiles(){
	sudo cp ./dotfiles/.bashrc ~/.bashrc
	sudo cp ./dotfiles/config.txt /boot/config.txt
	sudo cp ./dotfiles/lxpolkit.desktop /etc/xdg/autostart/lxpolkit.desktop

	sudo cp ./dotfiles/vncboot /etc/init.d/vncboot
	sudo update-rc.d -f lightdm remove
	sudo update-rc.d vncboot defaults
}

START_TIME=`date +%s`

# change directory here
cd `dirname $0`

update_package
apt_get_install
#setup_dotfiles

END_TIME=`date +%s`

SS=`expr ${END_TIME} - ${START_TIME}`
HH=`expr ${SS} / 3600`
SS=`expr ${SS} % 3600`
MM=`expr ${SS} / 60`
SS=`expr ${SS} % 60`

echo "Total Time: ${HH}:${MM}:${SS} (h:m:s)"

#echo "Input password for vnc"
#sudo /etc/init.d/vncboot start

echo "Please reboot"
