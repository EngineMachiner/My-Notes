#!/bin/bash
set -e

TARGET='';         if [ -d "Appearance" ]; then TARGET="Appearance/"; fi      

DIRECTORY="My-Notes"


# Clone repository.

REPOSITORY="https://github.com/EngineMachiner/My-Notes.git"

git clone "$REPOSITORY" "$DIRECTORY"


while true; do

    while true; do

        # Branch checkout.

        echo "Please enter the branch name.";

        read BRANCH;        git -C "$DIRECTORY" checkout "$BRANCH" || continue


        echo "Moving noteskins and judgements..."
        
        cp -r "$DIRECTORY/NoteSkins/." "$TARGET/NoteSkins/$BRANCH"
        cp -r "$DIRECTORY/Judgments" "$TARGET"

        break

    done


    echo "Clone another branch?"

    select OPTION in "Yes" "No"; do break; done

    if [ $OPTION == "No" ]; then break; fi

done


rm -rf "$DIRECTORY";        echo "Exiting..."