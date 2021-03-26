#!/bin/bash

SCRIPT_PATH=`dirname $0`
ABS_PATH=`realpath -s ${SCRIPT_PATH}`

if [[ -z $1 ]]
then
    echo "USAGE: $0 <ID>"
    echo "where ID is number from 1-30"
    exit 1
fi


LESSON_ID=`printf "%2d" $1 | tr " " "0"`
LESSON_NAME=$(echo "lesson${LESSON_ID}")
START_DIR=`pwd`

LESSON_PATH=`echo "${ABS_PATH}/linuxglx/${LESSON_NAME}"`
cd ${LESSON_PATH}
LD_PRELOAD=$2 ./${LESSON_NAME}


