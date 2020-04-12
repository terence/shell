# Azure Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
REMOTE="ipa"


echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : AZ List
echo 02 : AZ xx
echo 03 : AZ xx
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

echo Your selection is : $SELECTION.
echo Your remote is : $REMOTE.


case "$SELECTION" in
# Note variable is quoted.

"01" )
  echo "===== AZ Listing"
  ;;


"02" )
  echo "===== AZ xxx"
  ;;
    
"03" )
  echo "===== AZ xxx"
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
6
