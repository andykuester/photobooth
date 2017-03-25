#!/bin/bash
C="..........................................."

if [ `/usr/bin/id -u` != "0" ]; then
  printf "\x1b[31m %s \\x1b[0m %s \n" "Failed" "- you must be root to run this script"
  exit 1
fi


function install_package {

  printf "%.40s" "install $1 $C"
  apt-get install -y "$1" >>/dev/null 2>/dev/null
  check $?

}
function check {

  if [ $1 -eq 0 ]
  then
     printOK
  else
     printFailed
     exit 1
  fi
}

function createDir {
  
  printf "%.40s" "create dir $1 $C"
  if [ -d "$1" ]
  then
    printOK
  else
    mkdir "$1"
    check $?
  fi

}

function printOK {
  printf "[ %s ]  \n" "OK"
}

function printFailed {
  printf "[\x1b[31m %s \\x1b[0m] \n" "FAILED"
}

echo "***************************************"
echo "*          Start Script               *"
echo "***************************************"

printf "%.40s" "apt-get update $C"
apt-get update >/dev/null 2>/dev/null
check $?

install_package "gphoto2"
install_package "darktable"
install_package "photoprint"
install_package "qrencode"
install_package "imagemagick"
install_package "feh"


createDir "slideshow"

echo "***************************************"
echo "*          Script finished             *"
echo "***************************************"
