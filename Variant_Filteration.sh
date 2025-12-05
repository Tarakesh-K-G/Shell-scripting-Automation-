#!/bin/bash

ref="/home/tarak/ref/hg38.fa"
snp="/home/tarak/Genome_Analysis/snps"
indel="/home/tarak/Genome_Analysis/indels"
filter_snp="/home/tarak/Genome_Analysis/VariantFilter/SNP"
filter_indel="/home/tarak/Genome_Analysis/VariantFilter/INDELS"
pass_snp="/home/tarak/Genome_Analysis/VariantFilter/SNP/PASS_filter"
pass_indel="/home/tarak/Genome_Analysis/VariantFilter/INDELS/PASS_filter"


for file in $snp/*_raw_snps.vcf;do
    name=$(basename "$file")
    echo -e "\n Start Filering of SNP $file"
    
    gatk VariantFiltration \
    -R $ref \
    -V $file \
    -O $filter_snp/${name}_filtered_snps.vcf \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 60.0" \
    -filter-name "MQ_filter" -filter "MQ < 40.0" \
    -filter-name "SOR_filter" -filter "SOR > 4.0" \
    -filter-name "MQRankSum_filter" -filter "MQRankSum < -12.5" \
    -filter-name "ReadPosRankSum_filter" -filter "ReadPosRankSum < -8.0" \
    -genotype-filter-expression "DP < 10" \
    -genotype-filter-name "DP_filter" \
    -genotype-filter-expression "GQ < 10" \
    -genotype-filter-name "GQ_filter"
    
    echo -e "\n SNP Filering completed $file"
    
    
    echo -e "\n Select Variants that PASS filters SNP: $file"
    
    gatk SelectVariants \
    --exclude-filtered \
    -V $filter_snp/${name}_filtered_snps.vcf \
    -O $pass_snp/${name}_analysis-ready-snps.vcf
    
    echo "Completed pass filter of SNP $file"
done

for ind in $indel/*_raw_indels.vcf;do
    name=$(basename "$ind")
    echo -e "\n Start Filering of INDELS $ind"
    
    gatk VariantFiltration \
    -R $ref \
    -V $ind \
    -O $filter_indel/${name}_filtered_indels.vcf \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 200.0" \
    -filter-name "SOR_filter" -filter "SOR > 10.0" \
    -genotype-filter-expression "DP < 10" \
    -genotype-filter-name "DP_filter" \
    -genotype-filter-expression "GQ < 10" \
    -genotype-filter-name "GQ_filter"
    
    echo "INDELS Filtering completed $ind"
    
    echo -e "\n Select Variants that PASS filters INDEL:$ind"
    
    gatk SelectVariants \
    --exclude-filtered \
    -V $filter_indel/${name}_filtered_indels.vcf \
    -O $pass_indel/${name}_analysis-ready-indels.vcf

    echo "Completed pass filter of INDELS $ind"
done