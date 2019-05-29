#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="gzip"
#SBATCH -o ../98_log_files/gzip.out
#SBATCH -c 1
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=5-00:00
#SBATCH --mem=20G

cat ../names_to_compress.txt | while read i  
do

  gzip "$i"
  echo "$i"
done
