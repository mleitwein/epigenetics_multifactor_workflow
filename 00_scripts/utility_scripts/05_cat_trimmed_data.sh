#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="cat_file"
#SBATCH -o 98_log_files/cat.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_name@ulaval.ca
#SBATCH --time=00-10:00
#SBATCH --mem=5G


cd $SLURM_SUBMIT_DIR

#global variables
DATAFOLDER="03_trimmed"
DATAOUTPUT="03_trimmed_rename"
SAMPLE="01_info_file/sample_name.txt"

cat "$SAMPLE" | while read i  
do

  rm "$DATAOUTPUT"/"$i"_R1.fastq.gz "$DATAOUTPUT"/"$i"_R2.fastq.gz
  
  cat "$DATAFOLDER"/*."$i"_*R1.fastq.gz >> "$DATAOUTPUT"/"$i"_R1.fastq.gz
  cat "$DATAFOLDER"/*."$i"_*R2.fastq.gz >> "$DATAOUTPUT"/"$i"_R2.fastq.gz

done
