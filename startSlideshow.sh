#!/bin/bash

if [ -f "basic" ]
then
  source basic
else
  printf "\x1b[31m %s \\x1b[0m %s \n" "Failed" "- basic function not found"
  exit 1
fi

log "Search old process"
#Alle laufende Prozesse von gphoto beenden
process=($(ps -AH | grep "feh" | awk '{print $1}'))
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




log "start slideshow"
check 0
# Anzeige des aktuell geknipsten Bildes für 3 Sekunden, danach Start der Slideshow
feh -Y -F --cycle-once -D3 ./$1 && feh -Y -z -F -R2 -D2 slideshow/*.JPG
# Option -F steht für "Vollbild", --cycle-once sorgt dafür, dass das Programm nach der eingestellten Anzeigedauer von -D 3 (3 Sekunden) nicht neu gestartet wird. Ist die Ausführung des ersten feh-Aufrufs beendet, folgt der zweite Aufruf mit allen jpg-Bilder im Unterordner slideshow. -R 2 bedeutet, dass alle 2 Sekunden die Dateiliste neu geladen wird, so dass auch neu hinzugefügte Bilder angezeigt werden.

