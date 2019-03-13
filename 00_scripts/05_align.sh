#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="align.__BASE__"
#SBATCH -o 98_log_files/align.__BASE__.out
#SBATCH -c 5
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=32000


cd $SLURM_SUBMIT_DIR

# Import samtools

module load  samtools/1.8

#global variables
INDEX="04_reference/index_genome.dbindex"
DATAFOLDER="03_trimmed_rename"
DATAOUTPUT="05_results"
SAMPLE="01_info_file/sample_name.txt"

cat "$SAMPLE" | while read i  
do

zcat "$DATAFOLDER"/"$i"_R1.fastq.gz > "$DATAFOLDER"/"$i"_R1.fastq
zcat "$DATAFOLDER"/"$i"_R2.fastq.gz > "$DATAFOLDER"/"$i"_R2.fastq

walt -i $INDEX -m 6 -t 5 -k 10 -N 5000000 -1  "$DATAFOLDER"/"$i"_R1.fastq -2 "$DATAFOLDER"/"$i"_R2.fastq -o "$DATAOUTPUT"/"$i".mr

rm "$DATAFOLDER"/"$i"_R*.fastq

done

