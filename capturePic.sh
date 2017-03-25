#!/bin/bash

if [ -f "basic" ]
then
  source basic
else
  printf "\x1b[31m %s \\x1b[0m %s \n" "Failed" "- basic function not found"
  exit 1
fi

# Reset Error and Logfile
printf "" > logfile
printf "" > error


echo "******    START PHOTOBOOTH     ******"

log "Search old process"
#Alle laufende Prozesse von gphoto beenden
process=($(ps -AH | grep "gphoto" | awk '{print $1}'))
check $?
countProcess=${#process[@]}
if [ $countProcess -ne 0 ]
then
  for p in ${process[@]}
  do
    log "kill process $p"
    kill $p
    check $?
  done
fi


# Setzt den Kamera Einstellungen 

log "set camera capturemode "
gphoto2 --set-config /main/capturesettings/capturemode="0" >/dev/null 2>error
check $?


# Darstellung eines schwarzen Bildes im Vollbildmodus (vermutlich möchte niemand das Terminal sehen)
log "diaplay black screen"
eog -f -w blackscreen.png & >logfile 2>error
check $?

# Generierung eines QRCodes
#qrencode -o qrcode.png -s 10 'URL: www.mach-mal-nen.de'

# Aktivierung des Tethering-Modus der Kamera und Warten auf Bilder
log "activate tethered mode"
check 0
gphoto2 --capture-tethered --hook-script=test-hook.sh --filename="slideshow/photo_booth-%Y%m%d-%H%M%S.%C" --force-overwrite 2>error 

