# Setzt den Auslöse-Modus der Kamera auf die Fernbedienung
gphoto2 --set-config-index /main/capturesettings/capturemode=4

# Darstellung eines schwarzen Bildes im Vollbildmodus (vermutlich möchte niemand das Terminal sehen)
eog -f -w blackscreen.png &

# Generierung eines QRCodes
#qrencode -o qrcode.png -s 10 'URL: www.mach-mal-nen.de'

# Aktivierung des Tethering-Modus der Kamera und Warten auf Bilder
gphoto2 --capture-tethered --hook-script=test-hook.sh --filename="photo_booth-%Y%m%d-%H%M%S.%C" --force-overwrite
