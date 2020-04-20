#!/usr/bin/bash
echo "resetting the table as all dots"
declare -a table

resetting()
{
	for((row=1;row<=3;row++))
	do
		for ((column=1;column<=3;column++))
		do
			table[ $(($row *3 +$column))]="."
		done
	done	

echo ${table[@]}

}
resetting