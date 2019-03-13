#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="filter"
#SBATCH -o 98_log_files/filter.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=00-02:00
#SBATCH --mem=2G

cd $SLURM_SUBMIT_DIR

module load bedtools/2.26.0

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#global variables
GENOME="00_reference/GCF_002021735.1_Okis_V1_genomic.fna"

GENOME_MASK="00_reference/genome_filtered.fna"

#SOFT="-soft"           Enforce "soft" masking.  That is, instead of masking with Ns,
#                       mask with lower-case bases.

#MASK_CHR="-mc"         #Replace masking character.  That is, instead of masking
#                       with Ns, use another charac

FORMAT_INFO="00_reference/01_genomeReseqBC/okis_southernBC_SNPs_Juin12-2018_maf0.05_CT.bed" #BED/GFF/VCF file of ranges to mask in -fi



#script
bedtools maskfasta $SOFT $MASK_CHR -fi $GENOME -fo $GENOME_MASK -bed $FORMAT_INFO
