#!/bin/bash
#Author_JATIN
#MakeSureYouConfigureYourAWSCLI
#PassArgument: Username, Password, Group(IAM Group)


set -e

  user=${1}
  password=${2}
  group=${3}

  aws iam create-user --user-name $user

echo "=======User Name Created========"  

  aws iam create-login-profile --user-name  $user --password  $password --password-reset-required

echo "===========login-profile Created============"

  aws iam add-user-to-group --user-name $user --group-name $group

echo "==================$user Created==================="
~

# Run script command: sh iam-user-creation.sh testuser Password@123456 Admin
