#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Creating Role fo application
source ${DIR}/create-roles.sh

# Creating App Pipeline
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${APP_NAME}-pipeline" \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-file "${DIR}/app-pipeline.yaml"  \
    --no-fail-on-empty-changeset \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    AppName="${APP_NAME}"
