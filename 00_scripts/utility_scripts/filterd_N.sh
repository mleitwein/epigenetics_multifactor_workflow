#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="filters"
#SBATCH -o ../../../98_log_files/filters.out
#SBATCH -c 1
#SBATCH -p small
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=10G


#dss file
#for file in *.dss
#do 
#cat $file |   awk -F" " '{if ($3 >= 10) print $0}'  > ../05_results_manitou_filtered/filtered_$file

#done
 
# _CpG.met

#for file in *_CpG.meth
#do 
#cat $file |   awk -F"\t" '{if ($6 >= 10) print $0}'  > ../05_results_manitou_filtered/filtered_$file

#done

# filtre mean CpG = 3 

# cd /project/lbernatchez/users/malei6/data/2018-04-05_epigenetics/08_Mean_meth_byregions/all_chr/02_data/

for file in *
do 
cat $file | awk -F ":" '{ if ($2 >= 3)  print $0}' > ../02_data_filtered_minGpG_3/filtered_$file

done
