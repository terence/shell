# Repo Management Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
REMOTE="ipa"
FILTER="extensive"


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
  REMOTE=$2
else
  read  -n  REMOTE
fi

if [ -n "$3" ]; then
  FILTER=$3
else
  read  -n  FILTER
fi


echo Your selection is : $SELECTION.
echo Your remote is : $REMOTE.
echo Your filter is : $FILTER.


case "$SELECTION" in
# Note variable is quoted.

"01" )
  # Accept upper or lowercase input.
  echo PULL ALL repos
#  for i in `ls | grep a_filter`; do
  for i in `ls -d */`; do
    echo "--- Pulling $i";
    cd $i;
    echo "Line Counts=================="
    git ls-files | xargs wc -l;
    echo "Authors======================"
    git ls-files | while read f; do git blame -w --line-porcelain -- "$f" | grep -I '^author '; done | sort -f | uniq -ic | sort -n
    echo "Object Summary==============="
    git count-objects -v -H;
    echo "Remote List=================="
    git remote -v;
       
#    git pull origin --all;
    cd ..;
    echo "--- Finished";
  done
  ;;


"02" )

  echo PUSH ALL repos
  for i in `ls -d */ | grep $FILTER`; do
    echo "--- Pushing ${i%%/}";
    cd $i;

    # List Remotes
    # git remote -v;

    # Add remotes
    echo "git remote add $REMOTE https://user@github.enterprise/ORG/${i%%/}.git"
    git remote remove $REMOTE;
    git remote add $REMOTE https://user@github.enterprise/ORG/${i%%/}.git

    # Push IT
    git push $REMOTE --all

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
