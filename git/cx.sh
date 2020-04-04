# Repo Management Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : PULL ALL repos - source
echo 02 : PUSH ALL repos - destination
echo ----------------------------------------------
echo 99 : SECURITY SCRUB
echo Enter [Selection] to continue
echo =============================================================

# Command line selection
if [ -n "$1" ]; then
  SELECTION=$1
else
  read  -n 2 SELECTION
fi

if [ -n "$2" ]; then
  CLUSTER=$2
else
  read  -n  CLUSTER
fi
echo Your selection is : $SELECTION.
echo Your cluster is : $CLUSTER.

case "$SELECTION" in
# Note variable is quoted.

"01" )
  # Accept upper or lowercase input.
  echo PULL ALL repos
#  for i in `ls | grep a_filter`; do
  for i in `ls -d */`; do
    echo "--- Pulling $i";
    cd $i;
     git remote -v;
#    git pull origin --all;
    cd ..;
    echo "--- Finished";
  done
  ;;


"02" )
  echo PUSH ALL repos
  for i in `ls -d */`; do
    echo "--- Pushing $i";
    cd $i;
    git remote -v;
    cd ..;
    echo "---Finished";
  done
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

  # Attempt to cater for ESC


"\x1B" )
  echo ESC1
  exit 0
  ;;


# Attempt to cater for ESC
"^[" )
  echo ESC2
  exit 0
  ;;


# ------------------------------------------------
#  GIT
# ------------------------------------------------
* )
  # Default option.
  # Empty input (hitting RETURN) fits here, too.
  echo
  echo "Not a recognized option."
  ;;
esac
