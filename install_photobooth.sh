#!/bin/bash

function install_package {
  apt-get install -y "$1"
}


apt-get update
install_package "gphoto2"
install_package "darktable"
install_package "photoprint"
install_package "qrencode"
install_package "imagemagick"
install_package "feh"
 
