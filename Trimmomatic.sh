#!/bin/bash

fastq_file="/home/tarak/Genome_Analysis"
Trim_file="/home/tarak/Genome_Analysis/tri"

for file in $fastq_file/*.fastq;do
    base=$(basename "$file" .fastq)
    echo -e "\n Running $file"
    trimmomatic SE \
     $file \
     $Trim_file/${base}_trimmed.fastq \
     ILLUMINACLIP:/home/tarak/anaconda3/share/trimmomatic/adapters/TruSeq3-SE.fa:2:30:10 \
     LEADING:3 \
     TRAILING:3 \
     SLIDINGWINDOW:4:20 \
     MINLEN:36
echo "trimmomatic completed:$file"
done
