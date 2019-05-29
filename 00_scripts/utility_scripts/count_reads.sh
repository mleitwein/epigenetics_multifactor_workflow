for file in *.mr.mapstats

		do 
		
		echo $file | awk -F"." '{print $1}' > name
		
		head -10 $file | awk -F ":" '{print $2}' | awk -F"]" '{print $1}' | perl -00 -lpe 's/\n/\t/g' > data
		
    paste name data >> ../mapping_stat.txt
		done
