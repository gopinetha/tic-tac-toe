#!/usr/bin/bash
declare -a table
#set -x
tablereset(){
table=( . . . . . . . . . )
}


Assigning()
{
echo "take a choice like 0 as heads nd 1 as tails"
read -p "enter 0 or 1 " choose
	Assign=$((RANDOM%2))
	if (( $Assign == $choose ))
	then
		player_1=X
		player_2=0
	else
		player_1=0
		player_2=X
	fi
	
}


printboard()
{
	echo "_____________"
	echo "| " ${table[0]}" | " ${table[1]} " | " ${table[2]} " | "
	echo "_____________"
	echo "| " ${table[3]}" | " ${table[4]} " | " ${table[5]} " | "
	echo "_____________"
	echo "| " ${table[6]}" | " ${table[7]} " | " ${table[8]} " | "
	echo "_____________"
}

printboard


check(){
	if [ ${table[$1]} != "." ] && [ ${table[$1]} == ${table[$2]} ] && [ ${table[$2]} == ${table[$3]} ]; 
	then
	 printboard
		echo "the winner is "
		if (( ${table[$1]} == $player_1 ))
		then
			echo "$player_1"
			
		else
			echo "$computer"
			exit;
		fi
	fi
	
}

checkgame(){
	check 0 1 2
	check 3 4 5
	check 6 7 8
	check 0 3 6
	check 1 4 7
	check 2 5 8
	check 0 4 8
	check 2 4 6
}

 fullbox()
 {
	for ((box=0;box<8;box++))
	do
		if [ ${table[$box]} == "." ]
		then
			return 
		fi
	done
		echo "the match is tie" 
		exit;
 }
movement()
{
	read -p "enter the cell no" cellno
	#read -p "enter row number : " rw
	#read -p "enter column number : " clmn
	
	#pos=$((rw*3+clmn))
	#check already filled or not
	if [ ${table[$cellno]} != "." ]
	then
		echo "the cell already filled"
			movement
	else	
		table[$cellno]=$1
	fi
}

computer()
{
x=$((RANDOM%9))
if [ ${table[$x]} != "."]
then	computer $1
else
	table[$x]=$1
fi

}
Game()
{
plr_1=$1
	
	if(( $plr_1==X ))
	then
		plr_2=0
	else
		plr_2=X
	fi
	if(($1==$player_1))
	then
		firstplr=player_1
		secondplr=player_2
	else
		firtplr=player_2
		secondplr=player_1
	fi
	for((move=0;move<9;move++))
	do
		if (( move%2 == 0 ));
		then
			echo "the $firstplr turn :-"
			movement $plr_1
			checkgame
			printboard
			fullbox
		else
			echo "the $secondplr turn :-"
			computer $plr_2
			checkgame
			printboard
			fullbox
		fi
	done
	
}



tossforplay()
{
	toss=$((RANDOM%2))
	if(( $toss == 1 ))
	then
		echo "The player_1 starts the game" 
		Game $player_1 
	else
		echo "The player_2 starts the game"
		Game $player_2 
	fi
	
}
tablereset

Assigning
		echo "player 1 is assigned with $player_1"
		echo "player 2 is assigned with $player_2"

tossforplay

