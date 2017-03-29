#!/bin/bash

if [ `/usr/bin/id -u` != "0" ]; then
  printf "\x1b[31m %s \\x1b[0m %s \n" "Failed" "- you must be root to run this script"
  exit 1
fi

if [ -f "basic" ] 
then
  source basic
else
  printf "\x1b[31m %s \\x1b[0m %s \n" "Failed" "- basic function not found"
  exit 1
fi

echo "***************************************"
echo "*          Start Script               *"
echo "***************************************"

log "apt-get update"
apt-get update >/dev/null 2>/dev/null
check $?

install_package "gphoto2"
install_package "darktable"
install_package "photoprint"
install_package "qrencode"
install_package "imagemagick"
install_package "feh"
#install_package "apache2"

createDir "slideshow"

echo "***************************************"
echo "*          Script finished             *"
echo "***************************************"
