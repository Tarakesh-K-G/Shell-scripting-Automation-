#!/bin/bash

ref="/home/tarak/ref/hg38.fa"
ref2="/home/tarak/ref/Homo_sapiens_assembly38.dbsnp138.vcf"
bq="/home/tarak/Genome_Analysis/BQSR"
va="/home/tarak/Genome_Analysis/Variant"
snp="/home/tarak/Genome_Analysis/snps"
indel="/home/tarak/Genome_Analysis/indels"

for vari in $bq/*_bqsr_reads.bam;do
    na=$(basename "$vari")
    echo -e "\n Variant Calling running $vari"
    gatk HaplotypeCaller -R $ref -I $vari -O $va/${na}_raw_variants.vcf

    echo -e "\n Selecting Variants SNP $vari"
    gatk SelectVariants -R $ref -V $va/${na}_raw_variants.vcf --select-type SNP -O $snp/${na}_raw_snps.vcf
    
    echo -e "\n Selecting Variants INDELS $vari"
    gatk SelectVariants -R $ref -V $va/${na}_raw_variants.vcf --select-type INDEL -O $indel/${na}_raw_indels.vcf
    
    echo "completed $vari"
done