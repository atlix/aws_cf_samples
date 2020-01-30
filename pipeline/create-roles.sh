#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Creating Codepipeline and Codebuild Roles
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${APP_NAME}-pipeline-roles" \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-file "${DIR}/app-pipeline-roles.yaml"  \
    --no-fail-on-empty-changeset \
    --parameter-overrides \
    AppName="${APP_NAME}"
