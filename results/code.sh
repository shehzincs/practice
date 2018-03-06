#converting the pdf results to text file without changing the layout 
pdftotext -layout s1.pdf s1.txt
pdftotext -layout s2.pdf s2.txt

#Removing all spaces and newline from the text file 
tr -d ' \n\r'< s1.txt  > s1temp.txt && mv s1temp.txt s1.txt
tr -d ' \n\r'< s2.txt  > s2temp.txt && mv s2temp.txt s2.txt

#Adding a newline after each MDL16CS
sed -i 's/MDL16CS/\nMDL16CS/g' s1.txt
sed -i 's/MDL16CS/\nMDL16CS/g' s2.txt 

#Moving Electronic to the next line
sed -i 's/ELEC/\nELEC/g' s1.txt
sed -i 's/TCE/\nTCE/g' s2.txt

#removing all lines which are not starting with MDL16CS
grep MDL16CS s1.txt > s1temp.txt && mv s1temp.txt s1.txt
grep MDL16CS s2.txt > s2temp.txt && mv s2temp.txt s2.txt
  
#Removing the subject codes from sem 1 results
sed -i 's/MA101(/ /g' s1.txt
sed -i 's/),PH100(/ /g' s1.txt
sed -i 's/),BE103(/ /g' s1.txt
sed -i 's/),EE100(/ /g' s1.txt
sed -i 's/),BE110(/ /g' s1.txt
sed -i 's/),CS110(/ /g' s1.txt
sed -i 's/),PH110(/ /g' s1.txt
sed -i 's/),BE10105(/ /g' s1.txt
sed -i 's/),EE110(/ /g' s1.txt
sed -i 's/)//g' s1.txt
sed -i 's/\o14//g' s1.txt

#Removing the subject codes from sem 2 results
sed -i 's/^L//g' s2.txt
sed -i 's/CY100(/ /g' s2.txt
sed -i 's/),BE100(/ /g' s2.txt
sed -i 's/),EC100(/ /g' s2.txt
sed -i 's/),CY110(/ /g' s2.txt
sed -i 's/),EC110(/ /g' s2.txt
sed -i 's/),MA102(/ /g' s2.txt
sed -i 's/),BE102(/ /g' s2.txt
sed -i 's/),CS100(/ /g' s2.txt
sed -i 's/),CS120(/ /g' s2.txt
sed -i 's/)//g' s2.txt
sed -i 's/\o14//g' s2.txt

>sgpa1.txt
>sgpa2.txt

mapfile > s1.txt
for l in 'seq 0 123';
do 
	t=(${MAPFILE[$l]});
	s=0;
	c=0;
	temp=0;
	for t in "${t[@]};
	do 
		case $c in 
			1)let temp=4;;
			2)let temp=4;;			
			3)let temp=3;;
			4)let temp=3;;
			5)let temp=3;;
			6)let temp=3;;
			7)let temp=1;;
			8)let temp=1;;
			9)let temp=1;;
		esac
		case $t in
			"O")s=$(printf "%f" "$(echo "$s + $temp * 10"| bc -l)");;
			"A+")s=$(printf "%f" "$(echo "$s + $temp * 9"| bc -l)");;
			"A")s=$(printf "%f" "$(echo "$s + $temp * 8.5"| bc -l)");;
			"B+")s=$(printf "%f" "$(echo "$s + $temp * 8"| bc -l)");;
			"B")s=$(printf "%f" "$(echo "$s + $temp * 7"| bc -l)");;
			"C")s=$(printf "%f" "$(echo "$s + $temp * 6"| bc -l)");;
			"P")s=$(printf "%f" "$(echo "$s + $temp * 5"| bc -l)");;
			"F");;
			"FE");;
			"I");;
			*)roll=$t
		esac
		let c=c+1;
	done
	s=$(printf "%.1f" "$(echo "$s/23" | bc -l;)")
	echo "$roll $s" >> sgpa1.txt;
done

mapfile < S2.txt;
for l in `seq 0 122`;
do
        ARRAY=(${MAPFILE[$l]});
        s=0;
	c=0;
	temp=0;
        for t in "${ARRAY[@]}";
        do
               case $c in
                        1)let temp=4;;
                        2)let temp=4;;
                        3)let temp=3;;
                        4)let temp=1;;
                        5)let temp=1;;
                        6)let temp=4;;
                        7)let temp=3;;
                        8)let temp=3;;
                        9)let temp=1;;
                esac
                case $t in
                        "O")s=$(printf "%f" "$(echo "$s + $temp * 10"| bc -l)");;
                        "A+")s=$(printf "%f" "$(echo "$s + $temp * 9"| bc -l)");;
                        "A")s=$(printf "%f" "$(echo "$s + $temp * 8.5"| bc -l)");;
                        "B+")s=$(printf "%f" "$(echo "$s + $temp * 8"| bc -l)");;
                        "B")s=$(printf "%f" "$(echo "$s + $temp * 7"| bc -l)");;
                        "C")sum=$(printf "%f" "$(echo "$sum + $temp * 6"| bc -l)");;
                        "P")sum=$(printf "%f" "$(echo "$sum + $temp * 5"| bc -l)");;
                        "F");;
                        "FE");;										
			"I");;
                        *)roll=$t
                esac
                let c=c+1;
        done
        s=$(printf "%.1f" "$(echo "$s/24" | bc -l;)")
        echo "$roll $s" >> sgpa2.txt;
done

(> TotalCGPA.txt)
#Calculate SGPA
paste S1SGPA.txt S2SGPA.txt | awk '{printf "%s %.1f\n",$1, ($2*23+$4*24)/47}' > TotalCGPA.txt
#Download student list
(wget -q http://14.139.184.212/ask/c4b/c4b.txt -O c4b.txt)
#Join all 3 files
(cut -f 4- c4b.txt > c4b1.txt)
(join <(sort TotalCGPA.txt) <(sort S1SGPA.txt) | join - <(sort S2SGPA.txt) | join - <(sort c4b1.txt)  > tmpCGPA.txt )
(mv tmpCGPA.txt TotalCGPA.txt)

