#!/bin/bash

#SBATCH -J TrimClean_fastp
#SBATCH -o 98_log_files/log-trimming.fastp.out
#SBATCH -c 1 
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXX
#SBATCH --time=06-00:00
#SBATCH --mem=10G

cd $SLURM_SUBMIT_DIR 

# Load the software with module if applicable:
module load cutadapt
module load fastqc/0.11.2 


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#variables
LENGTH=100
QUAL=25

OUTPUT="03_trimmed"
#base=__BASE__

# ls *.fastq.gz | awk -F"R" '{print $1}' | uniq > ../03_info_file/names_databrut

ls 02_data/*.fastq.gz | awk -F"R" '{print $1}' | uniq |  while read i
do
name=$(echo "$i" | cut -d "/" -f 2)

fastp -i "$i"R1.fastq.gz -I "$i"R2.fastq.gz \
-o $OUTPUT/"$name"Trimed_fastp_R1.fastq.gz  -O $OUTPUT/"$name"Trimed_fastp_R2.fastq.gz \
--length_required="$LENGTH" --qualified_quality_phred="$QUAL" --correction --trim_tail1=1 --trim_tail2=1 \
--json $OUTPUT/"$name" --html $OUTPUT/"$name"  --report_title="$name" 

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmgalore_wgbs.log
