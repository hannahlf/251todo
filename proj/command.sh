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
	for file in todo/*; do
		if [ -f ${filename} ]; then
			cntr=0
			cntr=$(($cntr+1))
		fi
	done
	filename=$cntr	
	title=$"$1"
	touch ${filename}.txt
	echo $title >> ${filename}.txt
	echo $contents >> ${filename}.txt
	#chmod 700 ${filename}
 	mv ${filename}.txt todo

}

function help() {
	#lists all the functions that can be run
	echo "list- list the uncompleted items with numbers"
	echo "complete number- mark the tiem with the given number as completed"
	echo "list completed- list the completed items"
	echo "add title- adds a new item with the given title"
}

function list() {
	cntr=0
if [ "$1" == "completed" ]; then
		echo "list of all completed items"
		for file in completed/*; do
			if [ -f ${filename} ]; then
				cntr=$(($cntr+1))
				echo $cntr
				echo $file
			fi
		done
else
	echo "list of all uncompleted tasks"
	#cntr=0
	
	for file in todo/*; do
		if [ -f ${filename} ]; then
			cntr=$(($cntr+1))
			echo $cntr
			echo $file
		fi
	done
fi
}

function listCompleted() {
	echo "list of all completed tasks"
	cntr=0
	for file in completed/*; do
		if [ -f ${filename} ]; then
			cntr=$(($cntr+1))
			echo $cntr
			echo ${file}
		fi
	done
}

function complete(){
	echo $1
	if [ -f todo/$1 ]; then
		echo "File found"
	fi
#	for file in todo/*; do
#		echo $file
#		if [ -f $file ]; then
#			mv "$file" ../completed
#		else
#			echo "File does not exist"
#		fi
#	done	
}

function menu() {

	echo "Welcome to to-do lsit manager! Here are your current items: "
	list
	echo ""
	echo "What would you like to do?"
	echo "Enter the number of a task to see more information on it"
	echo "A) Mark an item as completed?"
	echo "B) Add a new item"
	echo "C) See completed items"

	echo "Q) Quit"

	read -p "Enter your choice: "i
	if [ "$i" == "A" ]; then
		complete
	fi
	if [ "$i" == "B" ]; then
		add
	fi
	if [ "$i" == "C" ]; then
		listCompleted
	fi



}

if [ "$#" != "0" ]; then
	"$1" "$2"
else
	echo "Please enter a valid command"
	help
fi






