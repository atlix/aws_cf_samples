#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ -z "${APP_IMAGE}" ]; then
    echo "APP_IMAGE environment is not defined"
    exit 1
fi

if [ -z "${APP_NAME}" ]; then
    echo "APP_NAME environment is not defined"
    exit 1
fi

stack_output=$(aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation describe-stacks --stack-name "${ENVIRONMENT_NAME}-${APP_NAME}-role" \
    | jq '.Stacks[].Outputs[]')

execution_role_arn=($(echo $stack_output \
    | jq -r 'select(.OutputKey == "TaskExecutionIamRoleArn") | .OutputValue'))

awslogs_group="/ecs/${ENVIRONMENT_NAME}-${APP_NAME}"

task_def_json=$(jq -n \
    --arg NAME "${ENVIRONMENT_NAME}-$APP_NAME" \
    --arg APP_NAME $APP_NAME \
    --arg APP_IMAGE $APP_IMAGE \
    --arg AWS_REGION $AWS_DEFAULT_REGION \
    --arg EXECUTION_ROLE_ARN $execution_role_arn \
    --arg AWSLOGS_GROUP $awslogs_group \
    -f "${DIR}/${APP_NAME}/${ENVIRONMENT_NAME}/task-def.json")

task_def=$(aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    ecs register-task-definition \
    --cli-input-json "$task_def_json")

app_task_def_arn=($(echo $task_def \
    | jq -r '.taskDefinition | .taskDefinitionArn'))

