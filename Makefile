CURRENT_DIR := $(shell pwd)
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include ${MAKEFILE_DIR}.env
# include .env.secret

AWS := docker run --rm \
	-e AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}" \
	-e AWS_ACCESS_KEY_ID="${AWS_CLI_AWS_ACCESS_KEY_ID}" \
	-e AWS_SECRET_ACCESS_KEY="${AWS_CLI_AWS_SECRET_ACCESS_KEY}" \
	-v .:/aws \
	${IMAGE_NAME}

aws_cli_echo:
	echo "Makefile dir=${MAKEFILE_DIR}"
	echo "current dir=${CURRENT_DIR}"

aws_cli_build:
	docker build \
		--build-arg ORIGINAL_IMAGE_NAME=${ORIGINAL_IMAGE_NAME} \
		-t ${IMAGE_NAME} \
		-f ${MAKEFILE_DIR}Dockerfile ${MAKEFILE_DIR}

aws_cli_version:
	${AWS} --version

aws_cli_test:
	${AWS} sts get-caller-identity \
		|| (echo "aws-cliコマンドテスト失敗\n認証情報を確認してください"; exit 1)
	@echo "aws-cliコマンドテスト成功\nAWSへ認証できることを確認しました"

aws_cli_sh:
	docker run --rm -it -v .:/aws --entrypoint sh ${IMAGE_NAME}

aws_cli_alias:
	@echo "以下をコピーして実行してください。"
	alias aws='${AWS}'
