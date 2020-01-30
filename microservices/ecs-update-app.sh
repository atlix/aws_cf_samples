#!/bin/bash

#set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Creating Task Definitions
source ${DIR}/create-task-defs.sh

# Deploying the stack
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    ecs update-service \
    --cluster "${ENVIRONMENT_NAME}" \
    --service "${APP_NAME}" \
    --task-definition "${app_task_def_arn}"
