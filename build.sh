#! /bin/bash
# build the final yaml


DATA_DIR=data
SUITE_DIR=$DATA_DIR/suites/map
OUT_FILE=$DATA_DIR/data.yml
OUT_JSON=$DATA_DIR/data.json

rm $OUT_FILE
rm $OUT_JSON

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
    cat $f >> $OUT_FILE
    echo -e "\n" >> $OUT_FILE
done

yq eval -o=json $OUT_FILE > $OUT_JSON

#cat out.json | jq '.collections[]|select(.name=="Basic Tests")'