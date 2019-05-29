#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="compute_mean_meth"
#SBATCH -o 98_log_files/mean_meth.out
#SBATCH -c 2
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=4-00:00
#SBATCH --mem=20G


module load methpipe/3.4.3

cd $SLURM_SUBMIT_DIR

#global variables
REGION="08_Mean_meth_byregions/ch17_window_1kb.bed"
DATA_INPUT="05_results_manitou_filtered"
DATA_FOLDER="08_Mean_meth_byregions"

SAMPLE="01_info_file/sample_name_all.txt"

cat "$SAMPLE" | while read i  
do
roimethstat -o "$DATA_FOLDER"/"$i"_mean_1Kb.meth $REGION "$DATA_INPUT"/filtered_"$i"_CpG.meth
done