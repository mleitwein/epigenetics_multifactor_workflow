#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="n_line"
#SBATCH -o log-cp.out
#SBATCH -c 1
#SBATCH -A  ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=1G


gunzip -c 03_trimmed/HI.4703.001.Index_6.F_27_trimmed_fastp_R1.fastq.gz | wc -l > n_line_4703.001.Index_6.F_27_R1

gunzip -c 03_trimmed/HI.4703.002.Index_6.F_27_trimmed_fastp_R1.fastq.gz | wc -l > n_line_4703.002.Index_6.F_27_R1

gunzip -c 03_trimmed_rename/F_27_R1.fastq.gz | wc -l > n_line_F_27_R1






