#############################################################
# Configuration
#############################################################

PATH_TO_HOLOINJECTOR=`realpath ~/school/holoInjector/build/librepeater.so`

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
    ENHANCER_EXIT_AFTER=3 ./${EXAMPLE_RUNNER} ${example} > /dev/null 2>&1
    ENHANCER_EXIT_AFTER=4 ENHANCER_QUILT=1 ENHANCER_WIDE=1 ./${EXAMPLE_RUNNER} ${example} > /dev/null 2>&1
done
#############################################################
# Copy to results 
#############################################################
find examples/ | grep "bmp$" | grep "screenshot" | sed "s/.*\([0-9][^\/]*\)\/screenshot_\([0-9]\).*/&  results\/\1_\2.bmp/g" | xargs -n2 cp

#############################################################
# Convert to jpg
#############################################################
find results | sed "s/\(.*\.\)bmp/'&' '\1jpg'/g" | grep "bmp$" | xargs -n2 convert

echo "Done"
