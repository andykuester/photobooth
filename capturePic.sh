#!/bin/bash
C="...................................................."
function log {
  printf "%.50s" "$1 $C"
  printf "%.50s" "$1 $C" >> logfile
}

function printOK {
  printf "[ %s ]  \n" "OK"
  printf "[ %s ]  \n" "OK" >> logfile
}

function printFailed {
  printf "[\x1b[31m %s \\x1b[0m] \n" "FAILED"
  printf "[\x1b[31m %s \\x1b[0m] \n" "FAILED" >> logfile
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
gphoto2 --set-config /main/capturesettings/capturemode="1" >/dev/null 2>error
check $?


# Darstellung eines schwarzen Bildes im Vollbildmodus (vermutlich möchte niemand das Terminal sehen)
#eog -f -w blackscreen.png &

# Generierung eines QRCodes
#qrencode -o qrcode.png -s 10 'URL: www.mach-mal-nen.de'

# Aktivierung des Tethering-Modus der Kamera und Warten auf Bilder
log "activate tethered mode"
check 0
gphoto2 --capture-tethered --hook-script=test-hook.sh --filename="slideshow/photo_booth-%Y%m%d-%H%M%S.%C" --force-overwrite >>/dev/null 2>error

