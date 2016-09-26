#!/bin/bash

SRA=$1
WDir=$2

cd $WDir

for sra in `esearch -db sra -query "$SRA" | efetch -format docsum | \
        xtract -pattern DocumentSummary -element "Run@acc" | \
        xargs `
do
        if [ ! -e "${sra}.fastq.gz" ]
        then
                echo "Downloading sra: $sra"
                fastq-dump $sra
                gzip -9 ${sra}.fastq
        fi
done

exit 0
