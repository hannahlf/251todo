#!/bin/bash
if ! [ -d todo ]; then
	mkdir todo
fi
if ! [ -d completed ]; then
	mkdir completed
fi
#cntr=1


function add(){
	#add new item to todo
	#my cntr is not working to name and create titles 	
	read contents
	cntr=0
	
	td=$(ls todo | wc -l)
	cm=$(ls completed | wc -l)
	cntr=$((cntr+td))
	cntr=$((cntr+cm))
	cntr=$((cntr+1))
	filename=$cntr
	if [ -f ${filename} ]; then
		echo "This file already exists"	
	fi
			
	title=$"$#"
	touch ${filename}.txt
	chmod 700 ${filename}.txt  
	echo $1 >> ${filename}.txt
	echo $contents >> ${filename}.txt
	echo $2 >> ${filename}.txt
	mv ${filename}.txt todo
	echo "item added to list!"
	echo "-----------------------------------"
	echo ""

}

function help() {
	#lists all the functions that can be run
	echo ""
	echo "This is a list of all the commands you can use"
	echo ""
	echo "help- pulls up a list of all valid commands"
	echo "list- list the uncompleted items with numbers"
	echo "complete (number) - mark the tiem with the given number as completed"
	echo "list completed- list the completed items"
	echo "add (title) - adds a new item with the given title"
	echo ""
	echo "--------------------------"
	echo ""
}

function list() {
	cntr=0
if [ "$1" == "completed" ]; then
		echo "list of all completed items"
		echo ""
		for file in completed/*; do
			if [ -f ${filename} ]; then
				cntr=$(($cntr+1))
				echo $cntr
				head -1 $file
			fi
		done
else
	echo "list of all uncompleted tasks"
	echo ""
	#cntr=0
	items=$(ls todo | wc -l) 
	if [ $items != 0 ]; then
		for file in todo/*; do
			if [ -f ${filename} ]; then
				cntr=$(($cntr+1))
				echo $cntr
				head -1 $file
				fi

			done
	else
		echo "There are no items on your todo list"
		echo "--------------------------------------"
		echo ""

	fi
fi
echo ""
}

function listCompleted() {
	echo "list of all completed tasks"
	echo ""
	cntr=0
	for file in completed/*; do
		if [ -f ${filename} ]; then
			cntr=$(($cntr+1))
			echo $cntr
			head -1 ${file}
		fi
	done
	echo "------------------------"
	echo ""
}

function complete(){

	echo $1
	if [ -f todo/$1 ]; then
		echo "File found"
		mv  todo/$1 completed
		echo "File moved to completed"
		echo "-------------------------"
		echo ""
	else 
		echo "File not found"
	fi
}

function menu() {
	cntr=1
	echo "Welcome to to-do list manager! Here are your current items: "
	echo "list of all uncompleted tasks"
	echo ""
	items=$(ls todo | wc -l)
	if [ $items != 0 ]; then
		for file in todo/*; do
			echo $cntr
			head -1 $file
			cntr=$((cntr+1))
			
		done
	else
		echo "There are no items on your todo list"
		echo "--------------------------------------"
		echo ""

	fi

	echo ""
	echo "What would you like to do?"
	echo "-----------------------------"
	echo "Enter the number of a task to see more information on it"
        echo "------------------------------"	
	echo "A) Mark an item as completed"
	echo "B) Add a new item"
	echo "C) See completed items"
	echo ""
	echo "Q) Quit and use command line arguments"

	read -p "Enter your choice: " i
	#add info on how to show details of this item
	#use cat on the file name for description
	cntr=1	
	for file in todo/*; do
		
		
	if [ "$i" == "$cntr" ]; then
		cat $file
		cntr=$((cntr+1))
	else
		cntr=$((cntr+1))
	
	fi

	done

		

	case "$i" in
		"A") 
		read -p "What number task would you like completed? " completeNum
		cntr=1	
		for file in todo/*; do
			if [ "$completeNum" == "$cntr" ]; then
				echo $completeNum
				mv  $file completed
				echo "File moved to completed"
				cntr=$((cntr+1))
			else	
				cntr=$((cntr+1))
			fi

		done	
		;;
	
        	"B")
		read -p "Enter a title for the new item:  " title 
		read -p "Enter the details for the new item: " contents 
		add "$title" "$contents"
		;;
                "C")		
		listCompleted
  		;;
	"Q" )
		exit
		;;
	*)
		echo "Please enter a valid command"
		help
				;;
esac
menu

}

if [ "$#" == "0" ]; then
	menu
elif [ "$#" != "0" ]; then
	if [ "$1" == "help"  ]; then
		"$1" "$2"
		help
	elif [ "$1" == "add" ]; then
		"$1" "$2"
	elif [ "$1" == "list" ]; then
		"$1"
		
		if [ "$2" == "completed" ]; then
			"$1" "$2"
		fi
	elif [ "$1" == "listCompleted" ]; then
		"$1" "$2"
	
	elif [  "$1" == "complete" ]; then
		"$1" "$2"
		complete "$1"
	else 
		echo "Please enter a valid command"
	fi

	

else
	echo "Please enter a valid command"
	help
fi








