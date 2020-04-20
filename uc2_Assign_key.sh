#!/usr/bin/bash
declare -a board
#set -x

	for((row=1;row<=3;row++))
	do
		for ((column=1;column<=3;column++))
		do
			board[ $(($row *3 +$column))]="."
		done
	done	
echo ${board[@]}
echo "board"

Assigning()
{
	Assign=$((RANDOM%2))
	if (( $Assign == 1 ))
	then
		player=X
		computer=0
	else
		computer=X
		player=0
	fi
	
}
Assigning
echo "the player is assingned with " $player
