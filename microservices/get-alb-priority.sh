#!/bin/bash

LISTENER=$(aws cloudformation list-exports --query "Exports[?Name==\`${ENVIRONMENT_NAME}:PublicLoadBalancerListenerArn\`].Value" --output text)
echo "LISTENER: $LISTENER"

PRIORITY=$(aws elbv2 describe-rules \
              --region ${AWS_DEFAULT_REGION} \
              --listener-arn "${LISTENER}" \
              | jq -r "[.Rules[].Priority][0:-1] | map(.|tonumber) | max + 1 ")
echo "PRIORITY: $PRIORITY"