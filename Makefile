SHELL=/bin/bash

ifeq (${ELEMENT},)
	echo "Please, provide ELEMENT variable"
endif

ifeq (${REGION},)
	REGION = us-east-1
endif

copy-config: 
	cp providers.tf ${ELEMENT}/

init: copy-config
	cd ${ELEMENT} && \
	terraform init -upgrade -backend-config=backend.hcl

plan: copy-config
	cd ${ELEMENT} && \
	terraform plan -var="region=${REGION}" $(foreach target, ${TARGETS}, -target=${target}) -out=${ELEMENT}.tfplan

apply: copy-config
	cd ${ELEMENT}
	terraform apply "${ELEMENT}.tfplan"

help:
	echo "Required vars are ELEMENT, REGION and TARGETS (space-separated, if more then 1)"

.PHONY: copy-config init plan apply help