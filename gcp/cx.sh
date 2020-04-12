# gcloud Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
REMOTE="ipa"


echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : gcloud Login
echo 02 : gcloud xx
echo 03 : gcloud xx
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
  echo "===== gcloud Login"
  glcoud init
  ;;


"02" )
  echo "===== gcloud xxx"
  ;;
    
"03" )
  echo "===== gcloud xxx"
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
# Exit
# ------------------------------------------------
* )
  # Default option.
  # Empty input (hitting RETURN) fits here, too.
  echo
  echo "Not a recognized option."
  ;;
esac



