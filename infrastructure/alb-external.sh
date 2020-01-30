#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

aws --profile "${AWS_PROFILE}" --region "${AWS_DEFAULT_REGION}" \
    cloudformation deploy \
    --stack-name "${ENVIRONMENT_NAME}-external-lb" \
    --capabilities CAPABILITY_IAM \
    --template-file "${DIR}/alb-external.yaml" \
    --parameter-overrides \
    EnvironmentName="${ENVIRONMENT_NAME}" \
    LoadBalancerName="${ENVIRONMENT_NAME}-external-lb" \
    CertificateArn="${LB_CERTIFICATE_ARN}"
