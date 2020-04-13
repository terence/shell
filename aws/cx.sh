# AWS Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast2"
OUTPUT="json"

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : AWS Configure
echo 02 : AWS S3 List
echo 03 : AWS Assume Role
echo 04 : AWS IAM List Users
echo 05 : AWS IAM Organisation
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
  PROFILE=$2
else
  read  -n  PROFILE
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
  aws s3 ls
  #aws s3 ls s3://bucketname
  #aws s3 cp 
  # aws s3 sync local s3://remote
  ;;

"03" )
  echo "===== AWS Assume Role"
  # aws sts assume-role --role-arn "arn:aws:iam::xxxxxxxxxxxx:role/AWSAdmin" --role-session-name AWSCLI-Session
  # aws sts get-caller-identity --profile ipadev 
  ;;
    
"04" )
  echo "===== AWS IAM List Users"
  aws iam list-users --profile $PROFILE --output $OUTPUT
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


