#!/bin/bash

ref="/home/tarak/ref/hg38.fa"
ref2="/home/tarak/ref/Homo_sapiens_assembly38.dbsnp138.vcf"
Out="/home/tarak/Genome_Analysis/MarkDu"
bq="/home/tarak/Genome_Analysis/BQSR"

for bqsr in $Out/*_dedup_reads.bam;do
    na=$(basename "$bqsr")
    echo -e "\n bqsr running $bqsr"
    
    gatk BaseRecalibrator -I $bqsr -R $ref --known-sites $ref2 -O $bq/${na}_recal_data.table
    
    echo -e "\n Apply BQSR $bqsr"
    
    gatk ApplyBQSR -I $bqsr -R $ref --bqsr-recal-file $bq/${na}_recal_data.table -O $bq/${na}_bqsr_reads.bam
    
    echo "completed$bqsr"
done