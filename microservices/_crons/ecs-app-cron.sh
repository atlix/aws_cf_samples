#!/bin/bash

#set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Get project specific variables
source ${DIR}/${APP_NAME}/config

# Deploying the stack
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-${APP_NAME}-cron" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/${APP_NAME}/ecs-app-cron.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    AppName="${APP_NAME}" \
    AppImage="${APP_IMAGE}" \
    AppLogsGroup="/ecs/${ENVIRONMENT_NAME}-${APP_NAME}-cron" \
    AppSubnets="${APP_SUBNETS}"
