#!/bin/bash

# Repalce $1 to the species name
while IFS='' read -r line || [[ -n "$line" ]]; do
    grep $line $1.ConsensusSequences.fa.map 
done < "$1"
