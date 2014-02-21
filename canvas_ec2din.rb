#!/usr/bin/ruby -w
# canvas_ec2din.rb
# Author: Andy Bettisworth
# Description: Canvas ec2-api-tools package

#############################
### LAUNCHING AN INSTANCE ###
## CREATE a keypair
# ec2-create-keypair --region us-west-2 bookworm-keypair > bookworm-keypair.pem
# chmod 400 bookworm-keypair.pem

## CREATE a security-group
# ec2-create-group bookworm --region us-west-2 -d "My Bookworm security group"
# GET IP Address at LINK http://checkip.amazonaws.com/
# ec2-authorize --region us-west-2 bookworm -p 22 -s 98.200.189.208/32

## CREATE an instance
# ec2-run-instances --region us-west-2 ami-6aad335a -t t1.micro -g bookworm
# NOTE Ubuntu Server 12.04.3 LTS - ami-6aad335a (64-bit) / ami-68ad3358 (32-bit)
# NOTE Ubuntu Server 13.10 - ami-ace67f9c (64-bit) / ami-aae67f9a (32-bit)
### LAUNCHING AN INSTANCE ###
#############################

## READ instance(s) details
# ec2-describe-instances --region us-west-2 i-002aa109
# LINK http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-DescribeInstances.html

## READ instance output
# ec2-get-console-output --region us-west-2 i-002aa109
# NOTE most recent 64 KB output which will be available for at least one hour after the most recent post.
# LINK http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-GetConsoleOutput.html

## CONNECT to an instance
# ssh -i /media/Annex/preseed/seed/.sync/.app/.keypair/bookworm-keypair.pem ec2-xx-xxx-xx-xxx.us-west-2.compute.amazonaws.com

########################
### MANAGE INSTANCES ###
## EXEC
# start, reboot, stop, terminate, associate-address, allocate-address
# ec2-run-instances, ec2-start-instances, ec2-stop-instances, ec2-terminate-instances
### MANAGE INSTANCES ###
########################

## AMI Management
# create, publish, register

## LINK https://console.aws.amazon.com/iam/home?#security_credential
## LINK http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html#set-aws-credentials

## Q: how to clone an existing instance
## Q: how to create a new ec2 instance
## Q: how to pause an ec2 instance
## Q: how to set usage limits on an ec2 instance
## Q: how to delete an ec2 instance

## READ all EC2 instances
# Use access key ID (-O, --aws-access-key) and secret access key (-W, --aws-secret-key)
# export AWS_ACCESS_KEY=your-aws-access-key-id
# export AWS_SECRET_KEY=your-aws-secret-key
# source ~/.bashrc
# TEST `ec2-describe-regions`

## SYNOPSIS
#    ec2din ([ec2-describe-instances])
#    ec2din [GENERAL OPTIONS] [INSTANCE [INSTANCE [...]]]
## GENERAL NOTES
#    Any command option/parameter may be passed a value of '-' to indicate
#    that values for that option should be read from stdin.
## DESCRIPTION
#    List and describe your instances
#    The INSTANCE parameter is the instance ID(s) to describe.
#    If unspecified all your instances will be returned.

## GENERAL OPTIONS
#    -K, --private-key KEY
#         Specify KEY as the private key to use. Defaults to the value of the
#         EC2_PRIVATE_KEY environment variable (if set). Overrides the default.

#    -C, --cert CERT
#         Specify CERT as the X509 certificate to use. Defaults to the value
#         of the EC2_CERT environment variable (if set). Overrides the default.

#    -U, --url URL
#         Specify URL as the web service URL to use. Defaults to the value of
#         'https://ec2.amazonaws.com' (us-east-1) or to that of the
#         EC2_URL environment variable (if set). Overrides the default.

#    --region REGION
#         Specify REGION as the web service region to use.
#         This option will override the URL specified by the "-U URL" option
#         and EC2_URL environment variable.

#    -v, --verbose
#         Verbose output.

#    -?, --help
#         Display this help.

#    -H, --headers
#         Display column headers.

#    --debug
#         Display additional debugging information.

#    --show-empty-fields
#         Indicate empty fields.

#    --hide-tags
#         Do not display tags for tagged resources.

#    --connection-timeout TIMEOUT
#         Specify a connection timeout TIMEOUT (in seconds).

#    --request-timeout TIMEOUT
#         Specify a request timeout TIMEOUT (in seconds).

# SPECIFIC OPTIONS

#    -F, --filter FILTER
#         Add a filter criterion for the result-set.


####################
### MANAGE USERS ###
## To manage a user's access keys, use the following commands:
## Create an access key
#   CLI: aws iam create-access-key
#   API: CreateAccessKey
## Disable or re-enable an access key
#   CLI: aws iam update-access-key
#   API: UpdateAccessKey
## List a user's access keys
#   CLI: aws iam list-access-keys
#   API: ListAccessKeys
## Delete an access key
#   CLI: aws iam delete-access-key
#   API: DeleteAccessKey
### MANAGE USERS ###
####################
