for file in *.dremove_stat.txt

		do 
		
		echo $file | awk -F"." '{print $1}' > name
		
		cat $file | awk -F ":" '{print $2}' | perl -00 -lpe 's/\n/\t/g' > data
		
    paste name data >> ../dremove_stat.txt
		done
   
sed -r '/^\s*$/d' ../dremove_stat.txt