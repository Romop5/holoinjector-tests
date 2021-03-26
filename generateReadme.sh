REPO_URL='https://raw.githubusercontent.com/Romop5/holoinjector-tests/master/'

RESULTS=`find results | grep '_normal' | grep 'jpg'`

rm README.md

echo '# holoinjector-tests
     ## About
     Semi-automatized test dataset for [HoloInjector](https://github.com/Romop5/holoinjector)
     ## Usage
     - run *getDataset.sh* to download & build selected OpenGL examples from the internet
     - run *runDataset.sh* to run HoloInjector over exampleList.txt. This results in screenshots,
          stored in results. This screenshots compare a regular application (_normal) with
          converted.
     - run *generateReadme.sh* to regenerate this README.md' >> README.md

echo "<div align='center'>" >> README.md
for RESULT in ${RESULTS}
do
    CONVERTED=`echo ${RESULT} | sed 's/_normal/_converted/g'`
    echo "
        <img src='${REPO_URL}${RESULT}'     alt='Original'  height='200px'/>
        <img src='${REPO_URL}${CONVERTED}'  alt='Converted' height='200px'/>
    " >> README.md
done
echo "</div>" >> README.md

