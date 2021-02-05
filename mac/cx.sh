#!/bin/bash
#================================================================
# Command-line Assistant - cx.sh
#================================================================
clear
#source ./vars.sh
#source ./functions.sh
 
USER=$(whoami)
HOSTNAME=$(hostname)
NOW=$(date +"%Y%m%d") 
 
# Set Variables
SSH_DIR=~/.ssh
 
 
echo =============================================================
echo Hi $USER@$HOSTNAME. Welcome to MacOS management
echo What do you want to do?
echo -------------------------------------------------------------
echo 00: List Users on Mac
echo 01: Create User
echo 02: Delete User
echo -------------------------------------------------------------
echo 10: Manage screentime
echo 88: xxx
echo qq: Exit [Quit]
echo Enter [Selection] to continue
echo =============================================================
 
# Command line selection
if [ -n "$1" ]; then
  SELECTION=$1
else
  read  -n 3 SELECTION
fi
 
if [ -n "$2" ]; then
  PROFILE=$2
fi
 
echo Your selection is : $SELECTION.
echo Your profile is : $PROFILE.
 
 
case "$SELECTION" in
# Note variable is quoted.
 
  "00" )
  echo ===========================================================
  echo List Users on Mac
  echo ===========================================================
  echo "dscl user list"
  dscl . list /Users | grep -v '_'
  echo "fdesetup user list"
	sudo fdesetup list
	;;


  "01" )
  echo ===========================================================
  echo Create User
  echo ===========================================================
  sudo sysadminctl -addUser bob -fullName "Bobby Builder" -password buildit -hint "pooky" -home /Users/bob -shell /bin/bash 
  # sudo sysadminctl -resetPasswordFor bob -newPassword builder -passwordHint "Pooky?"



	# sudo dscl . -create /Users/bob ReadName "Bob Builder" IsHidden 0 UserShell /bin/bash NFSHomeDirectory /Users/bob
	# sudo dscl . -passwd /Users/bob builder
	# echo "Makes user an admin"
  # sudo dscl . -append /Groups/admin GroupMembership bob
  ;;
 

  "02" )
  echo ===========================================================
  echo Delete User
  echo ===========================================================
   echo "bob deleted using sysadminctl"
  sudo sysadminctl -deleteUser bob

  # echo "bob deleted"
	# sudo dscl . -delete "/Users/bob"
  ;;



 
  "10" )
  echo ===========================================================
  echo Manage screentime
  echo ===========================================================
  # Currently no mechanisms to manage screentime programmatically on MacOS.

	;;
 

   * )
   # Default option.   
   # Empty input (hitting RETURN) fits here, too.
   echo
   echo "Not a recognized option."
  ;;
 
esac

