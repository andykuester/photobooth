#!/bin/bash
if [ -f "basic" ]
then
  source basic
else
  printf "\x1b[31m %s \\x1b[0m %s \n" "Failed" "- basic function not found"
  exit 1
fi
self=$(basename $0)
case "$ACTION" in
    init)
	log "init hook-script"
	# exit 1 # non-null exit to make gphoto2 call fail
        check 0
	;;
    start)
        log "start hook-script"
        check 0	
	;;
    download)
        log "DOWNLOAD to $ARGUMENT"
		# nach abgeschlossenem Download der Bilder
	#	TYPE=$(file --mime-type -b "$ARGUMENT") # Typ des Bildes herausfinden
	check $?
      #  if [ "$TYPE" = 'image/tiff' ]; then # Falls es sich um ein War-Foto handelt ...
				#	./convertPicture.sh $ARGUMENT &
#        else 
       # fuer das jpg-Bild
	./startSlideshow.sh "$ARGUMENT" &
        disown
        #fi


	;;
    stop)
        log "STOP PHOTOBOOTH"
        check 0	
	;;
    *)
	echo "$self: Unknown action: $ACTION"
	;;
esac

exit 0
