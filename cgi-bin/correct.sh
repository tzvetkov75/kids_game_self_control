
r=$(cat ./db/rest.txt) 

echo "rest time in $(($r / 60 )) minutes"

echo "How many minutes to add ?"

read a

echo $((r+a*60)) > ./db/rest.txt

r=$(cat ./db/rest.txt) 

echo "rest time in $(($r / 60 )) minutes"
