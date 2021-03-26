#!/bin/bash

if [ -z "$1" ]
then
    echo "USAGE: $0 <path-to-example>"
    echo "Example: $0 ./src/1.getting_started/1.2.hello_window"
    exit 1
fi

SCRIPT_PATH=`readlink -f $0`
SCRIPT_DIR=`dirname ${SCRIPT_PATH}`

EXAMPLE_PATH=$1
EXAMPLE_NAME=`basename $1`
EXAMPLE_EXE=`find ${SCRIPT_DIR}/bin -executable | grep "${EXAMPLE_NAME}"`
EXAMPLE_EXE_ABSOLUTE=`realpath ${EXAMPLE_EXE}`


ENHANCER_RELATIVE_DLL=`find ${SCRIPT_DIR}/../../ -type f | grep "librepeater" | grep ".so"`
echo "Path to .so: ${ENHANCER_RELATIVE_DLL}"
if [ -z "${ENHANCER_RELATIVE_DLL}" ]
then
    echo "Missing enhancer .so/DLL file! Try to build Enhancer at first, then run this."
    exit 2
fi

ENHANCER_DLL=`realpath ${ENHANCER_RELATIVE_DLL}`

# START APP
cd $1
APITRACE_BACKTRACE="glDraw*" LD_PRELOAD=${ENHANCER_DLL}:/usr/local/lib/x86_64-linux-gnu/apitrace/wrappers/glxtrace.so ${EXAMPLE_EXE_ABSOLUTE}
