# raspberry-pi-setup
raspberry pi auto setup script

## Install Package
### Raspbian Strech
- JAPANESE environment(fonts-vlgothic)
- Editor(vim,vim-gtk)
- Terminal(gnome-terminal)
- Pertition tool(gparted)
- Virtual Terminal(screen)

### Raspbian Strech Lite
- Editor(vim)
- Virtual Terminal(screen)

## Setting
### Raspbian Strech
- Custom `/boot/config.txt`

# Preparation
- Make SD disk of Raspbian 
- Insert SD disk to Raspberry Pi
- Network Enable (Ether or WiFi)
- Raspberry Pi power on
- Install Git

## Git installation
```sh
$ sudo apt-get update
$ sudo apt-get -y install git
```

# Run script
At first Execute following commands for clone repository:
```sh
$ cd
$ git clone https://github.com/mitsu8964/raspbian-setting
$ cd raspbian-setting
```


## Raspbian Strech setup case
Execute following commands(last command takes about half an hour):
```sh
$ ./setup-raspbian-stretch.sh
```

## Shrink Raspbian Strech
Execute following commands if you want to shrink raspbian:
```sh
$ ./shrink-raspbian-stretch.sh
```

## Raspbian Strech Lite setup case
Execute following commands(last command takes about half an hour):
```sh
$ ./setup-raspbian-strech-lite.sh
```
## Reboot
After setup, please reboot by executing following command:
```sh
$ sudo shutdown -r now
```

Raspberry Pi setup is done!
