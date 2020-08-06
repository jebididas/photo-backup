#!/bin/bash

# Colourise the output
RED='\033[0;31m'        # Red
GRE='\033[0;32m'        # Green
YEL='\033[1;33m'        # Yellow
NCL='\033[0m'           # No Color

file_specification() {
        FILE_NAME="$(basename "${entry}")"
        DIR="$(dirname "${entry}")"
        NAME="${FILE_NAME%.*}"
        EXT="${FILE_NAME##*.}"
        SIZE="$(du -sh "${entry}" | cut -f1)"

        printf "%*s${GRE}%s${NCL}\n"                    $((indent+4)) '' "${entry}"
        printf "%*s\tFile name:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        printf "%*s\tDirectory:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$DIR"
        printf "%*s\tName only:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$NAME"
        printf "%*s\tExtension:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$EXT"
        printf "%*s\tFile size:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$SIZE"


               
        # if [ $EXT == "json" ]; then
        #     printf "%*s\t--- SKIPPING --- File name:\t${RED}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        #     echo $FILE_NAME >> skipped.txt
        # elif [ $EXT == "jpg" ] || [ $EXT == "jpeg" ]; then
        #     printf "%*s\t--- IMAGE --- File name:\t${GRE}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        #     b2 upload_file j-google-photos-backup "$DIR"/"$FILE_NAME" "$FILE_NAME"
        #     echo $FILE_NAME >> uploaded.txt
        # else
        #     printf "%*s\t--- NOT SURE --- File name:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        #     echo $FILE_NAME >> not_sure.txt
        # fi

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

walk() {
        local indent="${2:-0}"
        printf "\n%*s${RED}%s${NCL}\n\n" "$indent" '' "$1"
        # If the entry is a file do some operations
        for entry in "$1"/*; do [[ -f "$entry" ]] && file_specification; done
        # If the entry is a directory call walk() == create recursion
        for entry in "$1"/*; do [[ -d "$entry" ]] && walk "$entry" $((indent+4)); done
}

# If the path is empty use the current, otherwise convert relative to absolute; Exec walk()
[[ -z "${1}" ]] && ABS_PATH="${PWD}" || cd "${1}" && ABS_PATH="${PWD}"
walk "${ABS_PATH}"      
echo 