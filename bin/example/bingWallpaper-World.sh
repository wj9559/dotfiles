#!/bin/sh

fetchedFrom='BING'

# en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ, en-CA.
mkt="en-US"

# The idx parameter determines where to start from. 0 is the current day,
# 1 the previous day, etc.
idx="0"

# Set picture options
# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,spanned
picOpts="zoom"

# resolution of picture:
# _1920x1200.jpg _1366x768.jpg _1280x720.jpg _1024x768.jpg
# note: the highest resolution has a "bing" watermark
# its annoying -- but I suppose they aleast provide an xml.
# the lower quality pix are untagged.
picRes="_1366x768.jpg"

# $saveDir is used to set the location where Bing pics of the day
# are stored.  $HOME holds the path of the current user's home directory
# $procDir will store images after processed by Python script. These are
# the pictures that will end up on the desktop
saveDir='$HOME/Pictures/Wallpaper'
procDir='$HOME/Pictures/backgrounds/Process'

# Create saveDir if it does not already exist
mkdir -p $saveDir
mkdir -p $procDir

# reset saveDir and procDir -- later code assumes saveDir and procDir end in '/'
saveDir=$saveDir'/'
procDir=$procDir'/'

# $xmlURL is needed to get the xml data from which
# the relative URL for the Bing pic of the day is extracted
xmlURL="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=$idx&n=1&mkt=$mkt"

# parse picture URL
picURL='www.bing.com'$(curl -s $xmlURL | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$picRes

# parse author
picAuth=$(curl -s $xmlURL | grep -oP "©(.*)</copyright>" | cut -d " " -f 1 --complement | cut -d "/" -f 1)

# parse author association
picAssc=$(curl -s $xmlURL | grep -oP "<copyright>(.*)</copyright>" | cut -d "/" -f 2 | cut -d ")" -f 1)

# parse caption
picCapt=$(curl -s $xmlURL | grep -oP "<copyright>(.*)</copyright>" | cut -d "(" -f 1 | cut -d ">" -f 2 | sed 's/ *$//g')

# $picName contains the filename of the Bing pic of the day
picName=$fetchedFrom'_'$(echo $picURL | rev | cut -d '/' -f 1 | rev)

# Download the Bing pic of the day
curl -s -o $saveDir$picName $picURL

# save caption, author, authorAssc, and source to picture metadata
# you'll need exiftool installed for this to run corrently
# if you want to make a wallpaper changer that loops through old photos, all info is saved with pic
# one way to recover the data: exiftool -Comment yug.png |cut -d ':' -f 2 | sed 's/ //'
# you'll need to parse the resultant string for all the relevant information
exiftool -q -overwrite_original -Comment="$fetchedFrom/$picCapt/$picAuth/$picAssc" $saveDir$picName

# How much transparency do you want on the box (0-255)?
alpha='148'

# The color of the box is fetched from Unity sidebar -- depricated, pass into python script if you wish
# boxcolor=$(xprop -root | grep _GNOME_BACKGROUND_REPRESENTATIVE_COLORS | cut -d "(" -f 3 | cut -d ")" -f 1)

# call python script to modify background image
python /home/yoshi/Desktop/yoshi/projects/bingBackgrounds/bingPaper_v1.0.py "$picName" "$picAuth" "$picAssc" "$picCapt" "$saveDir" "$procDir" "$alpha"

# wallpaper path
wallPath=$(echo $procDir$picName | sed 's/.jpg/.png/')

# Set the GNOME3 wallpaper
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri '"file://'$wallPath'"'

# Set the GNOME 3 wallpaper picture options
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options $picOpts

# send notification
notify-send "$picCapt" "$picAuth\n$picAssc" -i $saveDir$picName

exit 0
