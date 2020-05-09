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
echo 003 : AWS STS Assume Role
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
echo 070 : AWS Dynamo list-tables
echo 071 : AWS Dynamo create-table
echo 072 : AWS Dynamo delete-table
echo 073 : AWS Dynamo create-backup
echo ----------------------------------------------
echo 080 : AWS STS xxx
echo 081 : AWS STS xxx
echo ----------------------------------------------
echo 090 : AWS SES send-email
echo 091 : AWS SES xxx
echo ----------------------------------------------
echo 100 : AWS Lambda Account Settings
echo 101 : AWS Lambda List Functions
echo 102 : AWS Lambda List Layers
echo ----------------------------------------------
echo 150 : AWS APIGATEWAY get-rest-apis
echo 151 : AWS APIGATEWAY xxx
echo 152 : AWS APIGATEWAY xxx
echo ----------------------------------------------
echo 150 : AWS DataPipeline list-pipelines
echo 151 : AWS DataPipeline xxx
echo 152 : AWS DataPipeline xxx
echo ----------------------------------------------
echo 400 : AWS EMR list-cluster
echo 401 : AWS EMR list-instances
echo 402 : AWS EMR list-steps
echo 403 : AWS EMR describe-cluster
echo 403 : AWS EMR describe-step
echo ----------------------------------------------
echo 500 : AWS EC2 describe-vpcs
echo 501 : AWS EC2 describe-subnets
echo 502 : AWS EC2 describe-vpn-gateways
echo 503 : AWS EC2 describe-nat-gateways
echo 504 : AWS EC2 describe-transit-gateways
echo 505 : AWS EC2 describe-route-tables
echo 506 : AWS EC2 xxx
echo ----------------------------------------------
echo 610 : AWS Cloudwatch List Metrics
echo 611 : AWS Cloudwatch List Dashboards
echo 612 : AWS Cloudwatch Describe Alarms
echo ----------------------------------------------
echo 630 : AWS CloudTrail xxx
echo ----------------------------------------------
echo 700 : AWS cloudfront list-distributions
echo ----------------------------------------------
echo 900 : AWS cloudformation list-stacks completed
echo 901 : AWS cloudformation create-stack
echo 902 : AWS cloudformation delete-stack
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


"070" )
  echo "===== AWS Dynamo list-tables:" $PROFILE
  aws dynamodb list-tables \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"071" )
  echo "===== AWS Dynamo create-table:" $PROFILE
  aws dynamodb create-table \
    --table-name MusicCollection \
    --attribute-definitions \
      AttributeName=Artist,AttributeType=S \
      AttributeName=SongTitle,AttributeType=S \
    --key-schema \
      AttributeName=Artist,KeyType=HASH \
      AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput \
      ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"072" )
  echo "===== AWS Dynamo delete-table:" $PROFILE
  aws dynamodb delete-table \
    --table-name MusicCollection \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"073" )
  echo "===== AWS Dynamo create-backup:" $PROFILE
  aws dynamodb create-backup \
    --table-name DeltaMergeMetadata \
    --backup-name DMMDBackup \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"080" )
  echo "===== AWS STS get-session-token:" $PROFILE
  aws sts xxx \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"081" )
  echo "===== AWS STS xxx:" $PROFILE
  aws sts xxx \
    --profile $PROFILE \
    --output $OUTPUT
  ;;



"090" )
  echo "===== AWS SES send-email:" $PROFILE
  echo "===== Make sure source and destination emails are verified"
  aws ses send-email \
    --from terence.chia@capgemini.com \
    --destination file://ses/destination.json \
    --message file://ses/message.json \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"100" )
  echo "===== AWS Lambda Get Account Settings:" $PROFILE
  aws lambda get-account-settings \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"101" )
  echo "===== AWS Lambda List Functions:" $PROFILE
  aws lambda list-functions \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"102" )
  echo "===== AWS Lambda List Layers:" $PROFILE
  aws lambda list-layers \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"150" )
  echo "===== AWS APIGATEWAY get-rest-apis:" $PROFILE
  aws apigateway get-rest-apis \
    --profile $PROFILE \
    --output json
  ;;


"400" )
  echo "===== AWS EMR list-cluster:" $PROFILE
  aws emr list-clusters \
    --active \
    --profile $PROFILE \
    --output table
  ;;


"401" )
  echo "===== AWS EMR list-instances:" $PROFILE
  aws emr list-instances \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"402" )
  echo "===== AWS EMR list-steps:" $PROFILE
  aws emr list-steps \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"403" )
  echo "===== AWS EMR describe-cluster:" $PROFILE
  aws emr describe-cluster \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;


"404" )
  echo "===== AWS EMR describe-steps:" $PROFILE
  aws emr describe-steps \
    --cluster-id $EMR_CLUSTER_ID \
    --profile $PROFILE \
    --output table
  ;;

"500" )
  echo "===== AWS VPC describe-vpcs:" $PROFILE
  aws ec2 describe-vpcs \
    --profile $PROFILE \
    --output table
  ;;


"501" )
  echo "===== AWS VPC describe-subnets:" $PROFILE
  aws ec2 describe-subnets \
    --profile $PROFILE \
    --output table
  ;;


"502" )
  echo "===== AWS VPC describe-vpn-gateways:" $PROFILE
  aws ec2 describe-vpn-gateways \
    --profile $PROFILE \
    --output table
  ;;


"503" )
  echo "===== AWS VPC describe-nat-gateways:" $PROFILE
  aws ec2 describe-nat-gateways \
    --profile $PROFILE \
    --output table
  ;;


"504" )
  echo "===== AWS VPC describe-transit-gateways:" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output table
  ;;

"505" )
  echo "===== AWS VPC describe-route-tables:" $PROFILE
  aws ec2 describe-route-tables \
    --profile $PROFILE \
    --output table
  ;;

"506" )
  echo "===== AWS VPC describe-transit-gateways:" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output table
  ;;


"610" )
  echo "===== AWS CLOUDWATCH List Metrics:" $PROFILE
  aws cloudwatch list-metrics \
    --namespace "AWS/Lambda" \
    --profile $PROFILE \
    --output text
  ;;


"611" )
  echo "===== AWS CLOUDWATCH List Dashboards:" $PROFILE
  aws cloudwatch list-dashboards \
    --profile $PROFILE \
    --output table
  ;;


"612" )
  echo "===== AWS CLOUDWATCH Describe Alarms:" $PROFILE
  aws cloudwatch describe-alarms \
    --profile $PROFILE \
    --output table
  ;;



"630" )
  echo "===== AWS CLOUDTRAIL List Trails:" $PROFILE
  aws cloudwatch list-trails \
    --profile $PROFILE \
    --output text
  ;;


"700" )
  echo "===== AWS cloudfront list-distributions:" $PROFILE
  aws cloudfront list-distributions \
    --profile $PROFILE \
    --output table
  ;;


"900" )
  echo "===== AWS cloudformation list-stacks - completed:" $PROFILE
  aws cloudformation list-stacks \
    --stack-status-filter CREATE_COMPLETE \
    --profile $PROFILE \
    --output table
  ;;


"901" )
  echo "===== AWS cloudformation create-stack:" $PROFILE
  aws cloudformation create-stack \
    --stack-name terencetest \
    --template-body file://cf/s3_bucket.yaml \
    --profile $PROFILE \
    --output table
  ;;


"902" )
  echo "===== AWS cloudformation delete-stack:" $PROFILE
  aws cloudformation delete-stack \
    --stack-name terencetest \
    --profile $PROFILE \
    --output table
  ;;


"410" )
  echo "===== AWS CLOUDWATCH List Metrics:" $PROFILE
  aws cloudwatch list-metrics \
    --namespace "AWS/Lambda" \
    --profile $PROFILE \
    --output text
  ;;


"411" )
  echo "===== AWS CLOUDWATCH List Dashboards:" $PROFILE
  aws cloudwatch list-dashboards \
    --profile $PROFILE \
    --output table
  ;;


"412" )
  echo "===== AWS CLOUDWATCH Describe Alarms:" $PROFILE
  aws cloudwatch describe-alarms \
    --profile $PROFILE \
    --output table
  ;;



"430" )
  echo "===== AWS CLOUDTRAIL List Trails:" $PROFILE
  aws cloudwatch list-trails \
    --profile $PROFILE \
    --output text
  ;;


"500" )
  echo "===== AWS cloudfront list-distributions:" $PROFILE
  aws cloudfront list-distributions \
    --profile $PROFILE \
    --output table
  ;;


"900" )
  echo "===== AWS cloudformation list-stacks - completed:" $PROFILE
  aws cloudformation list-stacks \
    --stack-status-filter CREATE_COMPLETE \
    --profile $PROFILE \
    --output table
  ;;


"901" )
  echo "===== AWS cloudformation create-stack:" $PROFILE
  aws cloudformation create-stack \
    --stack-name terencetest \
    --template-body file://cf/s3_bucket.yaml \
    --profile $PROFILE \
    --output table
  ;;


"902" )
  echo "===== AWS cloudformation delete-stack:" $PROFILE
  aws cloudformation delete-stack \
    --stack-name terencetest \
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



