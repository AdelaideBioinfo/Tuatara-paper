#!/bin/bash
for i in *.mfa
do
    echo $i
    blastn -query $i -subject $i -outfmt 6 -out blastn_$i
done

for i in blastn_*.mfa; 
do 
    awk '{if($1!=$2) print}' $i > test_$i; 
done

for i in test_blastn_*; 
do 
    head -n 1 $i > tmp_$i; 
done

cat tmp_$i > total_alignment.txt
rm tmp_$i
rm test_$i