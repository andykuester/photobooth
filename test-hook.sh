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
	# nach abgeschlossenem Download der Bilder
	TYPE=$(file --mime-type -b "$ARGUMENT") # Typ des Bildes herausfinden
	
        if [ "$TYPE" = 'image/jpeg' ]; then 
           
           # save img into dropbox folder
           dropbox="/home/andy/Dropbox/002_privat/001_Dani&Andy/001_hochzeit/photobooth"
           if [ -d "$dropbox" ];then
               log "copy $ARGUMENT to dropbox"
               cp "$ARGUMENT" "$dropbox/" >/dev/null 2>error
               check $?
               log "chown image"
               chown andy:andy "$dropbox/$ARGUMENT"
               check $?
               log "chmod image"
               chmod 775 "$dropbox/$ARGUMENT"
               check $?
           fi
           folder="/opt/photobooth/slideshow"
           log "check slideshow folder"
           if [ -d "$folder" ];then
              check 0
              log "move $ARGUMENT to slideshow"
              mv "$ARGUMENT" "/opt/photobooth/slideshow/"
              check $?

           else
              check 1
           fi
           ./startSlideshow.sh "slideshow/$ARGUMENT" &
           
        fi


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
