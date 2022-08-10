SHELL := /bin/bash

compile:
	chmod +x ./gradlew
	./gradlew clean build jacocoTestReport jacocoTestCoverage

unit:
	chmod +x ./gradlew
	./gradlew clean test

integration:
	chmod +x ./gradlew
	./gradlew clean integration

docker: compile
	docker build -t build-status . && \
	docker tag build-status roioteromorales/build-status:latest && \
	docker push roioteromorales/build-status:latest

xray_build:
	docker pull amazon/aws-xray-daemon:3.x

xray_run:
	docker run --rm -it --attach STDOUT -v ~/.aws/:/root/.aws/:ro -e AWS_REGION=us-east-2 --name xray-daemon -p 2000:2000 xray-daemon

xray_remove:
	docker stop xray-daemon && \
    docker rm xray-daemon

#SHELL := /bin/bash

# Requires AWS CLI to be setup externally with correct profile and a user with access to ECR
# Build account ID needs to be provided as an environment variable

#AWS_REGION=***
#AWS_ACCOUNT_ID_BUILD=******
#GITHUB_COMMIT_HASH?=$(shell git rev-parse --verify HEAD)
#
#REPOSITORY?=***
#PREFIX=***
#API_PREFIX=***
#APP_NAME?=***
#APP_VERSION?=latest
#
#ENV?=dev
#
#CONTAINER_TAG=$(AWS_ACCOUNT_ID_BUILD).dkr.ecr.$(AWS_REGION).amazonaws.com/$(REPOSITORY)/$(PREFIX)-$(APP_NAME)
#
#ecr-login:
# @{ \
# echo "Logging into ECR in $(AWS_REGION)/$(AWS_ACCOUNT_ID_BUILD)..."; \
# LOGIN_COMMAND=$$(aws ecr get-login --no-include-email --region $(AWS_REGION) --registry-ids $(AWS_ACCOUNT_ID_BUILD)); \
# $$LOGIN_COMMAND; \
# }
#
#compile:
# @export CODEARTIFACT_AUTH_TOKEN=$(shell aws codeartifact get-authorization-token --domain prod --domain-owner *** --query authorizationToken --output text --region eu-west-1) && \
# ./gradlew $$GRADLE_PROXY clean build jacocoTestReport jacocoTestCoverage
#
#sonar-master:
# ./gradlew $$GRADLE_PROXY sonarqube
#
#sonar-pr:
# ./gradlew $$GRADLE_PROXY sonarqube -Dsonar.pullrequest.branch=$(DRONE_SOURCE_BRANCH) -Dsonar.pullrequest.base=$(DRONE_TARGET_BRANCH) -Dsonar.pullrequest.key=$(DRONE_PULL_REQUEST)
#
#pact-consumer:
# ./gradlew $$GRADLE_PROXY pactConsumer
#
#pact-provider:
# ./gradlew $$GRADLE_PROXY pactProvider
#
#pact-consumer-publish:
# ./gradlew $$GRADLE_PROXY pactConsumer && \
# ./gradlew $$GRADLE_PROXY pactConsumerPublish
#
#pact-provider-publish:
# ./gradlew $$GRADLE_PROXY pactProviderPublishResult
#
#docker-build: compile
# echo "Container: $(CONTAINER_TAG)" && \
# echo "Build Num: $(GITHUB_COMMIT_HASH)" && \
# docker build -t $(CONTAINER_TAG):$(GITHUB_COMMIT_HASH) . && \
# docker build -t $(CONTAINER_TAG):latest .
#
#docker-push: ecr-login
# docker push $(CONTAINER_TAG):$(GITHUB_COMMIT_HASH) && \
# docker push $(CONTAINER_TAG):latest
#
#docker: docker-build docker-push
# @echo "Build and push complete"
#
#tag:
# git tag v0.1.${GITHUB_COMMIT_HASH}
# git push origin --tags
#
#.ONESHELL:
#terraform-plan:
# cd $(LOCATION) && \
# terraform init -backend-config="./backend_config/$(ENV).tfvars" && \
# terraform plan -var-file "./env_vars/$(ENV).tfvars" --out ./build.plan && \
# unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN;
#
#.ONESHELL:
#terraform-apply:
# cd $(LOCATION) && \
# terraform apply ./build.plan && \
# rm ./build.plan
#
#.ONESHELL:
#terraform-destroy:
# cd $(LOCATION) && \
# terraform init -backend-config="./backend_config/$(ENV).tfvars" --reconfigure && \
# terraform plan --destroy -var-file "./env_vars/$(ENV).tfvars" --out ./build.plan && \
# terraform apply ./build.plan && \
# rm ./build.plan && \
# unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN;
#
#tf-service-plan: LOCATION = tf/service
#tf-service-plan: terraform-plan
#
#tf-service-apply: LOCATION = tf/service
#tf-service-apply: terraform-apply
#
#tf-service-destroy: LOCATION = tf/service
#tf-service-destroy: terraform-destroy
#
#tf-container-plan: LOCATION = tf/container
#tf-container-plan: ENV = build
#tf-container-plan: terraform-plan
#
#tf-container-apply: LOCATION = tf/container
#tf-container-apply: ENV = build
#tf-container-apply: terraform-apply
#
#tf-container-destroy: LOCATION = tf/container
#tf-container-destroy: ENV = build
#tf-container-destroy: terraform-destroy
#
#.ONESHELL:
#apigw-deploy:
# cd tf/service && export ENV=$(ENV) && export AWS_REGION=$(AWS_REGION) && /opt/deploy-scripts/apigw-deploy.sh
#
#.ONESHELL:
#check-vulns:
# export AWS_DEFAULT_REGION=$(AWS_REGION) && python3 /opt/deploy-scripts/check-image-vulns.py || exit 1
#
#.ONESHELL:
#tag-ecr-image:
# export AWS_DEFAULT_REGION=$(AWS_REGION) && python3 /opt/deploy-scripts/ecr-tag.py
#
#all: docker deploy
#
#deploy:
# ecs-deploy -t 600 -r $(AWS_REGION) --use-latest-task-def -a arn:aws:iam::$$AWS_ACCOUNT_ID:role/$$AWS_IAM_ROLE -c $(API_PREFIX) -n $(API_PREFIX)-$(APP_NAME) -i $(CONTAINER_TAG):$(DRONE_COMMIT)
#
#release: #make sure that you have the red-scripts project in your path (export PATH=$PATH:<YOUR_FOLDER>/red-scripts/)
# release $(PREFIX)-$(APP_NAME)