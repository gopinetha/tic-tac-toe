#constants
NUM_OF_ROWS=3
NUM_OF_COLUMNS=3
#variables
numOfTurns=0
gameStatus=1
declare -A board

resetBoard(){
	for ((row=0;row<$NUM_OF_ROWS;row++))
	do
		for ((column=0;column<$NUM_OF_COLUMNS;column++))
		do
			board[$row,$column]=.
		done
	done
}

printBoard(){
	echo "------------------"
	echo "| " ${board[0,0]}" | " ${board[0,1]} " | " ${board[0,2]} " | "
	echo "------------------"
	echo "| " ${board[1,0]}" | " ${board[1,1]} " | " ${board[1,2]} " | "
	echo "------------------"
	echo "| " ${board[2,0]}" | " ${board[2,1]} " | " ${board[2,2]} " | "
	echo "------------------"
}

checkWinningConditions(){
	#checking row
	for (( rows=0; rows<$NUM_OF_ROWS; rows++ ))
	do
		if [ ${board[$rows,0]} != "." ]
		then
			count=1
			for (( columns=1; columns<$NUM_OF_COLUMNS; columns++ ))
			do
				if [ ${board[$rows,0]} == ${board[$rows,$columns]} ]
				then
					((count++))
				fi
			done
			if [ $count = $NUM_OF_COLUMNS ]
			then
				gameStatus=0
				return;
			fi
		fi
	done

#checking column
for (( columns=0; columns<$NUM_OF_COLUMNS; columns++ ))
do
	if [ ${board[0,$columns]} != "." ]
	then
		count=1
		for (( rows=1; rows<$NUM_OF_ROWS; rows++ ))
		do
			if [ ${board[0,$columns]} == ${board[$rows,$columns]} ]
			then
				((count++))
			fi
		done
		if [ $count = $NUM_OF_ROWS ]
		then
			gameStatus=0
			return;
		fi
	fi
done
#check diagonal
tempColumn=$(($NUM_OF_COLUMNS-2))
if [ ${board[0,$(($NUM_OF_COLUMNS-1))]} != "." ]
then
	count=1
	for (( rows=1; rows<$NUM_OF_ROWS; rows++ ))
	do
		if [ ${board[0,$(($NUM_OF_COLUMNS-1))]} == ${board[$rows,$tempColumn]} ]
		then
			((count++))
        fi
		tempColumn=$(($tempColumn-1))
	done
	if [ $count = $NUM_OF_ROWS ]
	then
		gameStatus=0
		return;
	fi
fi

}

ComputerMove(){
	#check whether computer can win with a move
	for (( row=0; row<$NUM_OF_ROWS; row++ ))
	do
		for (( column=0; column<$NUM_OF_COLUMNS; column++ ))
		do
		if [ ${board[$row,$column]} = "." ]
		then
			board[$row,$column]=$computer
			checkWinningConditions
			if [ $gameStatus = 1 ]
			then
				board[$row,$column]=.
			else
				echo The $player won the game
                printBoard
				exit
			fi
		fi
		done
	done
	#check whether opponent win with a move and block it
       	for (( row=0; row<$NUM_OF_ROWS; row++ ))
        do
            for (( column=0; column<$NUM_OF_COLUMNS; column++ ))
            do
                if [ ${board[$row,$column]} = "." ]
              	then
                    board[$row,$column]=X
	               	checkWinningConditions
                  	if [ $gameStatus != 0 ]
                    then
                     	board[$row,$column]=.
				else
					board[$row,$column]=$computer
					gameStatus=1
					return;
	                        fi
                        fi
                done
        done
	#option 3 - move to corners of board
	if [ ${board[0,0]} = "." ]
        then
                board[0,0]=$computer
		return
	elif [ ${board[$(($NUM_OF_ROWS-1)),0]} = "." ]
        then
                board[$(($NUM_OF_ROWS-1)),0]=$computer
		return
        elif [ ${board[0,$(($NUM_OF_COLUMNS-1))]} = "." ]
        then
                board[0,$(($NUM_OF_COLUMNS-1))]=$computer
                return
	elif [ ${board[$(($NUM_OF_ROWS-1)),$(($NUM_OF_COLUMNS-1))]} = "." ]
	then
		board[$(($NUM_OF_ROWS-1)),$(($NUM_OF_COLUMNS-1))]=$computer
                return
	# option 4 - move to centre of the board
        elif [ ${board[$(($NUM_OF_ROWS/2)),$(($NUM_OF_COLUMNS/2))]} = "." ]
        then
		board[$(($NUM_OF_ROWS/2)),$(($NUM_OF_COLUMNS/2))]=$computer
		return
	fi
	#option 5 - move across sides of the board
	for (( row=0; row<$NUM_OF_ROWS; row++ ))
        do
               	for (( column=0; column<$NUM_OF_COLUMNS; column++ ))
               	do
                       	if [ ${board[$row,$column]} = "." ]
                       	then
                               	board[$row,$column]=$computer
                               	return;
			fi
		done
	done
}

PlayerMove(){
	echo Your turn with letter $1
	echo Choose your cell
	read -p "Enter row number " row
	read -p "Enter column number " column

	if [ ${board[$(($row-1)),$(($column-1))]} = "." ]
	then
		board[$(($row-1)),$(($column-1))]=$1
	else
		echo Invalid cell
		PlayerMove
	fi
}
#Assigning X or 0 to the player nd computer
Assigning()
{	Assign=$((RANDOM%2))
	if (( $Assign == 1 ))
	then
		player=X
		computer=0
	else
		player=0
		computer=X
	fi
		echo "player 1 is assigned with $player"
		echo "computer is assigned with $computer"
}
TossForTurn()
{
	toss=$((RANDOM%2))
	if(( $toss == 1 ))
	then
		echo "The player_1 starts the game" 
		start $player_1 
	fi
	
}
	resetBoard
	Assigning
	TossForTurn
	printBoard
start(){

	for((i=0;i<10;i++))
	do
		numOfTurns=$(($numOfTurns+1))
		if [ $(($i%2)) == 0 ]
		then
			PlayerMove $player
			checkWinningConditions
			printBoard
		else
			echo Computer turn with letter $computer
			ComputerMove $computer
			printBoard
		fi

		if [ $gameStatus = 0 ]
		then
			echo The player $computer won the game
			printBoard
			exit;
		elif [ $numOfTurns = $(($NUM_OF_ROWS*$NUM_OF_COLUMNS)) ]
        	then
			printBoard
			exit;
		fi
	done
}
start