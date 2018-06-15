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

<<<<<<< HEAD
cd $SLURM_SUBMIT_DIR
=======
# Import samtools

module load  samtools/1.8

#global variables
INDEX="04_reference/index_genome.dbindex"
DATAFOLDER="03_trimmed"
DATAOUTPUT="05_results"

ls 02_data/*.fastq.gz | awk -F"R" '{print $1}' | uniq |  while read i
do
name=$(echo "$i" | cut -d "/" -f 2)

zcat "$i"R1.fastq.gz > "$i"R1.fastq
zcat "$i"R2.fastq.gz > "$i"R2.fastq

walt -i $INDEX -m 6 -t 5 -k 10 -N 5000000 -1  "$i"R1.fastq -2 "$i"R2.fastq -o "$DATAOUTPUT"/"$name".mr


rm "$i"R*.fq
