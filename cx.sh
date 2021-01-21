#!/bin/bash
#================================================================
# Command-line Assistant - cx.sh
#================================================================
clear
source ./vars.sh
source ./functions.sh
 
USER=$(whoami)
HOSTNAME=$(hostname)
NOW=$(date +"%Y%m%d") 
 
# Set Variables
SSH_DIR=~/.ssh
 
 
echo =============================================================
echo Hi $USER@$HOSTNAME. Welcome to SSH management
echo What do you want to do?
echo -------------------------------------------------------------
echo 00: Deploy cx.sh to .ssh
echo 01: Deploy .bash_profile .bashrc .alias .zprofile .zhrc
echo 02: Deploy .vimrc .git .gitignore .gitconfig
echo -------------------------------------------------------------
echo 10: ssh-add List Keys
echo 11: ssh-add add Keys to ssh-agent
echo 12: ssh-add Flush Keys from ssh-agent
echo -------------------------------------------------------------
echo 20: ssh-keygen DSA Key
echo 21: ssh-keygen RSA Key
echo 22: ssh-keygen ECDSA Key
echo 23: ssh-keygen ed25519 Key
echo -------------------------------------------------------------
echo 50: Deploy aws config
echo 51: Deploy azure config
echo 52: Deploy gcp config
echo ----------------------------------------------
echo 88: xxx
echo 90: ZIP ssh directory
echo 91: UNZIP ssh directory
echo 99: LOCAL SECURITY SCRUB: checks ssh keys permissions
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
  echo Deploy cx.sh to .ssh
  echo ===========================================================
  func_create_ssh_dir
  if [[ ! -e ${SSH_DIR}/cx.sh ]]; then
    echo "cx.sh copied to .ssh dir"
    cp ./cx.sh ${SSH_DIR}/cx.sh
  else
    echo "cx.sh exists"
  fi
  ;;


  "01" )
  echo ===========================================================
  echo Deploy .bash_profile .alias
  echo ===========================================================
  if [[ ! -e ~/.bash_profile ]]; then
    echo ".bash_profile copies to ~/"
    cp ./.bash_profile ~/
  else
    echo "bash_profile exists"
  fi                     
  if [[ ! -e ~/.alias ]]; then
    echo "alias copied to ~/"
    cp ./.alias ~/
  else
    echo "alias exists"
  fi
 
  ;;
 
 
  "02" )
  echo ===========================================================
  echo Deploy .vimrc .git .gitignore .gitconfig
  echo ===========================================================
  
  if [[ ! -e ~/.vimrc ]]; then
    echo ".vimrc copied to ~/"
    cp ./.vimrc ~/
  else
    echo "vimrc exists"
  fi                  

  if [[ ! -e ~/.gitignore ]]; then
    echo ".gitignore copied to ~/"
    cp ./.gitignore ~/
  else
    echo "gitignore exists"
  fi
 
  if [[ ! -e ~/.gitconfig ]]; then
    echo ".gitconfig copied to ~/"
    cp ./.gitconfig ~/
  else
    echo "gitconfig exists"
  fi
  ;;
 
 
  "10" )
  echo ===========================================================
  echo List Keys in ssh-agent
  echo ===========================================================
  ssh-add -L
  echo ===========================================================
  ssh-agent -s
  ;;

 
  "11" )
  echo ===========================================================
  echo ssh-add Add Keys to ssh-agent
  echo ===========================================================
  ssh-add -K ~/.ssh/id_rsa
  ssh-add -K ~/.ssh/id_dsa
  ;;
 
 
  "12" )
  echo ===========================================================
  echo ssh-add Flush Keys from ssh-agent
  echo ===========================================================
  ssh-add -D
  ;;
 
  "21" )
  echo ===========================================================
  echo ssh-keygen RSA Key
  echo ===========================================================
  func_create_ssh_dir
  ssh-keygen -t rsa -b 4096 -C "$USER@$HOSTNAME" -f $SSH_DIR/keys/id_$USER_$HOSTNAME
  ;;

  "22" )
  echo ===========================================================
  echo ssh-keygen xxx Key
  echo ===========================================================
  func_create_ssh_dir
  ssh-keygen -t xxx -b 4096 -C "$USER@$HOSTNAME" -f $SSH_DIR/keys/id_$USER_$HOSTNAME
  ;;
 
 
  "90" )
  echo Zip up the .ssh dir
  cd ..
  tar -cvzf ${NOW}_ssh.tgz .ssh
  ;;  
  
  
  "91" )
  echo UnZip the keys
  ;;  


  "99" )
  echo SECURITY SCRUB
  # chmod 700 ~/.ssh directory
  # chmod 600 authorized_keys (if it exists on client machines)
  # chmod 600 id_*
  # chmod 644 *.pub
  cd ~/.ssh/
  chmod 700 ~/.ssh
  chmod 600 id* 
  chmod 644 id*.pub
  if [ -e ~/.ssh/authorized_keys ];then
    chmod 600 ~/.ssh/authorized_keys
  fi  
  ;;  


   * )
   # Default option.   
   # Empty input (hitting RETURN) fits here, too.
   echo
   echo "Not a recognized option."
  ;;
 
esac

