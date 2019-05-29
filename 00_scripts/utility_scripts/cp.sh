#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="cp"
#SBATCH -o log-cp.out
#SBATCH -c 1
#SBATCH -A  ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maeva.leitwein.1@ulaval.ca
#SBATCH --time=5-00:00
#SBATCH --mem=1G


 cp /project/lbernatchez/temp_transfert/okis.bc.recode.vcf /project/lbernatchez/users/malei6/data/2018-04-06_epigenetique_coho/00_reference/01_genomeReseqBC/




