https://stackoverflow.com/questions/26867277/print-unique-lines-based-on-field

Would like to print unique lines based on first field , keep the first occurrence of that line and remove duplicate other occurrences.

Input.csv

10,15-10-2014,abc
20,12-10-2014,bcd
10,09-10-2014,def
40,06-10-2014,ghi
10,15-10-2014,abc
Desired Output:

10,15-10-2014,abc
20,12-10-2014,bcd
40,06-10-2014,ghi

awk -F, '!seen[$1]++' Input.csv

echo "one\ntwo\ntwo\nthree " | awk -F, '!seen[$1]++' 

docker image ls --format '{{.Repository}}' | grep test | awk -F, '!seen[$1]++'


docker rmi $(docker image ls --format '{{.Repository}} {{.ID}}' | grep hello | awk '{ print $2}')

