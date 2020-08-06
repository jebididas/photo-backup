#!/bin/bash

# Colourise the output
RED='\033[0;31m'        # Red
GRE='\033[0;32m'        # Green
YEL='\033[1;33m'        # Yellow
NCL='\033[0m'           # No Color

find_duplicats() {

    # List all files, included duplicate versions    
    b2 ls --versions j-google-photos-backup > versions.txt

    # Take output file and sort, then print duplicated files
    sort versions.txt | uniq -d > duplicates.txt

    # Also look at file names matching something like this IMG_1213(1).jpg
    



    # Catch the not_sure items
    if [ $EXT == "json" ] || [ $EXT == "jpg" ] || [ $EXT == "jpeg" ] || [ $EXT == "txt" ] || [ $EXT == "json" ]; then
        printf "%*s\t--- SKIPPING --- File name:\t${RED}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        echo $FILE_NAME >> skipped2.txt
    elif [ $EXT == "png" ] || [ $EXT == "gif" ] ||  [ $EXT == "MOV" ] || [ $EXT == "mp4" ] || [ $EXT == "JPG" ] || [ $EXT == "JPEG" ]; then
        printf "%*s\t--- IMAGE --- File name:\t${GRE}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        b2 upload_file j-google-photos-backup "$DIR"/"$FILE_NAME" "$FILE_NAME"
        echo $FILE_NAME >> uploaded2.txt
    else
        printf "%*s\t--- NOT SURE --- File name:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        echo $FILE_NAME >> not_sure2.txt
    fi
}


# If the path is empty use the current, otherwise convert relative to absolute; Exec walk()
[[ -z "${1}" ]] && ABS_PATH="${PWD}" || cd "${1}" && ABS_PATH="${PWD}"
find_duplicats "${ABS_PATH}"      
echo 