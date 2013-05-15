#!/bin/bash

if [ "$#" != 3 ]
then
	echo "This is a small script that sets permissions to a user for a specific folder."
	echo "The permissions of the parent folders are alse modified so the user can reach the folder."
	echo ""
	echo "Usage:"
	echo "add_user.sh <user_name> <dir_name> <permission>"
	echo "	user_name: The name of the user you wish to give read/write/execute permissions"
	echo "	dir_name: The directory you wish to change persissions (use RELATIVE path)"
	echo "	permission: The permission you want to set for the user (i.e.: rwx, -wx, --x, etc...)"
	echo ""
	exit
fi 

user_name=$1
dir_name=$2
permission=$3

dir_name=$(pwd)/$dir_name

setfacl -m u:$user_name:$permission $dir_name
setfacl -d -m u:$user_name:$permission $dir_name
dir_name=$(dirname $dir_name)

while [ -w "$dir_name" ]
do
	setfacl -m u:$user_name:--x $dir_name
	setfacl -d -m u:$user_name:--x $dir_name
	dir_name=$(dirname $dir_name)
done
