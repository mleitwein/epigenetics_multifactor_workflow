#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="methpipe_x"
#SBATCH -o 98_log_files/methpipe_x.out
#SBATCH -c 2
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=3-00:00
#SBATCH --mem=20G


module load methpipe/3.4.3

cd $SLURM_SUBMIT_DIR

#global variables
GENOME="04_reference/genome_filtered.fna"
DATA_FOLDER="05_results"
DATAINPUT="03_trimmed"
#base=__BASE__

SAMPLE="01_info_file/sample_name_x"

cat "$SAMPLE" | while read i  
do

LC_ALL=C sort -k 1,1 -k 2,2n -k 3,3n -k 6,6 -o "$DATA_FOLDER"/"$i".mr.sorted_start "$DATA_FOLDER"/"$i".mr

#rm "$DATAINPUT"/"$base".mr

# Remove putative PCR duplicates

duplicate-remover -S "$DATA_FOLDER"/"$i".dremove_stat.txt -o "$DATA_FOLDER"/"$i".mr.dremove "$DATA_FOLDER"/"$i".mr.sorted_start

rm "$DATA_FOLDER"/"$i".mr.sorted_start

LC_ALL=C sort -k 1,1 -k 2,2n -k 3,3n -k 6,6 -o "$DATA_FOLDER"/"$i".mr.dremove.sort "$DATA_FOLDER"/"$i".mr.dremove

rm "$DATA_FOLDER"/"$i".mr.dremove

# Compute methylation level
methcounts -cpg-only -c $GENOME -o "$DATA_FOLDER"/"$i".meth "$DATA_FOLDER"/"$i".mr.dremove.sort

# Compute symmetric CpGs contexts
symmetric-cpgs -o "$DATA_FOLDER"/"$i"_CpG.meth "$DATA_FOLDER"/"$i".meth

# Compute methylation stats
levels -o "$DATA_FOLDER"/"$i".levels "$DATA_FOLDER"/"$i".meth

# Compute conversion rate
bsrate -c $GENOME -o "$DATA_FOLDER"/"$i".bsrate "$DATA_FOLDER"/"$i".mr.dremove.sort

rm "$DATA_FOLDER"/"$i".mr.dremove.sort

done
