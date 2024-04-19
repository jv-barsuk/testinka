#! /bin/bash
# build the final yaml

if [[ -z $1 ]]; then
    echo "Pass project path to script e.g. build.sh data/testinka-media-app-mobil"
    exit 1
fi

DATA_DIR=$1
SUITE_DIR=$DATA_DIR/suites/map
OUT_FILE=$DATA_DIR/tmp.yml
OUT_JSON=$DATA_DIR/tmp.json

rm $OUT_FILE

echo > $OUT_FILE
echo -e "suites:\n-" >> $OUT_FILE
while IFS= read -r line; do 
    echo "  $line" >> $OUT_FILE
done < $SUITE_DIR/suite.yml
echo -e "  sections:" >> $OUT_FILE
for dir in $SUITE_DIR/*; do
    if [ -d "$dir" ]; then
        echo "    -" >> $OUT_FILE
        while IFS= read -r line; do     
            echo "      $line" >> $OUT_FILE
        done < $dir/section.yml
        echo "      test_cases:" >> $OUT_FILE
        for tc in $dir/testcase_*; do
            while IFS= read -r line; do   
                echo "          $line" >> $OUT_FILE
            done < $tc
        done
    fi
done
echo "collections:" >> $OUT_FILE
for f in $(ls $DATA_DIR/collections/*.yml); do
    cat $f >> $OUT_FILE
    echo -e "\n" >> $OUT_FILE
done

echo "scenarios:" >> $OUT_FILE
for f in $(ls $DATA_DIR/scenarios/*.yml); do
    SCENARIO_OUT_FILE=$DATA_DIR/$(basename ${f:0:-4})
    cp $OUT_FILE $SCENARIO_OUT_FILE.yml
    cat $f >> $SCENARIO_OUT_FILE.yml
    echo -e "\n" >> $SCENARIO_OUT_FILE.yml
    yq eval -o=json $SCENARIO_OUT_FILE.yml > $SCENARIO_OUT_FILE.json
done



#cat out.json | jq '.collections[]|select(.name=="Basic Tests")'