#!/bin/bash

#SBATCH --job-name="BEDvcf"
#SBATCH -o log-BED0.05
#SBATCH -c 1
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=0-02:00
#SBATCH --mem=2G

cd $SLURM_SUBMIT_DIR

module load vcftools/0.1.12b

INPUT="okis.bc.recode.vcf"


vcftools --gzvcf $INPUT --recode --max-missing 0.1 --maf 0.05 --stdout|grep 'C	T'|grep -v '#'|grep -v ^$|awk '{print $1"\t"$2-1"\t"$2}' > okis_southernBC_SNPs_Juin12-2018_maf0.05_CT.bed

