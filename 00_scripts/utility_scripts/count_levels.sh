#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="count_meth"
#SBATCH -o ../98_log_files/count_meth.out
#SBATCH -c 1
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=10G



for file in *.levels

		do 
		
		echo $file | awk -F"." '{print $1}' > name
		
		cat $file |  sed -n '3,12p' | awk -F" " '{print $2}' | perl -00 -lpe 's/\n/\t/g' > data
		
    paste name data | sed -r '/^\s*$/d' >> ../meth_level_all_cytosine
		done
   
   
   
for file in *.levels

		do 
		
		echo $file | awk -F"." '{print $1}' > name
		
		cat $file |  sed -n '14,23p' | awk -F" " '{print $2}' | perl -00 -lpe 's/\n/\t/g' > data
		
    paste name data | sed -r '/^\s*$/d' >> ../meth_level_CpG_context
		done
   
   
for file in *.levels

		do 
		
		echo $file | awk -F"." '{print $1}' > name
		
		cat $file |  sed -n '25,34p' | awk -F" " '{print $2}' | perl -00 -lpe 's/\n/\t/g' > data
		
    paste name data | sed -r '/^\s*$/d' >> ../meth_level_symetric_CpG_context
		done