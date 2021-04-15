#!/bin/bash

MICROSECONDS=`cat fps.txt | grep "Frame ID" | sed "s/.* \([0-9]\+\) us.*/\1/g"`
#MICROSECONDS_BC=`echo "${MICROSECONDS}" | sed "s/\n/+ /g"`
TOTAL_FRAMES=`echo "${MICROSECONDS}" | wc -l`
MICROSECONDS_MEDIAN=`echo "${MICROSECONDS}" | sort -n | tail -n $(($TOTAL_FRAMES / 2 )) | head -n1`

TOTAL_TIME=$((0))
for period in ${MICROSECONDS}
do 
    TOTAL_TIME=$(($TOTAL_TIME + $period))
done
AVGTIME=$((${TOTAL_TIME} / ${TOTAL_FRAMES}))
AVGFPS=`echo "(( ${TOTAL_FRAMES}* 1000000) / ${TOTAL_TIME} ) " | bc`

#echo "Total time: ${TOTAL_TIME}"
#echo "Count of frames: ${TOTAL_FRAMES}"
#echo "Avg time: ${AVGTIME}"
#echo "Median: ${MICROSECONDS_MEDIAN}"

echo "Frames, Total time, Avg. time, Median, Avg. FPS"
echo "${TOTAL_FRAMES}, ${TOTAL_TIME}, ${AVGTIME}, ${MICROSECONDS_MEDIAN}, ${AVGFPS}"

