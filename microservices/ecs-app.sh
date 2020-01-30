#!/bin/bash

#set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Creating Role fo application
source ${DIR}/create-role.sh

# Creating Task Definitions
source ${DIR}/create-task-defs.sh

# Get project specific variables
source ${DIR}/${APP_NAME}/${ENVIRONMENT_NAME}/config

# Get Priority for ALB rule
source ${DIR}/get-alb-priority.sh

# Deploying the stack
aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-${APP_NAME}" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/ecs-app.yaml"  \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    ECSServicesDomain="${SERVICES_DOMAIN}" \
    AppTaskDefinition="${app_task_def_arn}" \
    AppLogsGroup="${awslogs_group}" \
    AppName="${APP_NAME}" \
    AppPort="${APP_PORT}" \
    AppHealthcheckPort="${APP_HEALTHCHECK_PORT}" \
    LoadBalancer="${LOADBALANCER}" \
    LoadBalancerRulePriority="${PRIORITY}" \
    ServiceDiscoveryName="${APP_SERVICE_DISCOVERY_NAME}" \
    AppHostname="${APP_HOSTNAME}" \
    AppSubnets="${APP_SUBNETS}"
