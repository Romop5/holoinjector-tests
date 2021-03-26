#!/bin/bash
echo $0
SCRIPT_PATH=`readlink -f $0`
ABS_PATH=`dirname ${SCRIPT_PATH}`
NEHE_PATH=`echo "${ABS_PATH}/nehe.sh"`

ENHANCER_RELATIVE_DLL=`find ../../ -type f | grep "librepeater" | grep ".so"`
echo "Path to .so: ${ENHANCER_RELATIVE_DLL}"
if [ -z "${ENHANCER_RELATIVE_DLL}" ]
then
    echo "Missing enhancer .so/DLL file! Try to build Enhancer at first, then run this."
    exit 2
fi

ENHANCER_DLL=`realpath ${ENHANCER_RELATIVE_DLL}`
echo "EnhancerDLL: ${ENHANCER_DLL}"

# START APP
echo ${NEHE_PATH}
${NEHE_PATH} $1 "${ENHANCER_DLL}"


