#!/bin/bash

Group(){
	echo "Enter name group"
		read group
	if grep $group /etc/group >> /dev/null; then
		clear
		echo "User $group exist "
	echo "- - - - - - - - group menu - - - - - - -"
	echo "Del group[ 1 ] Return main menu [main]" 
		read a 
		case $a in
		1) groupdel $group
		echo "Group $group deleted"
		menu
		;;
		2) 
		echo "new name" 
		read newName
		echo "new GID" 
		read newGID
		groupmod -n newName - g newGID
		;;
		main) menu
		;;
		*)
		esac
	else 
		clear	
	echo "- - - group menu - - -"
	echo "Add group -> [ 1 ]"
	echo "Return main menu [main]" 
		read a 
		case $a in
		1) groupadd $group
		echo "group $group aded"
		menu
		;;
		main) menu
		;;
		*)
		esac
fi
}


User(){
	echo "Enter name user"
		read user
	if grep $user /etc/passwd >> /dev/null; then
		clear
		echo "User $user exist "
	echo "- - - - - - - - user menu - - - - - - -"
	echo "Del user[ 1 ] || Mod user[ 2 ] || Return main menu [main]" 
		read a 
		case $a in
		1) userdel -r $user
		echo "User $user deleted"
		menu
		;;
		2) 
		echo "new name" 
		read newName
		echo "new group" 
		read newGroup
		echo "new comment" 
		read newComment
		usermod -c newComment -g newGroup -l newName
		;;
		main) menu
		;;
		*)
		esac
	else 
		clear	
	echo "- - - - - - - - user menu - - - - - - -"
	echo "Add user ->  defoult [ 1 ] custum [ 2 ]"
	echo "Return main menu [main]" 
		read a 
		case $a in
		1) useradd $user
		echo "User $user aded"
		menu
		;;
		2) echo "Enter UID" 
			read myUID
		while  grep $myUID /etc/passwd >> /dev/null; do
			echo "UID exist, Enter new  UID"
			read myUID

		done

		echo "Enter comment"
			read comment 
		echo "Enter home directory user $user"
			read dir
		useradd -u $myUID -c $comment -d $dir $user 
		echo "User $user aded"
		menu
		;;
		main) menu
		;;
		*)
		esac
fi
}


Help(){
	echo "# help  - help menu" 
	echo "# user  - user menu" 
	echo "# grp   - group menu" 
	echo "# exit  - exit program or 'q' alternative" 

}


menu(){
	eee=0
	Help
	while [ "$eee" == 0 ]; do 
	read b
	case $b in 
		user) User
		;;
		grp) Group
		;;
		help) Help
		;;
		clear) clear
		;;
		exit | q) eee=1
		;; 
		*)echo "error command"
	esac
	done
}
clear
menu
