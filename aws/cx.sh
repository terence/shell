# AWS Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
REMOTE="ipa"


echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : AWS Configure
echo 02 : AWS S3 List
echo 03 : AWS Assume Role
echo 04 : AWS Organisation
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
  echo "===== AWS Configure - Setup"
  aws configure
  ;;

"02" )
  echo "===== AWS S3 List"
  aws s3 list
  ;;

"03" )
  echo "===== AWS Assume Role"
  aws sts assume-role --role-arn "arn:aws:iam::xxxxxxxxx:role/AWSAdmin"
  ;;
    
"04" )
  echo "===== AWS Cloudwatch Logdump"
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


