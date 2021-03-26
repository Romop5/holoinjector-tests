#############################################################
# Configuration
#############################################################

PATH_TO_HOLOINJECTOR_DLL=`realpath ~/school/holoInjector/build/librepeater.so`

#############################################################
# Code
#############################################################
EXAMPLE=`cat examplesList.txt`
TOTAL_COUNT=`cat examplesList.txt | wc -l`
echo "Total examples: ${TOTAL_COUNT}"
for example in ${EXAMPLE}
do
    echo "Working on example: ${example}"
    ENHANCER_EXIT_AFTER=3 ./run.sh ${example} > /dev/null 2>&1
    ENHANCER_EXIT_AFTER=4 ENHANCER_QUILT=1 ENHANCER_WIDE=1 ./run.sh ${example} > /dev/null 2>&1
done
