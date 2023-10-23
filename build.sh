#! /bin/bash
# build the final yaml

OUT_FILE=out.yml

echo > $OUT_FILE
echo -e "suites:\n-" >> $OUT_FILE
while IFS= read -r line; do 
    echo "  $line" >> $OUT_FILE
done < suites/avidant/suite.yml
echo -e "  sections:" >> $OUT_FILE
for dir in suites/avidant/*; do
    if [ -d "$dir" ]; then
        echo "    -" >> $OUT_FILE
        while IFS= read -r line; do     
            echo "      $line" >> $OUT_FILE
        done < $dir/section.yml
        for tc in $dir/testcase_*; do
            echo "      test_cases:" >> $OUT_FILE
            while IFS= read -r line; do   
                echo "          $line" >> $OUT_FILE
            done < $tc
        done
    fi
done
echo "collections:" >> $OUT_FILE
for f in $(ls collections/*.yml); do
    cat $f >> $OUT_FILE
    echo -e "\n" >> $OUT_FILE
done

echo "scenarios:" >> $OUT_FILE
for f in $(ls scenarios/*.yml); do
    cat $f >> $OUT_FILE
    echo -e "\n" >> $OUT_FILE
done

yq eval -o=json out.yml > out.json

#cat out.json | jq '.collections[]|select(.name=="Basic Tests")'