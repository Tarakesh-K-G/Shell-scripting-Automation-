#!/bin/bash

ref="/home/tarak/ref/hg38.fa"
Trim_file="/home/tarak/Genome_Analysis/tri"
Aligned="/home/tarak/Genome_Analysis/align"
#bwa index $ref

for seq in $Trim_file/*.fastq;do
    base=$(basename "$seq")
    echo -e "\nRun alignment:$seq"
    bwa mem -R "@RG\tID:${base}\tSM:${base}\tPL:ILLUMINA\tLB:lib1" $ref "$seq" > $Aligned/${base}.sam
    
    echo -e "\nConvert SAM → BAM:$base"
    samtools view -S -b $Aligned/${base}.sam > $Aligned/${base}.bam
    
    echo -e "\nSort BAM:$base"
    samtools sort $Aligned/${base}.bam -o $Aligned/${base}.sorted.bam
    
    echo -e "\nIndex BAM:$base"
    samtools index $Aligned/${base}.sorted.bam
done