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
		
