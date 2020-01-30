#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Creating Task Execution Role
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-${APP_NAME}-role" \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-file "${DIR}/ecs-app-role.yaml"  \
    --no-fail-on-empty-changeset \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    TaskExecutionRoleName="${ENVIRONMENT_NAME}-${APP_NAME}-ecsTER" \
    AppName="${APP_NAME}"


# Checking custom policy file of the project
if [ -f "${DIR}/${APP_NAME}/${ENVIRONMENT_NAME}/policy.yaml" ]; then 
    source ${DIR}/custom-policy.sh
fi
