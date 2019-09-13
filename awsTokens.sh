getAwsTokens() {
  NB_PARAMS=$#
  MFA_ARN=$1
  MFA_CODE=$2
  
  if [ $NB_PARAMS != 1 ]; then;
    echo "USAGE : $0 <<YOUR MFA ARN>> <<YOUR MFA CODE>>"
    return
  fi

  echo "1. Resetting env vars"
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN

  echo "2. Authentication with MFA of : $MFA_ARN with MFA code: $MFA_CODE"
  API_RESULT=$(aws sts get-session-token --serial-number $MFA_ARN --token-code $MFA_CODE) 
  RETURN_CODE=$(echo $?)
  if [ $RETURN_CODE != 0 ]; then;
    echo "ERROR in AWS authentication";
    return;
  fi

  AWS_ACCESS_KEY_ID=$(echo $API_RESULT | jq --raw-output .Credentials.AccessKeyId)
  AWS_SECRET_ACCESS_KEY=$(echo $API_RESULT | jq --raw-output .Credentials.SecretAccessKey)
  AWS_SESSION_TOKEN=$(echo $API_RESULT | jq --raw-output .Credentials.SessionToken)

  echo "3. Setting up credentials in env vars"
  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN

  echo "4. Display AWS Env vars"
  set | grep AWS
}