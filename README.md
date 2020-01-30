# Getting Started
This is sample repository that can help you to launch some services and infrastructure in AWS services.

## Prerequisites
* Install latest [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).

* Export the following environment variables

```
export AWS_PROFILE=<aws-profile for aws-cli>
export AWS_DEFAULT_REGION=<aws-region for aws-cli>
export ENVIRONMENT_NAME=<environment name e.g. sample-prod>
export SERVICES_DOMAIN=<domain under which services will be discovered, e.g. "stage | prod">
```

Sample:
```
export AWS_PROFILE=default
export AWS_DEFAULT_REGION=region
export ENVIRONMENT_NAME=stage
export SERVICES_DOMAIN=stage
export APP_NAME=sample-app
```
* If you want to deploy external ALB, please provide certificate ARN via specific variable

```
export LB_CERTIFICATE_ARN=<Certificate ARN>
```


* When you want to deploy new service, please export the following environment variables
  
```
export APP_NAME=<name of your service in ECS cluster>
export APP_IMAGE=<Docker image URL of your application>
```
  
## ECS
Following steps will setup a VPC and ECS.

* Setup VPC

```
$ ./infrastructure/vpc.sh
```

* Setup ECS Cluster

```
$ ./infrastructure/ecs-cluster.sh
```

## ALB
This script will create ALB in provided region with LB_CERTIFICATE_ARN

```
$ ./infrastructure/alb-external.sh
```

# Application

## Pipeline
This script will create CodeBuild and CodePipeline for App

```
$ ./pipeline/create-pipeline.sh
```
After that you can run CodeBuild and get APP_IMAGE as a result in ECR Repository

## Service
This script will create / register TaskDefinition, create Service in ECS Cluster and deploy App

```
$ ./microservices/ecs-app.sh
```
For each service you should create ./microservice/APP_NAME/ENVIRONMENT_NAME folder with specific files:
- Environment variables for the App: ``` config ```
- Custom policy for the App: ``` policy.yaml ```
- Task definition with specific replacing variables: ``` task-def.json ```
