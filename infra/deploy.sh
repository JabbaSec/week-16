#! /usr/bin/env bash

set -eo pipefail

## Check AWS creds
#if [! aws sts get-caller-identity]; then
#    echo >&2 "aws creds not working"
#    exit 2
#fi

## Deploys the networking stack
if [[ -z "${STUDENT_NAME}" ]]; then
  echo "STUDENT_NAME is not set"
  exit 1
fi

readonly STACK_NAME="${STUDENT_NAME}-networking"
readonly TEMPLATE_FILE="$(dirname "${BASH_SOURCE[0]}")/cloudformation.yml"
readonly AWS_DEFAULT_REGION="eu-west-2"

aws cloudformation deploy \
  --stack-name "${STACK_NAME}" \
  --template-file "${TEMPLATE_FILE}" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset \
  --tags "Project=week-16" "Environment=Dev" "StudentName=${STUDENT_NAME}" \
  --region "${AWS_DEFAULT_REGION}" \
  --parameter-overrides "file://networking-params.json" 