#!/bin/bash
# usage: ./installOpenGlTutorialExamples.sh <installation-dir>
# This script will clone & make gathered examples from the internet

START_DIR=`pwd`
START_DIR_ABS=`realpath ${START_DIR}`
# if [ $# -lt 1 ]
# then
#     echo "USAGE: ${0} <installation-dir>"
#     exit 1
# fi
#INSTALL_DIR=$1
INSTALL_DIR="examples"

cloneAndInstallRepo() {
    BASEDIR=`pwd`
    REPO=${1}
    REPO_NAME=`basename ${1}`
    echo "[${0}] Installing ${REPO_NAME}"
    if ! [[ -d ${REPO_NAME} ]];
    then
        git clone "${REPO}" "${REPO_NAME}"
    fi
    
    # Build & install 
    cd ${REPO_NAME} &&\
        mkdir -p build && cd build &&\
        cmake ../ -DCMAKE_BUILD_TYPE=Release . &&\
        make -j4

    if [ $? -ne 0 ]
    then
        echo "Failed to build ${REPO_NAME}"
    fi

    cd ${BASEDIR}
}

# Install legendary NeHe tutorials
# Note: linuxglx version is used as GLX is widely available 
installNehe()
{
    BASEDIR=`pwd`
    REPO=https://github.com/gamedev-net/nehe-opengl
    REPO_NAME=`basename ${REPO}`
    # Create NeHe tutorials (OpenGL fixed-pipeline legacy tutorial)
    git clone "${REPO}" "${REPO_NAME}"
    cd ${REPO_NAME}
    # Hack: Make fullscreen disabled by default (hint: use F1 to toggle in-app)
    find linuxglx -type f | grep "c$" | xargs sed -i "s/GLWin.fs = True/GLWin.fs = False/g"

    # Make all lessons at once using the central Makefile
    cd linuxglx
    make -j4
    cd ${BASEDIR}
}

if [[ -d ${INSTALL_DIR} ]];
then
    echo "Install dir exists"
else
    mkdir ${INSTALL_DIR}
fi

if [[ -z "${SKIP_INSTAL}" ]]
then
cd ${INSTALL_DIR}
cloneAndInstallRepo https://github.com/JoeyDeVries/LearnOpenGL
cloneAndInstallRepo https://github.com/opengl-tutorials/ogl
cloneAndInstallRepo https://github.com/zuck/opengl-examples
installNehe
cd ${START_DIR_ABS}
fi
# Copy additional files (e.g. start scripts)
cp dataset_helpers/leogl/run.sh ${INSTALL_DIR}/LearnOpenGL/
cp dataset_helpers/leogl/runNormal.sh ${INSTALL_DIR}/LearnOpenGL/
cp dataset_helpers/leogl/tracer.sh ${INSTALL_DIR}/LearnOpenGL/
cp dataset_helpers/leogl/gdb.sh ${INSTALL_DIR}/LearnOpenGL/


cp dataset_helpers/nehe/nehe.sh ${INSTALL_DIR}/nehe-opengl/
cp dataset_helpers/nehe/enhancer.sh ${INSTALL_DIR}/nehe-opengl/
cp dataset_helpers/nehe/gdb.sh ${INSTALL_DIR}/nehe-opengl/
cp dataset_helpers/nehe/tracer.sh ${INSTALL_DIR}/nehe-opengl/
