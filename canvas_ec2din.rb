#!/usr/bin/ruby -w
# canvas_ec2din.rb
# Author: Andy Bettisworth
# Description: Canvas ec2-api-tools package

## LINK http://joemaller.com/990/a-web-focused-git-workflow/
## LINK http://danbarber.me/using-git-for-deployment/

## Add Remote hub
# git remote add hub ubuntu@accreu.com:~/.hub/accreu.git

## SET credentials [~/.bashrc]
## Set \$EC2_HOME for ec2-api-tools
# export EC2_HOME=/usr/bin
# export EC2_PRIVATE_KEY=/media/Annex/preseed/seed/.sync/.app/.keypair/ec2-wurde-private-key.pem
# export EC2_CERT=/media/Annex/preseed/seed/.sync/.app/.keypair/ec2-wurde-cert.pem

## SET ec2 instance credentials
# ssh-add /media/Annex/preseed/seed/.sync/.app/keypair/accreu-keypair

## RESOLVE conflicts
## NOTE create branch on hub with conflict, use clones to pull fixme branch
# git push hub master:refs/heads/fixme

## Secure Copy Files
# scp -i /path/to/keypair.pem ubuntu@domain.com:~/file-to-import ~/Desktop
# scp -i /path/to/keypair.pem file-to-export ubuntu@domain.com:~/apps/accreu/

#############################
### LAUNCHING AN INSTANCE ###
## CREATE a keypair
# ec2-create-keypair --region us-west-2 accreu-keypair > accreu-keypair.pem
# chmod 400 accreu-keypair.pem

  ## READ an old security-group
  # ec2-describe-group --region us-west-2
## ~OR~
  ## CREATE a security-group
  # ec2-create-group accreu --region us-west-2 -d "My accreu security group"
  ## CREATE permissions
  # GET IP Address at LINK http://checkip.amazonaws.com/
  # ec2-authorize --region us-west-2 -p 22 -s 98.200.189.208/32 accreu

## CREATE an instance
# ec2-run-instances --region us-west-2 ami-6aad335a -t t1.micro -g accreu-security -k accreu-keypair
#=> RESERVATION r-2177f128  280638226111  open_gates
#=> INSTANCE  i-060c860f  ami-6aad335a      pending   0   t1.micro  2014-02-21T16:48:16+0000  us-west-2b  aki-fc37bacc      monitoring-disabled ebs         paravirtual xen   sg-c84940f8 default
## NOTE Ubuntu Server 12.04.3 LTS - ami-6aad335a (64-bit) / ami-68ad3358 (32-bit)
## NOTE Ubuntu Server 13.10       - ami-ace67f9c (64-bit) / ami-aae67f9a (32-bit)
### LAUNCHING AN INSTANCE ###
#############################

## READ instance(s) details
# ec2-describe-instances --region us-west-2 i-002aa109

## READ instance output
# ec2-get-console-output --region us-west-2 i-002aa109

## CONNECT to an instance
# ssh -i accreu-keypair.pem ubuntu@ec2-xx-xxx-xx-xxx.us-west-2.compute.amazonaws.com
#=> The authenticity of host 'ec2-xx-xxx-xx-xxx.us-west-2.compute.amazonaws.com (54.184.70.22)' can't be established.
#=> ECDSA key fingerprint is 64:2e:d6:58:57:5c:6e:5a:7c:25:e1:ad:e8:aa:8c:e3.
#=> Are you sure you want to continue connecting (yes/no)? yes
#=> Warning: Permanently added 'ec2-54-184-70-22.us-west-2.compute.amazonaws.com,54.184.70.22' (ECDSA) to the list of known hosts.
#=> Welcome to Ubuntu 12.04.3 LTS (GNU/Linux 3.2.0-54-virtual x86_64)

########################
### MANAGE INSTANCES ###

## EXEC start
# ec2-start-instances --region us-west-2 i-5b38b352

## EXEC stop
# ec2-stop-instances --region us-west-2 i-5b38b352

## EXEC reboot
# ec2-reboot-instances --region us-west-2 i-5b38b352

## EXEC terminate
# ec2-terminate-instances --region us-west-2 i-5b38b352

# associate-address, allocate-address

## NOTE you can string instances as an array (e.g. [i-7b38ae52, i-5b38b352, i-cb36b352,...])

### MANAGE INSTANCES ###
########################

##############################
### MANAGE SECURITY GROUPS ###

## READ all security groups
# ec2-describe-group --region us-west-2
#=> GROUP sg-784a4348 280638226111  accreu-security My accreu security group
#=> PERMISSION  280638226111  accreu-security ALLOWS  tcp 22  22  FROM  CIDR  0.0.0.0/0 ingress
#=> GROUP sg-b3b4f583 280638226111  default default group
#=> PERMISSION  280638226111  default ALLOWS  tcp 22  22  FROM  CIDR  0.0.0.0/0 ingress

## READ target security group
# ec2-describe-group --region us-west-2 open_gates
#=> GROUP sg-c84940f8 280638226111  open_gates  Login to EC2
#=> PERMISSION  280638226111  open_gates  ALLOWS  tcp 22  22  FROM  CIDR  0.0.0.0/0 ingress

## CREATE a security-group
# ec2-create-group --region us-west-2 -d "No one enters, no one exits." accreu-security
#=> GROUP sg-784a4348 accreu-security No one enters, no one exits.

## CREATE permissions
# ec2-authorize group [--egress] [-P protocol] (-p port_range | -t icmp_type_code) [-u source_or_dest_group_owner ...] [-o source_or_dest_group ...] [-s source_or_dest_cidr ...]
# ec2-authorize --region us-west-2 -p 22 open_gates
# ec2-authorize --region us-west-2 accreu -p 22 -s 98.XXX.XXX.XXX/XX
  # GET your IP Address at LINK http://checkip.amazonaws.com/
# ec2-authorise --region us-west-2 accreu-security -p 22 accreu-security
#=> GROUP     accreu-security
#=> PERMISSION    accreu-security ALLOWS  tcp 22  22  FROM  CIDR  0.0.0.0/0 ingress

## DELETE permissions
# ec2-revoke group [--egress] [-P protocol] (-p port_range | -t icmp_type_code) [-u source_or_dest_group_owner ...] [-o source_or_dest_group ...] [-s source_or_dest_cidr ...]
# ec2-revoke --region us-west-2 -p 22 accreu-security
#=> GROUP     accreu-security
#=> PERMISSION    accreu-security ALLOWS  tcp 22  22  FROM  CIDR  0.0.0.0/0 ingress

## DELETE a security group
# ec2-delete-group --region us-west-2 accreu-security
#=> RETURN  true

### MANAGE SECURITY GROUPS ###
##############################

#######################
### MANAGE KEYPAIRS ###

## CREATE keypair
# ec2-create-keypair --region us-west-2 blah-keypair > blah-keypair.pem
## NOTE to place these within Annex

## READ all keypairs
# ec2-describe-keypairs --region us-west-2
#=> KEYPAIR accreu-keypair  f4:b1:23:ac:a7:7e:96:b3:cf:bf:aa:4a:4b:1a:a2:27:bc:ef:f1:ab
#=> KEYPAIR accreu-keypair  d7:d7:25:68:47:41:6d:b2:18:17:32:b8:32:69:ca:1b:ff:f3:b4:99

## READ local key fingerprint
# ec2-fingerprint-key blah-keypair.pem
#=> 63:3b:b8:e8:65:da:24:04:6b:6d:7c:ac:41:5e:09:42:2f:a0:12:17

## DELETE keypair
# ec2-delete-keypair --region us-west-2 blah-keypair
#=> KEYPAIR blah-keypair

### MANAGE KEYPAIRS ###
#######################


##########################
### MANAGE Elastic IPs ###
## GET address
# ec2-allocate-address [-d domain]
# ec2-allocate-address --region us-west-2 -d accreu.com

## READ addresses
# ec2-describe-addresses [public_ip ... | allocation_id ...] [[--filter "name=value"] ...]
# ec2-describe-addresses --region us-west-2
#=> ADDRESS 54.214.10.153 i-fc13b6ca  standard

## SET address
# ec2-associate-address [-i instance_id | -n interface_id] [ip_address | -a allocation_id] [--private-ip-address private_ip_address] [--allow-reassociation]


### MANAGE Elastic IPs ###
##########################

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


###########
### AMI ###

## Q: what is an ami
# a: Amazon Machine Image
# a: LINK http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html
# a: includes
    # A template for the root volume for the instance
    # Launch permissions that control which AWS accounts can use the AMI to launch instances
    # A block device mapping that specifies the volumes to attach to the instance when it's launched

## AMI lifecycle
# create (template for root volume)
# register
# deregister
# launch
# copy

## AMI Types
# LINK http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ComponentsAMIs.html

## Search AMIs
# LINK http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html

## AMIs
#     ec2-copy-image
#     ec2-create-image
#     ec2-deregister
#     ec2-describe-image-attribute
#     ec2-describe-images
#     ec2-migrate-image
#     ec2-modify-image-attribute
#     ec2-register
#     ec2-reset-image-attribute

## AMI Bundling (API Tools)
#     ec2-bundle-image
#     ec2-bundle-vol
#     ec2-delete-bundle
#     ec2-download-bundle
#     ec2-migrate-bundle
#     ec2-migrate-manifest
#     ec2-unbundle
#     ec2-upload-bundle

### AMI ###
###########
