#!/bin/bash

#======================================================================================================
#	Extension make script
#======================================================================================================

SCRIPT=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPT_PATH=$(dirname "$SCRIPT")
CUR_PATH=$(pwd)

EXT_NAME="syncthing@gnome.2nv2u.com"

# Generate translations
[ -d $SCRIPT_PATH/src/locale ] && rm -rf $SCRIPT_PATH/src/locale
for LANG_FILE in $SCRIPT_PATH/po/*.po; do
    MO_PATH=$SCRIPT_PATH/src/locale/$(basename "${LANG_FILE%.*}")/LC_MESSAGES
    mkdir -p $MO_PATH
    msgfmt $LANG_FILE -o $MO_PATH/$EXT_NAME.mo
done

# Zip extensions files
(cd $SCRIPT_PATH/src && zip -r $CUR_PATH/$EXT_NAME.zip *)
zip -r $CUR_PATH/$EXT_NAME.zip -j $SCRIPT_PATH/LICENSE