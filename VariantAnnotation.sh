#!/bin/bash

ref="/home/lion/ref/hg38.fasta"
pass_snp="/home/lion/Genome/VariantFilter/SNP/PASS_filter"
pass_indel="/home/lion/Genome/VariantFilter/INDELS/PASS_filter"
an_snp="/home/lion/Genome/ann/snp"
an_in="/home/lion/Genome/ann/indel"

for file in $pass_snp/*-snps.vcf;do
    na=$(basename "$file")
    echo "START ANNOTATE $file"
    
    snpEff -v -Xmx8g hg38_custom $file -stats snpeff_report.html > $an_snp/${na}_annotated_html.vcf

echo "ANNOTATION COMPLETED $file"
done

for fit in $pass_indel/*-indels.vcf;do
    na=$(basename "$fit")
    echo "START ANNOTATE $fit"
    
    snpEff -v -Xmx8g hg38_custom $fit -stats snpeff_report.html > $an_in/${na}_annotated_html.vcf

echo "ANNOTATION COMPLETED $fit"
done