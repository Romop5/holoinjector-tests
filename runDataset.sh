#############################################################
# Configuration
#############################################################

PATH_TO_HOLOINJECTOR=`realpath ~/school/holoInjector/build/librepeater.so`
COMMON_FLAGS="HI_RUNINBG=1"
#COMMON_FLAGS=""
NORMAL_FLAGS="HI_EXIT_AFTER=3"
CONVERTED_FLAGS="HI_EXIT_AFTER=4 \
                 HI_QUILT=1 \
                 HI_WIDE=1"

#############################################################
# Code
#############################################################
EXAMPLE=`cat examplesList.txt`
TOTAL_COUNT=`cat examplesList.txt | wc -l`
echo "Total examples: ${TOTAL_COUNT}"
for example in ${EXAMPLE}
do
    echo "Working on example: ${example}"
    EXAMPLE_BASEDIR=`echo ${example} | sed "s/\([^\/]*\/[^\/]*\)\/.*/\1/g"`
    EXAMPLE_RUNNER=`echo ${EXAMPLE_BASEDIR}/run.sh`
    env ${COMMON_FLAGS} ${NORMAL_FLAGS}     ./${EXAMPLE_RUNNER} ${example} > /dev/null 2>&1
    env ${COMMON_FLAGS} ${CONVERTED_FLAGS}  ./${EXAMPLE_RUNNER} ${example} > /dev/null 2>&1
done
#############################################################
# Copy to results 
#############################################################
find examples/ | grep "bmp$" | grep "screenshot" | sed "s/.*\([0-9][^\/]*\)\/screenshot_\([0-9]\).*/&  results\/\1_\2.bmp/g" | xargs -n2 cp

#############################################################
# Convert to jpg
#############################################################
find ./results | grep "bmp" | sed "s/\(.*\.\)bmp/'&' '\1jpg'/g" | xargs -n2 convert

#############################################################
# Rename to _normal.jpg/_converted.jpg
#############################################################
find results | grep "_4" | sed "s/\(.*\)_4\(\....\)/& \1_converted\2/g"  | xargs -n2 mv
find results | grep "_3" | sed "s/\(.*\)_3\(\....\)/& \1_normal\2/g"  | xargs -n2 mv

#############################################################
# Done
#############################################################
echo "Done"
