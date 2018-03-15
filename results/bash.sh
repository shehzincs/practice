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
sed -i 's/ / \t/g' s1.txt
sed -i 's/ / \t/g' s2.txt

#Array containing the credits of all the 18 subjects in order
credits1=( 4 4 3 3 3 3 1 1 1 )
credits2=( 4 4 3 1 1 4 3 3 1 )

#Replacing Grade with corresponding points
#Sem 1
sed -i 's/O/10/g' s1.txt
sed -i 's/A+/9/g' s1.txt
sed -i 's/A/8.5/g' s1.txt
sed -i 's/B+/8/g' s1.txt
sed -i 's/B/7/g' s1.txt
sed -i 's/C /6/g' s1.txt
sed -i 's/P/5/g' s1.txt
sed -i 's/F/0/g' s1.txt
sed -i 's/FE/0/g' s1.txt
sed -i 's/I/0/g' s1.txt
#Sem 2
sed -i 's/O/10/g' s2.txt
sed -i 's/A+/9/g' s2.txt
sed -i 's/A/8.5/g' s2.txt
sed -i 's/B+/8/g' s2.txt
sed -i 's/B/7/g' s2.txt
sed -i 's/C /6/g' s2.txt
sed -i 's/P/5/g' s2.txt
sed -i 's/F/0/g' s2.txt
sed -i 's/FE/0/g' s2.txt
sed -i 's/I/0/g' s1.txt

#Calculating the Sgpa
awk '{ print ($1" "($2 * 4 + $3 * 4 + $4 * 3 + $5 * 3 + $6 * 3 + $7 * 3 + $8 * 1 + $9 * 1 + $10 * 1)/23)" " }' s1.txt>sgpa1.txt
awk '{ print ($1" "($2 * 4 + $3 * 4 + $4 * 3 + $5 * 1 + $6 * 1 + $7 * 4 + $8 * 3 + $9 * 3 + $10 * 1)/24) }' s2.txt>sgpa2.txt

#forming the cgpa
join sgpa1.txt sgpa2.txt>new.txt
sed -i 's/ /\t/g' new.txt

wget "http://14.139.184.212/ask/c4b/c4b.txt"
awk '{ print ($6" "$7" "$8" "$9" ")}' c4b.txt>c.txt
grep MDL16CS c.txt>s1temp.txt && mv s1temp.txt c.txt
join new.txt c.txt>temp.txt

#awk '{ print ($1" "$2" "$3" "$4" "(($3 + $4)/2))}' temp.txt>temp2.txt && mv temp2.txt temp.txt
#Arranging the file
awk '{ print ($4" "$5" "$6" "$7":"$1"\t"$2"\t"$3"\t"(($2+$3)/2)) }' temp.txt>temp1.txt

#Spacing the file
column -t -s":" temp1.txt>temp2.txt

#Removing unwnted files
mv temp2.txt final.txt
nano final.txt
