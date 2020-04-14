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
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS Assume Role
echo ----------------------------------------------
echo 010 : AWS IAM List Users
echo 011 : AWS IAM List Roles
echo 012 : AWS IAM List Groups
echo 013 : AWS IAM List Policies
echo 014 : AWS IAM List access-keys
echo ----------------------------------------------
echo 020 : AWS ORGANIZATIONS List Accounts
echo 021 : AWS ORGANISATIONS List Roots
echo ----------------------------------------------
echo 030 : AWS EC2 Describe Regions-List
echo 031 : AWS EC2 Describe Instances
echo 032 : AWS EC2 Describe Instances Details
echo 033 : AWS EC2 Describe Images
echo 034 : AWS EC2 Describe Security Groups
echo ----------------------------------------------
echo 040 : AWS EC2 Describe NAT Gateways
echo 041 : AWS EC2 Describe VPCs
echo 042 : AWS EC2 Describe Transit Gateways
echo ----------------------------------------------
echo 060 : AWS Lambda Account Settings
echo 061 : AWS Lambda List Functions
echo 062 : AWS Lambda List Layers
echo ----------------------------------------------
echo 070 : AWS Dynamo xxx
echo 071 : AWS Dynamo xxx
echo 072 : AWS Dynamo xxx
echo 073 : AWS Dynamo xxx
echo ----------------------------------------------
echo 080 : AWS EMR list-cluster
echo 081 : AWS EMR list-instances
echo 082 : AWS EMR list-steps
echo 083 : AWS EMR describe-cluster
echo 083 : AWS EMR describe-step
echo ----------------------------------------------
echo 110 : AWS Cloudwatch List Metrics
echo 111 : AWS Cloudwatch List Dashboards
echo 112 : AWS Cloudwatch Describe Alarms
echo ----------------------------------------------
echo 200 : AWS cloudfront list-distributions
echo ----------------------------------------------
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
else
  read  -n  PROFILE
fi

echo Your selection is : $SELECTION.
echo Your profile is : $PROFILE.


case "$SELECTION" in
"001" )
  echo "===== AWS Configure - Setup"
  aws configure
  ;;


"002" )
  echo "===== AWS S3 List:" $PROFILE
  aws s3 ls --profile $PROFILE
  echo "Count:"
  aws s3 ls --profile $PROFILE | wc -l

  #aws s3 ls s3://bucketname
  #aws s3 cp 
  # aws s3 sync local s3://remote
  ;;


"003" )
  echo "===== AWS Assume Role:" $PROFILE
  # aws sts assume-role --role-arn "arn:aws:iam::xxxxxxxxxxxx:role/AWSAdmin" --role-session-name AWSCLI-Session
  # aws sts get-caller-identity --profile ipadev 
  ;;

    
"010" )
  echo "===== AWS IAM List Users:" $PROFILE
  aws iam list-users \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"011" )
  echo "===== AWS IAM List Roles:" $PROFILE
  aws iam list-roles \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"012" )
  echo "===== AWS IAM List Groups:" $PROFILE
  aws iam list-groups \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"013" )
  echo "===== AWS IAM List Policies:" $PROFILE
  aws iam list-policies \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"014" )
  echo "===== AWS IAM List Access Keys:" $PROFILE
  aws iam list-access-keys \
    --user-name terence.chia
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"020" )
  echo "===== AWS ORGANIZATIONS  List Accounts:" $PROFILE
  aws organizations list-accounts \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"021" )
  echo "===== AWS ORGANIZATIONS  List Roots:" $PROFILE
  aws organizations list-roots \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"030" )
  echo "===== AWS ec2 List Regions:" $PROFILE
  aws ec2 describe-regions \
    --query 'Regions[].RegionName' \
    --output $OUTPUT \
    --profile $PROFILE;
  ;;


"031" )
  echo "===== AWS ec2 List Instances:" $PROFILE
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

"032" )
  echo "===== AWS ec2 List Instances Detailed:" $PROFILE
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


"033" )
  echo "===== AWS EC2 List Images" $PROFILE
  aws ec2 describe-images \
    --owners self \
    --query 'reverse(sort_by(Images,&CreationDate))[:5].{id:ImageId,date:CreationDate}' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"034" )
  echo "===== AWS EC2 Describe Security Groups:" $PROFILE
  aws ec2 describe-security-groups \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"040" )
  echo "===== AWS EC2 Describe NAT Gateways:" $PROFILE
  aws ec2 describe-nat-gateways \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"041" )
  echo "===== AWS EC2 Describe VPCs:" $PROFILE
  aws ec2 describe-vpcs \
    --profile $PROFILE \
    --output table
  ;;



"042" )
  echo "===== AWS EC2 Describe Transit Gateways:" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"060" )
  echo "===== AWS Lambda Get Account Settings:" $PROFILE
  aws lambda get-account-settings \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"061" )
  echo "===== AWS Lambda List Functions:" $PROFILE
  aws lambda list-functions \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"062" )
  echo "===== AWS Lambda List Layers:" $PROFILE
  aws lambda list-layers \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"070" )
  echo "===== AWS Dynamo xxx:" $PROFILE
  aws dynamo \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"080" )
  echo "===== AWS EMR list-cluster:" $PROFILE
  aws emr list-clusters \
    --active \
    --profile $PROFILE \
    --output table
  ;;


"081" )
  echo "===== AWS EMR list-instances:" $PROFILE
  aws emr list-instances \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"082" )
  echo "===== AWS EMR list-steps:" $PROFILE
  aws emr list-steps \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"083" )
  echo "===== AWS EMR describe-cluster:" $PROFILE
  aws emr describe-cluster \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"084" )
  echo "===== AWS EMR describe-steps:" $PROFILE
  aws emr describe-steps \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"110" )
  echo "===== AWS CLOUDWATCH List Metrics:" $PROFILE
  aws cloudwatch list-metrics \
    --namespace "AWS/Lambda" \
    --profile $PROFILE \
    --output text
  ;;


"111" )
  echo "===== AWS CLOUDWATCH List Dashboards:" $PROFILE
  aws cloudwatch list-dashboards \
    --profile $PROFILE \
    --output table
  ;;


"112" )
  echo "===== AWS CLOUDWATCH Describe Alarms:" $PROFILE
  aws cloudwatch describe-alarms \
    --profile $PROFILE \
    --output table
  ;;


"200" )
  echo "===== AWS cloudfront list-distributions:" $PROFILE
  aws cloudfront list-distributions \
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


