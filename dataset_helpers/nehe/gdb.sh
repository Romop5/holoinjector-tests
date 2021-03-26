#!/bin/bash

SCRIPT_PATH=`readlink -f $0`
ABS_PATH=`dirname ${SCRIPT_PATH}`

if [[ -z $1 ]]
then
    echo "USAGE: $0 <ID>"
    echo "where ID is number from 1-30"
    exit 1
fi

ENHANCER_RELATIVE_DLL=`find ../../ -type f | grep "librepeater" | grep ".so"`
echo "Path to .so: ${ENHANCER_RELATIVE_DLL}"
if [ -z "${ENHANCER_RELATIVE_DLL}" ]
then
    echo "Missing enhancer .so/DLL file! Try to build Enhancer at first, then run this."
    exit 2
fi

#------------------------------------------------------------------------------
ENHANCER_DLL=`realpath ${ENHANCER_RELATIVE_DLL}`
echo "EnhancerDLL: ${ENHANCER_DLL}"
#------------------------------------------------------------------------------

LESSON_ID=`printf "%2d" $1 | tr " " "0"`
LESSON_NAME=$(echo "lesson${LESSON_ID}")
START_DIR=`pwd`

LESSON_PATH=`echo "${ABS_PATH}/linuxglx/${LESSON_NAME}"`
cd ${LESSON_PATH}
gdb -ex "set environment LD_PRELOAD=${ENHANCER_DLL}" ./${LESSON_NAME}
