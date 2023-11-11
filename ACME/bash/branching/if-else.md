https://tecadmin.net/tutorial/bash-scripting/bash-if-else-statement/
#!/bin/bash
 
read -p "Enter your marks: " marks
 
if [ $marks -ge 80 ]
then
    echo "Very Good"
 
elif [ $marks -ge 50 ]
then
    echo "Good"
 
elif [ $marks -ge 33 ]
then
    echo "Just Satisfactory"
else
    echo "Not OK"
fi