#!/usr/bin/bash
declare -a table
#set -x

	for((row=0;row<3;row++))
	do
		for ((column=0;column<3;column++))
		do
			table[ $(($row *3 +$column))]="."
		done
	done	
echo ${table[@]}
echo "table"

Assigning()
{
	Assign=$((RANDOM%2))
	if (( $Assign == 1 ))
	then
		player_1=X
		player_2=0
	else
		player_1=0
		player_2=X
	fi
	
}
Assigning
		echo "player 1 is assigned with player_1"
		echo "player 2 is assigned with $player_2"


tossforplay()
{
	toss=$((RANDOM%2))
	if(( $toss == 1 ))
	then
		echo "The player_1 starts the game" 
		
	else
		echo "The player_2 starts the game"
		
	fi
}
tossforplay

board()
{
	echo "__________________"
	echo "| " ${table[0]}" | " ${table[1]} " | " ${table[2]} " | "
	echo "__________________"
	echo "| " ${table[3]}" | " ${table[4]} " | " ${table[5]} " | "
	echo "__________________"
	echo "| " ${table[6]}" | " ${table[7]} " | " ${table[8]} " | "
	echo "__________________"
}
board