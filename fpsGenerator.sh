runFPS()
{
    ENHANCER_RECORDFPS=1  $* | grep "Frame ID:" > fps.txt
}

runFPSAndProcess()
{
    OUTPUT_FILE=$2
    runFPS "$1"
    echo "# Command: $1" >> ${OUTPUT_FILE}
    cat fps.txt | ./fpsResults/statistics.sh >> ${OUTPUT_FILE}
    cat fps.txt | ./fpsResults/statistics.sh
}


runWithParameters()
{
    FILEHASH=`echo "MAX FRAMES: $2 QUILT: ${3}x${4} ENHANCER_ON: ${5} WIDTH= ${6} HEIGHT: ${7}
    COMMAND: $1" | sha1sum | sed "s/ *- *$//g"`
    FILENAME=`echo fpsResults/${FILEHASH}.txt`
    echo "[${FILENAME}]  MAX FRAMES: $2 QUILT: ${3}x${4} ENHANCER_ON: ${5} WIDTH= ${6} HEIGHT: ${7} COMMAND: $1"
    if [ "$5" = "1" ]
    then 
        export ENHANCER_NOW=1
    else
        unset ENHANCER_NOW
    fi
    ENHANCER_EXIT_AFTER=$2 ENHANCER_QUILTX=$3 ENHANCER_QUILTY=$4 ENHANCER_FBOWIDTH=$6 ENHANCER_FBOHEIGHT=$7 runFPSAndProcess "$1" ${FILENAME}
    echo "---"
}


runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 1 1 0 128 128

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 3 3 0 128 128

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 3 3 1 128 128

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 5 9 1 128 128


runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 1 1 0 256 256

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 3 3 0 256 256

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 3 3 1 256 256

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 5 9 1 256 256


runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 1 1 0 512 512

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 3 3 0 512 512

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 3 3 1 512 512

runWithParameters "./examples/LearnOpenGL/run.sh \
./examples/LearnOpenGL/src/4.advanced_opengl/10.2.asteroids" 200 5 9 1 512 512


