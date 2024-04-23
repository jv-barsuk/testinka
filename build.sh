#! /bin/bash
# build the final yaml

if [[ -z $1 ]]; then
    echo "Pass project path to script e.g. build.sh data/testinka-media-app-mobil"
    exit 1
fi

DATA_DIR=$1
BUILD_DIR=$DATA_DIR/build
SUITE_DIR=$DATA_DIR/suite
OUT_FILE=$BUILD_DIR/tmp.yml
OUT_JSON=$BUILD_DIR/tmp.json

rm $OUT_FILE 2> /dev/null
mkdir $BUILD_DIR 2> /dev/null
rm -R $BUILD_DIR/* 2> /dev/null


echo > $OUT_FILE
echo -e "suites:\n-" >> $OUT_FILE
#while IFS= read -r line; do 
#    echo "  $line" >> $OUT_FILE
#done < $SUITE_DIR/suite.yml
SUITE_DIR_BASENAME=$(basename $SUITE_DIR)
echo "  name: $SUITE_DIR_BASENAME" >> $OUT_FILE
echo -e "  sections:" >> $OUT_FILE
for SUITE_SECTION_DIR in $SUITE_DIR/*; do
    if [ -d "$SUITE_SECTION_DIR" ]; then
        echo "    -" >> $OUT_FILE
        #while IFS= read -r line; do     
        #    echo "      $line" >> $OUT_FILE
        #done < $dir/section.yml
        SUITE_SECTION_DIR_BASENAME=$(basename $SUITE_SECTION_DIR)
        echo "      name: $SUITE_SECTION_DIR_BASENAME" >> $OUT_FILE
        echo "      test_cases:" >> $OUT_FILE
        for tc in $SUITE_SECTION_DIR/*.testcase.yml; do
            while IFS= read -r line; do   
                echo "          $line" >> $OUT_FILE
            done < $tc
        done
    fi
done
echo "collections:" >> $OUT_FILE
for f in $(ls $DATA_DIR/collections/*.collection.yml); do
    cat $f >> $OUT_FILE
    echo -e "\n" >> $OUT_FILE
done

echo "scenarios:" >> $OUT_FILE
for f in $(ls $DATA_DIR/scenarios/*.scenario.yml); do
    SCENARIO_OUT_FILE=$BUILD_DIR/$(basename ${f:0:-13})
    cp $OUT_FILE $SCENARIO_OUT_FILE.yml
    cat $f >> $SCENARIO_OUT_FILE.yml
    echo -e "\n" >> $SCENARIO_OUT_FILE.yml
    yq eval -o=json $SCENARIO_OUT_FILE.yml > $SCENARIO_OUT_FILE.json
done



#cat out.json | jq '.collections[]|select(.name=="Basic Tests")'