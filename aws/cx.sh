w
# AWS Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
EMR_CLUSTER_ID="xxx"



echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 01 : AWS Configure
echo 02 : AWS S3 List
echo 03 : AWS Assume Role
echo ----------------------------------------------
echo 10 : AWS IAM List Users
echo 11 : AWS IAM List Roles
echo 12 : AWS IAM List Groups
echo 13 : AWS IAM List Policies
echo 14 : AWS IAM List access-keys
echo ----------------------------------------------
echo 20 : AWS ORGANIZATIONS List Accounts
echo 21 : AWS ORGANISATIONS List Roots
echo ----------------------------------------------
echo 30 : AWS EC2 Describe Regions-List
echo 31 : AWS EC2 Describe Instances
echo 32 : AWS EC2 Describe Instances Details
echo 33 : AWS EC2 Describe Images
echo 34 : AWS EC2 Describe Security Groups
echo ----------------------------------------------
echo 40 : AWS EC2 Describe NAT Gateways
echo 41 : AWS EC2 Describe VPCs
echo 42 : AWS EC2 Describe Transit Gateways
echo ----------------------------------------------
echo 60 : AWS Lambda Account Settings
echo 61 : AWS Lambda List Functions
echo 62 : AWS Lambda List Layers
echo ----------------------------------------------
echo 70 : AWS Cloudwatch 
echo 71 : AWS Cloudwatch
echo ----------------------------------------------
echo 80 : AWS EMR list-cluster
echo 81 : AWS EMR list-instances
echo 82 : AWS EMR list-steps
echo 83 : AWS EMR describe-cluster
echo 83 : AWS EMR describe-step
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
echo Your profile is : $PROFILE.


case "$SELECTION" in
"01" )
  echo "===== AWS Configure - Setup"
  aws configure
  ;;


"02" )
  echo "===== AWS S3 List:" $PROFILE
  aws s3 ls --profile $PROFILE
  echo "Count:"
  aws s3 ls --profile $PROFILE | wc -l

  #aws s3 ls s3://bucketname
  #aws s3 cp 
  # aws s3 sync local s3://remote
  ;;


"03" )
  echo "===== AWS Assume Role:" $PROFILE
  # aws sts assume-role --role-arn "arn:aws:iam::xxxxxxxxxxxx:role/AWSAdmin" --role-session-name AWSCLI-Session
  # aws sts get-caller-identity --profile ipadev 
  ;;

    
"10" )
  echo "===== AWS IAM List Users:" $PROFILE
  aws iam list-users \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"11" )
  echo "===== AWS IAM List Roles:" $PROFILE
  aws iam list-roles \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"12" )
  echo "===== AWS IAM List Groups:" $PROFILE
  aws iam list-groups \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"13" )
  echo "===== AWS IAM List Policies:" $PROFILE
  aws iam list-policies \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"14" )
  echo "===== AWS IAM List Access Keys:" $PROFILE
  aws iam list-access-keys \
    --user-name terence.chia
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"20" )
  echo "===== AWS ORGANIZATIONS  List Accounts:" $PROFILE
  aws organizations list-accounts \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"21" )
  echo "===== AWS ORGANIZATIONS  List Roots:" $PROFILE
  aws organizations list-roots \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"30" )
  echo "===== AWS ec2 List Regions"
  aws ec2 describe-regions \
    --query 'Regions[].RegionName' \
    --output $OUTPUT \
    --profile $PROFILE;
  ;;


"31" )
  echo "===== AWS ec2 List Instances"
  aws ec2 describe-instances \
    --filter Name=tag-key,Values=Name \
    --query 'Reservations[*].Instances[*].{
        Instance:InstanceId,
        AZ:Placement.AvailabilityZone,
        Name:Tags[?Key==`Name`]|[0].Value
      }' \
    --output text \
    --profile $PROFILE;
  ;;

"32" )
  echo "===== AWS ec2 List Instances Detailed"
  aws ec2 describe-instances \
    --profile $PROFILE \
    --output table \
    --region $REGION \
    --filter Name=tag-key,Values=Name \
    --query "Reservations[*].Instances[*].{
        Instance:InstanceId,
        Type:InstanceType,
        AZ:Placement.AvailabilityZone,
        KeyName:KeyName,
        Name:Tags[?Key==\`Name\`]|[0].Value,
        Project:Tags[?Key==\`project\`]|[0].Value,
        IP:PublicIpAddress,
        State:State.Name,
        CPUcores:CpuOptions.CoreCount,
        CPUThreads:CpuOptions.ThreadsPerCore
      }" 
  ;;


"33" )
  echo "===== AWS EC2 List Images" $PROFILE
  aws ec2 describe-images \
    --owners self \
    --query 'reverse(sort_by(Images,&CreationDate))[:5].{id:ImageId,date:CreationDate}' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"34" )
  echo "===== AWS EC2 Describe Security Groups" $PROFILE
  aws ec2 describe-security-groups \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"40" )
  echo "===== AWS EC2 Describe NAT Gateways" $PROFILE
  aws ec2 describe-nat-gateways \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"41" )
  echo "===== AWS EC2 Describe VPCs" $PROFILE
  aws ec2 describe-vpcs \
    --profile $PROFILE \
    --output $OUTPUT
  ;;



"42" )
  echo "===== AWS EC2 Describe Transit Gateways" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"60" )
  echo "===== AWS Lambda Get Account Settings"
  aws lambda get-account-settings \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"61" )
  echo "===== AWS Lambda List Functions"
  aws lambda list-functions \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"62" )
  echo "===== AWS Lambda List Layers"
  aws lambda list-layers \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"70" )
  echo "===== AWS CLOUDWATCH List Metrics:" $PROFILE
  aws cloudwatch list-metrics \
    --namespace "AWS/Lambda" \
    --profile $PROFILE \
    --output text
  ;;


"71" )
  echo "===== AWS CLOUDWATCH List Dashboards:" $PROFILE
  aws cloudwatch list-dashboard \
    --profile $PROFILE \
    --output table
  ;;


"80" )
  echo "===== AWS EMR list-cluster"
  aws emr list-clusters \
    --active \
    --profile $PROFILE \
    --output table
  ;;


"81" )
  echo "===== AWS EMR list-instances"
  aws emr list-instances \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"82" )
  echo "===== AWS EMR list-steps:" $PROFILE
  aws emr list-steps \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"83" )
  echo "===== AWS EMR describe-cluster"
  aws emr describe-cluster \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"84" )
  echo "===== AWS EMR describe-steps"
  aws emr describe-steps \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
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


