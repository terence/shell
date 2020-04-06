# Repo Management Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
REMOTE="ipa"
FILTER="extensive"
REPOLIST="repo-migration-list.txt"


echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : PULL ALL repos from source + Report Stats
echo 02 : PUSH ALL repos to destination (single branch)
echo 03 : MIRROR PULL ALL repos - source
echo 04 : MIRROR PUSH ALL repos - destination
echo ----------------------------------------------
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
  echo Executing PULL ALL repos
  for i in `ls | grep $FILTER`;
  do
    echo "--- Pulling $i";
    cd $i;
    echo "==== File Count =================="
    git ls-files | wc -l;
    echo "==== File List ===================="
    git ls-files | xargs wc -l;
    echo "==== Authors ======================"
    git ls-files | while read f; do git blame -w --line-porcelain -- "$f" | grep -I '^author '; done | sort -f | uniq -ic | sort -n
    echo "==== Object Summary ==============="
    git count-objects -v -H;
    echo "==== Git Log ======================"
    git log --pretty=format:'%C(Yellow)%h -%C(red)%d%Creset %s %C(green)%ad(%cr) %C(cyan)<%an>%Creset' --decorate --graph --date=short
    #git log --pretty=oneline --decorate --graph
    echo "==== Branches ====================="
    git remote -v;
    echo "====Remote List ==================="
    git remote -v;
    
    # git pull origin --all;
    cd ..;
    echo "--- Finished";
  done
  ;;


"02" )
  echo "PUSH ALL repos"
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


"03" )
  echo "MIRROR PULL all repos"
  while read p; do
    echo "${p%%/}"
    git clone --mirror https://xxx@bitbucket.org/sourceorg/${p%%/}.git
    echo "git clone --mirror https://xxx@bitbucket.org/sourceorg/${p%%/}.git"
  done < $REPOLIST
  ;;


"04" )
  echo "MIRROR PUSH all repos"
  while read p; do
    echo "${p%%/}"
    cd ${p%%/}.git/;
    git push --mirror https://user@github.com/destinationorg/${p%%/}.git
    echo "git push --mirror https://user@github.com/destinationorg/${p%%/}.git"
    cd ..;
  done < $REPOLIST
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
