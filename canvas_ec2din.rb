#!/usr/bin/ruby -w
# capistrano_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas ec2-describe-instance package

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
