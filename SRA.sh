#!/bin/bash
File_SRA="$(cat /home/tarak/SRA/SraAccList.csv)"

for sra_id in $File_SRA;do
    echo "Downloading $sra_id"
    prefetch $sra_id
    echo "Extracting paired end $sra_id"
    fasterq-dump --split-files $sra_id --outdir /home/tarak/Genome_Analysis
done
