#!/bin/bash

ref="/home/tarak/ref/hg38.fa"
Aligned="/home/tarak/Genome_Analysis/align"
Out="/home/tarak/Genome_Analysis/MarkDu"

for mark in $Aligned/*sorted.bam;do
    na=$(basename "$mark")
    echo -e "\n Marking duplicates in $mark"
    
    gatk MarkDuplicates \
    -I $mark \
    -O $Out/${na}_dedup_reads.bam \
    -M $Out/${na}_metrics.txt

    
    echo "Marking completed$mark"
done