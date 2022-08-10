SHELL := /bin/bash

compile:
	chmod +x ./gradlew
	./gradlew clean build jacocoTestReport jacocoTestCoverage

unit:
	chmod +x ./gradlew
	./gradlew clean test

docker: compile
	docker build -t build-status . && \
	docker tag build-status roioteromorales/build-status:latest && \
	docker push roioteromorales/build-status:latest
