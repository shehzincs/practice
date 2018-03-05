#converting the pdf results to text file without changing the layout 
pdftotext -layout s1.pdf s1.txt
pdftotext -layout s2.pdf s2.txt

#Removing all spaces and newline from the text file 
tr -d ' \n\r'< s1.txt  > s1temp.txt && mv s1temp.txt s1.txt
tr -d ' \n\r'< s2.txt  > s2temp.txt && mv s2temp.txt s2.txt

sed -i 's/MDL16CS/\nMDL16CS/g' s1.txt
sed -i 's/MDL16CS/\nMDL16CS/g' s2.txt 

grep MDL16CS s1.txt > s1temp.txt && mv s1temp.txt s1.txt
grep MDL16CS s2.txt > s2temp.txt && mv s2temp.txt s2.txt
  
sed -i 's/MA101(/ /g' s1.txt
sed -i 's/,)PH100(/ /g' s1.txt
sed -i 's/),PH100(/ /g' s1.txt
sed -i 's/),BE103(/ /g' s1.txt
sed -i 's/),EE100(/ /g' s1.txt
sed -i 's/),BE110(/ /g' s1.txt
sed -i 's/),CS110(/ /g' s1.txt
sed -i 's/),PH110(/ /g' s1.txt
sed -i 's/),BE10105(/ /g' s1.txt
sed -i 's/),EE110(/ /g' s1.txt
sed -i 's/)//g' s1.txt

sed -i 's/MA101(/ /g' s1.txt
sed -i 's/,)PH100(/ /g' s1.txt
sed -i 's/),PH100(/ /g' s1.txt
sed -i 's/),BE103(/ /g' s1.txt
sed -i 's/),EE100(/ /g' s1.txt
sed -i 's/),BE110(/ /g' s1.txt
sed -i 's/),CS110(/ /g' s1.txt
sed -i 's/),PH110(/ /g' s1.txt
sed -i 's/),BE10105(/ /g' s1.txt
sed -i 's/),EE110(/ /g' s1.txt
sed -i 's/)//g' s1.txt


