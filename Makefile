SHELL=/bin/bash

ifeq (${ELEMENT},)
	echo "Please, provide ELEMENT variable"
endif

ifeq (${ENV},)
	echo "Please, provide ENV variable: dev | stage | prod"
endif

ifeq (${REGION},)
	REGION = us-east-1
endif

copy-config: 
	cp providers.tf ${ELEMENT}/

init: copy-config
	cd ${ELEMENT} && \
	terraform init -upgrade -backend-config=envs/${ENV}/backend.hcl

plan: copy-config
	cd ${ELEMENT} && \
	terraform plan -var="region=${REGION}" -var-file envs/${ENV}/${ENV}.tfvars $(foreach target, ${TARGETS}, -target=${target}) -out=${ELEMENT}.tfplan

apply: copy-config
	cd ${ELEMENT} && \
	terraform apply "${ELEMENT}.tfplan"

destroy-plan: copy-config
	cd ${ELEMENT} && \
	terraform plan -destroy -var="region=${REGION}" -var-file envs/${ENV}/${ENV}.tfvars $(foreach target, ${TARGETS}, -target=${target}) -out=destroy_${ELEMENT}.tfplan

destroy: copy-config
	cd ${ELEMENT} && \
	terraform apply "destroy_${ELEMENT}.tfplan"

import: copy-config
	cd ${ELEMENT} && \
	terraform plan -generate-config-out=generated_config.tf -out=${ELEMENT}.tfplan

help:
	echo "Required vars are ELEMENT, REGION and TARGETS (space-separated, if more then 1)"

.PHONY: copy-config init plan apply help