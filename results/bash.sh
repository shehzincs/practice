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

#Replacing space with tab
sed -i 's/ /\t/g' s1.txt
sed -i 's/ /\t/g' s2.txt

#Array containing the credits of all the 18 subjects in order
credits1=( 4 4 3 3 3 3 1 1 1 )
credits2=( 4 4 3 1 1 4 3 3 1 )

while read -r line 
do 
	sum=0
	c=0
	while j in $line
	do	
		case j in 	
			"O") sum=$((10*${credit1[c++]} ));;
			"A+") sum=$((sum+9*${credit1[c++]} ));;
			"A") sum=$((sum+8*${credit1[c++]} ));;
 			"B+") sum=$((sum+7*${credit1[c++]} ));;
 			"B") sum=$((sum+6*${credit1[c++]} ));;
 			"C") sum=$((sum+5*${credit1[c++]} ));;
 			"P") sum=$((sum+4*${credit1[c++]} ));;
 			"F") sum=$((sum+0*${credit1[c++]} ));;
		
	
