#!/bin/bash
fastq_file="/home/tarak/Genome_Analysis"
fastqc_report="/home/tarak/Genome_Analysis/fastqc"

for file in $fastq_file/*.fastq;do
    echo -e "\n Running $file"
    fastqc $file -O $fastqc_report
echo "fastqc is completed"
done