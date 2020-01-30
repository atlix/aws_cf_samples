#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Creating change set with custom policy for role
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-${APP_NAME}-role" \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-file "${DIR}/${APP_NAME}/${ENVIRONMENT_NAME}/policy.yaml"  \
    --parameter-overrides \
    AppName="${APP_NAME}" \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    TaskExecutionRoleName="${ENVIRONMENT_NAME}-${APP_NAME}-ecsTER"
